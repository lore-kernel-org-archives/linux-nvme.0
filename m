From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:52 -0700
Subject: [PATCHv3 11/12] NVMe: Start and stop h/w queues on reset
In-Reply-To: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
References: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420682153-3756-12-git-send-email-keith.busch@intel.com>

This freezes and stops all the queues on device shutdown and restarts
them on resume. This fixes hotplug and reset issues when the controller
is actively being used.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index f562394..761a454 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -432,8 +432,13 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	if (unlikely(status)) {
 		if (!(status & NVME_SC_DNR || blk_noretry_request(req))
 		    && (jiffies - req->start_time) < req->timeout) {
+			unsigned long flags;
+
 			blk_mq_requeue_request(req);
-			blk_mq_kick_requeue_list(req->q);
+			spin_lock_irqsave(req->q->queue_lock, flags);
+			if (!blk_queue_stopped(req->q))
+				blk_mq_kick_requeue_list(req->q);
+			spin_unlock_irqrestore(req->q->queue_lock, flags);
 			return;
 		}
 		req->errors = nvme_error_status(status);
@@ -2405,6 +2410,34 @@ static void nvme_dev_list_remove(struct nvme_dev *dev)
 		kthread_stop(tmp);
 }
 
+static void nvme_freeze_queues(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list) {
+		blk_mq_freeze_queue_start(ns->queue);
+
+		spin_lock(ns->queue->queue_lock);
+		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
+		spin_unlock(ns->queue->queue_lock);
+
+		blk_mq_cancel_requeue_work(ns->queue);
+		blk_mq_stop_hw_queues(ns->queue);
+	}
+}
+
+static void nvme_unfreeze_queues(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list) {
+		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
+		blk_mq_unfreeze_queue(ns->queue);
+		blk_mq_start_stopped_hw_queues(ns->queue, true);
+		blk_mq_kick_requeue_list(ns->queue);
+	}
+}
+
 static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
 	int i;
@@ -2413,8 +2446,10 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	dev->initialized = 0;
 	nvme_dev_list_remove(dev);
 
-	if (dev->bar)
+	if (dev->bar) {
+		nvme_freeze_queues(dev);
 		csts = readl(&dev->bar->csts);
+	}
 	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
 		for (i = dev->queue_count - 1; i >= 0; i--) {
 			struct nvme_queue *nvmeq = dev->queues[i];
@@ -2670,6 +2705,9 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 		dev->reset_workfn = nvme_remove_disks;
 		queue_work(nvme_workq, &dev->reset_work);
 		spin_unlock(&dev_list_lock);
+	} else {
+		nvme_unfreeze_queues(dev);
+		nvme_set_irq_hints(dev);
 	}
 	dev->initialized = 1;
 	return 0;
@@ -2807,8 +2845,8 @@ static void nvme_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->reset_work);
 	misc_deregister(&dev->miscdev);
-	nvme_dev_remove(dev);
 	nvme_dev_shutdown(dev);
+	nvme_dev_remove(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
 	nvme_release_prp_pools(dev);
-- 
1.7.10.4
