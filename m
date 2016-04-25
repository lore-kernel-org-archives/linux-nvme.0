From: mlin@kernel.org (Ming Lin)
Date: Mon, 25 Apr 2016 14:20:18 -0700
Subject: [PATCH v2 1/2] nvme: switch to RCU freeing the namespace
In-Reply-To: <1461619219-18144-1-git-send-email-mlin@kernel.org>
References: <1461619219-18144-1-git-send-email-mlin@kernel.org>
Message-ID: <1461619219-18144-2-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

Switch to RCU freeing the namespace structure so that
nvme_start_queues, nvme_stop_queues and nvme_kill_queues would
be able to get away with only a RCU read side critical section.

Suggested-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4eb5759..914d336 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1380,7 +1380,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (nvme_revalidate_disk(ns->disk))
 		goto out_free_disk;
 
-	list_add_tail(&ns->list, &ctrl->namespaces);
+	list_add_tail_rcu(&ns->list, &ctrl->namespaces);
 	kref_get(&ctrl->kref);
 	if (ns->type == NVME_NS_LIGHTNVM)
 		return;
@@ -1418,6 +1418,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	mutex_lock(&ns->ctrl->namespaces_mutex);
 	list_del_init(&ns->list);
 	mutex_unlock(&ns->ctrl->namespaces_mutex);
+	synchronize_rcu();
 	nvme_put_ns(ns);
 }
 
@@ -1628,8 +1629,8 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		if (!kref_get_unless_zero(&ns->kref))
 			continue;
 
@@ -1646,7 +1647,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 
 		nvme_put_ns(ns);
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
@@ -1654,8 +1655,8 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		spin_lock_irq(ns->queue->queue_lock);
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
 		spin_unlock_irq(ns->queue->queue_lock);
@@ -1663,7 +1664,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
@@ -1671,13 +1672,13 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
 		blk_mq_kick_requeue_list(ns->queue);
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
-- 
1.9.1
