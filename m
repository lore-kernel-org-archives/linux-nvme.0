From: keith.busch@intel.com (Keith Busch)
Date: Wed, 13 Jul 2016 11:45:02 -0600
Subject: [PATCH v4] nvme: Remove RCU namespace protection
Message-ID: <1468431902-9699-1-git-send-email-keith.busch@intel.com>

We can't sleep with RCU read lock held, but we need to do potentially
blocking stuff to namespace queues when iterating the list. This patch
removes the RCU locking and holds a mutex instead.

To prevent deadlocks, this patch removes holding the mutex during
namespace scanning and removal. The unlocked namespace scanning is made
safe by holding a reference to the namespace being scanned.

List iteration that does IO has to be unlocked to allow error recovery.
The caller must ensure the list can not be manipulated during such an
event, so this patch adds a comment explaining this requirement to the
only function that iterates an unlocked list. All callers currently
meet this requirement, so no further changes required.

List iterations that do not do IO can safely use the lock since it couldn't
block recovery from missing forced IO completions.

Reported-by: Ming Lin <mlin at kernel.org>
[fixes 0bf77e9 nvme: switch to RCU freeing the namespace]
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v3->v4:

  Shortend change log, appened original report and commit that this fixes.

  Removed the sorted list insert. It was not necessary to fix the
  regression, though it may need to be addressed in the next release
  cycle.

 drivers/nvme/host/core.c | 74 +++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a51584..d5fb55c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1394,19 +1394,22 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return nsa->ns_id - nsb->ns_id;
 }
 
-static struct nvme_ns *nvme_find_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
-	struct nvme_ns *ns;
-
-	lockdep_assert_held(&ctrl->namespaces_mutex);
+	struct nvme_ns *ns, *ret = NULL;
 
+	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->ns_id == nsid)
-			return ns;
+		if (ns->ns_id == nsid) {
+			kref_get(&ns->kref);
+			ret = ns;
+			break;
+		}
 		if (ns->ns_id > nsid)
 			break;
 	}
-	return NULL;
+	mutex_unlock(&ctrl->namespaces_mutex);
+	return ret;
 }
 
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
@@ -1415,8 +1418,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct gendisk *disk;
 	int node = dev_to_node(ctrl->dev);
 
-	lockdep_assert_held(&ctrl->namespaces_mutex);
-
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
 		return;
@@ -1457,7 +1458,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (nvme_revalidate_disk(ns->disk))
 		goto out_free_disk;
 
-	list_add_tail_rcu(&ns->list, &ctrl->namespaces);
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_add_tail(&ns->list, &ctrl->namespaces);
+	mutex_unlock(&ctrl->namespaces_mutex);
+
 	kref_get(&ctrl->kref);
 	if (ns->type == NVME_NS_LIGHTNVM)
 		return;
@@ -1480,8 +1484,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
-	lockdep_assert_held(&ns->ctrl->namespaces_mutex);
-
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -1494,8 +1496,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
 	}
+
+	mutex_lock(&ns->ctrl->namespaces_mutex);
 	list_del_init(&ns->list);
-	synchronize_rcu();
+	mutex_unlock(&ns->ctrl->namespaces_mutex);
+
 	nvme_put_ns(ns);
 }
 
@@ -1503,10 +1508,11 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
 
-	ns = nvme_find_ns(ctrl, nsid);
+	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
 		if (revalidate_disk(ns->disk))
 			nvme_ns_remove(ns);
+		nvme_put_ns(ns);
 	} else
 		nvme_alloc_ns(ctrl, nsid);
 }
@@ -1535,9 +1541,11 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 			nvme_validate_ns(ctrl, nsid);
 
 			while (++prev < nsid) {
-				ns = nvme_find_ns(ctrl, prev);
-				if (ns)
+				ns = nvme_find_get_ns(ctrl, prev);
+				if (ns) {
 					nvme_ns_remove(ns);
+					nvme_put_ns(ns);
+				}
 			}
 		}
 		nn -= j;
@@ -1552,8 +1560,6 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned nn)
 	struct nvme_ns *ns, *next;
 	unsigned i;
 
-	lockdep_assert_held(&ctrl->namespaces_mutex);
-
 	for (i = 1; i <= nn; i++)
 		nvme_validate_ns(ctrl, i);
 
@@ -1576,7 +1582,6 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
-	mutex_lock(&ctrl->namespaces_mutex);
 	nn = le32_to_cpu(id->nn);
 	if (ctrl->vs >= NVME_VS(1, 1) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
@@ -1585,6 +1590,7 @@ static void nvme_scan_work(struct work_struct *work)
 	}
 	nvme_scan_ns_sequential(ctrl, nn);
  done:
+	mutex_lock(&ctrl->namespaces_mutex);
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
 	mutex_unlock(&ctrl->namespaces_mutex);
 	kfree(id);
@@ -1604,6 +1610,11 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_queue_scan);
 
+/*
+ * This function iterates the namespace list unlocked to allow recovery from
+ * controller failure. It is up to the caller to ensure the namespace list is
+ * not modified by scan work while this function is executing.
+ */
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
@@ -1617,10 +1628,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
 
-	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
 		nvme_ns_remove(ns);
-	mutex_unlock(&ctrl->namespaces_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
@@ -1791,11 +1800,8 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
-		if (!kref_get_unless_zero(&ns->kref))
-			continue;
-
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		/*
 		 * Revalidating a dead namespace sets capacity to 0. This will
 		 * end buffered writers dirtying pages that can't be synced.
@@ -1806,10 +1812,8 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		blk_set_queue_dying(ns->queue);
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
-
-		nvme_put_ns(ns);
 	}
-	rcu_read_unlock();
+	mutex_unlock(&ctrl->namespaces_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
@@ -1817,8 +1821,8 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		spin_lock_irq(ns->queue->queue_lock);
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
 		spin_unlock_irq(ns->queue->queue_lock);
@@ -1826,7 +1830,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
 	}
-	rcu_read_unlock();
+	mutex_unlock(&ctrl->namespaces_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
@@ -1834,13 +1838,13 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
 		blk_mq_kick_requeue_list(ns->queue);
 	}
-	rcu_read_unlock();
+	mutex_unlock(&ctrl->namespaces_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
-- 
2.7.2
