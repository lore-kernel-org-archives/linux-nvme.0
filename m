From: keith.busch@intel.com (Keith Busch)
Date: Wed,  6 Jul 2016 11:22:50 -0600
Subject: [PATCHv3 for-4.7] nvme: Remove RCU namespace protection
Message-ID: <1467825770-27355-1-git-send-email-keith.busch@intel.com>

We can't block with RCU read lock held, but we need to do potentially
blocking stuff to namespace queues when iterating the list. This patch
removes the rcu read locking.

Any list iteration that does IO has to be done unlocked to allow recovery.
The caller must ensure the list can not be manipulated under such
conditions. List iterations that do not issue IO can safely use the lock
since it wouldn't block recovery from missing IO completions.

This fixes these two BUGs:

 BUG: sleeping function called from invalid context at include/linux/writeback.h:185
 in_atomic(): 1, irqs_disabled(): 0, pid: 757, name: kworker/97:1
 CPU: 97 PID: 757 Comm: kworker/97:1 Tainted: G            E   4.6.0-2016-06-14+ #1
 Hardware name: Intel Corporation PURLEY/PURLEY, BIOS PLYDCRB1.86B.0087.D08.1605241555 05/24/2016
 Workqueue: pciehp-2 pciehp_power_thread
  0000000000000000 ffff880462377b38 ffffffff81310c61 ffff8804623704c0
  00000000000000b9 ffff880462377b50 ffffffff8108fe14 ffffffff81809e2a
  ffff880462377b78 ffffffff8108fea9 ffff880469eb4800 ffffc900011824a0
 Call Trace:
  [<ffffffff81310c61>] dump_stack+0x63/0x82
  [<ffffffff8108fe14>] ___might_sleep+0xd4/0x120
  [<ffffffff8108fea9>] __might_sleep+0x49/0x80
  [<ffffffff8120d060>] iget5_locked+0xa0/0x210
  [<ffffffff8122ac80>] ? bdev_test+0x20/0x20
  [<ffffffff8122b5ce>] bdget+0x3e/0x130
  [<ffffffff812f2b24>] bdget_disk+0x24/0x40
  [<ffffffff8122bd3d>] revalidate_disk+0x3d/0x90
  [<ffffffffa0483208>] nvme_kill_queues+0x38/0xc0 [nvme_core]
  [<ffffffffa04833da>] nvme_remove_namespaces+0x5a/0x60 [nvme_core]
  [<ffffffffa048340d>] nvme_uninit_ctrl+0x2d/0xa0 [nvme_core]
  [<ffffffffa085c9eb>] nvme_remove+0x5b/0x100 [nvme]
  [<ffffffff8135bfc9>] pci_device_remove+0x39/0xc0

And:

 BUG: sleeping function called from invalid context at kernel/workqueue.c:2783
 in_atomic(): 0, irqs_disabled(): 0, pid: 1696, name: kworker/u16:0
 CPU: 3 PID: 1696 Comm: kworker/u16:0 Tainted: G           OE   4.6.0-rc3+ #197
 Hardware name: Dell Inc. OptiPlex 7010/0773VG, BIOS A12 01/10/2013
 Workqueue: nvme nvme_reset_work [nvme]
  0000000000000000 ffff8800d94d3a48 ffffffff81379e4c ffff88011a639640
  ffffffff81a12688 ffff8800d94d3a70 ffffffff81094814 ffffffff81a12688
  0000000000000adf 0000000000000000 ffff8800d94d3a98 ffffffff81094904
 Call Trace:
  [<ffffffff81379e4c>] dump_stack+0x85/0xc9
  [<ffffffff81094814>] ___might_sleep+0x144/0x1f0
  [<ffffffff81094904>] __might_sleep+0x44/0x80
  [<ffffffff81087b5e>] flush_work+0x6e/0x290
  [<ffffffff81087af0>] ? __queue_delayed_work+0x150/0x150
  [<ffffffff81126cf5>] ? irq_work_queue+0x75/0x90
  [<ffffffff810ca136>] ? wake_up_klogd+0x36/0x50
  [<ffffffff810b7fa6>] ? mark_held_locks+0x66/0x90
  [<ffffffff81088898>] ? __cancel_work_timer+0xf8/0x1c0
  [<ffffffff8108883b>] __cancel_work_timer+0x9b/0x1c0
  [<ffffffff810cadaa>] ? vprintk_default+0x1a/0x20
  [<ffffffff81142558>] ? printk+0x48/0x4a
  [<ffffffff8108896b>] cancel_work_sync+0xb/0x10
  [<ffffffff81350fb0>] blk_mq_cancel_requeue_work+0x10/0x20
  [<ffffffffc0813ae7>] nvme_stop_queues+0x167/0x1a0 [nvme_core]
  [<ffffffffc0813980>] ? nvme_kill_queues+0x190/0x190 [nvme_core]
  [<ffffffffc08cef51>] nvme_dev_disable+0x71/0x350 [nvme]
  [<ffffffff810b8f40>] ? __lock_acquire+0xa80/0x1ad0
  [<ffffffff810944b6>] ? finish_task_switch+0xa6/0x2c0
  [<ffffffffc08cffd4>] nvme_reset_work+0x214/0xd40 [nvme]

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v2 -> v3:

  Function renaming: nvme_find_ns -> nvme_get_ns -> nvme_find_get_ns

  Insert namespaces sorted so we never have an unsorted list during
  unlocked scanning.

  Removed unnecessary get/put on namespace reference; protected with
  mutex.

 drivers/nvme/host/core.c | 93 ++++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a51584..60dd4c6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -19,7 +19,6 @@
 #include <linux/hdreg.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/list_sort.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pr.h>
@@ -1386,37 +1385,31 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
 	NULL,
 };
 
-static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
+static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
-	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
-	struct nvme_ns *nsb = container_of(b, struct nvme_ns, list);
-
-	return nsa->ns_id - nsb->ns_id;
-}
-
-static struct nvme_ns *nvme_find_ns(struct nvme_ctrl *ctrl, unsigned nsid)
-{
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
 {
-	struct nvme_ns *ns;
+	struct nvme_ns *ns, *prev;
 	struct gendisk *disk;
+	struct list_head *next = &ctrl->namespaces;
 	int node = dev_to_node(ctrl->dev);
 
-	lockdep_assert_held(&ctrl->namespaces_mutex);
-
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
 		return;
@@ -1457,7 +1450,16 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (nvme_revalidate_disk(ns->disk))
 		goto out_free_disk;
 
-	list_add_tail_rcu(&ns->list, &ctrl->namespaces);
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(prev, &ctrl->namespaces, list) {
+		if (prev->ns_id > ns->ns_id) {
+			next = &prev->list;
+			break;
+		}
+	}
+	list_add_tail(&ns->list, next);
+	mutex_unlock(&ctrl->namespaces_mutex);
+
 	kref_get(&ctrl->kref);
 	if (ns->type == NVME_NS_LIGHTNVM)
 		return;
@@ -1480,8 +1482,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
-	lockdep_assert_held(&ns->ctrl->namespaces_mutex);
-
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -1494,8 +1494,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
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
 
@@ -1503,10 +1506,11 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
@@ -1535,9 +1539,11 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
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
@@ -1552,8 +1558,6 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned nn)
 	struct nvme_ns *ns, *next;
 	unsigned i;
 
-	lockdep_assert_held(&ctrl->namespaces_mutex);
-
 	for (i = 1; i <= nn; i++)
 		nvme_validate_ns(ctrl, i);
 
@@ -1576,7 +1580,6 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
-	mutex_lock(&ctrl->namespaces_mutex);
 	nn = le32_to_cpu(id->nn);
 	if (ctrl->vs >= NVME_VS(1, 1) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
@@ -1585,8 +1588,6 @@ static void nvme_scan_work(struct work_struct *work)
 	}
 	nvme_scan_ns_sequential(ctrl, nn);
  done:
-	list_sort(NULL, &ctrl->namespaces, ns_cmp);
-	mutex_unlock(&ctrl->namespaces_mutex);
 	kfree(id);
 
 	if (ctrl->ops->post_scan)
@@ -1604,6 +1605,11 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
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
@@ -1617,10 +1623,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
 
-	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
 		nvme_ns_remove(ns);
-	mutex_unlock(&ctrl->namespaces_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
@@ -1791,11 +1795,8 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
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
@@ -1806,10 +1807,8 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
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
 
@@ -1817,8 +1816,8 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		spin_lock_irq(ns->queue->queue_lock);
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
 		spin_unlock_irq(ns->queue->queue_lock);
@@ -1826,7 +1825,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
 	}
-	rcu_read_unlock();
+	mutex_unlock(&ctrl->namespaces_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
@@ -1834,13 +1833,13 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
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
