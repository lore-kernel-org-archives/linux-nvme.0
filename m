From: keith.busch@intel.com (Keith Busch)
Date: Tue,  6 Jan 2015 19:58:02 -0700
Subject: [PATCHv2 08/10] NVMe: Start and stop h/w queues on reset
In-Reply-To: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420599484-21582-9-git-send-email-keith.busch@intel.com>

This freezes and stops all the queues on device shutdown and restarts
them on resume, and fixes hotplug and reset issues when the controller
is actively being used.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ff3012b..571577c 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -433,7 +433,10 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 		if (!(status & NVME_SC_DNR || blk_noretry_request(req))
 		    && (jiffies - req->start_time) < req->timeout) {
 			blk_mq_requeue_request(req);
-			blk_mq_kick_requeue_list(req->q);
+			spin_lock(req->q->queue_lock);
+			if (!blk_queue_stopped(req->q))
+				blk_mq_kick_requeue_list(req->q);
+			spin_unlock(req->q->queue_lock);
 			return;
 		}
 		req->errors = nvme_error_status(status);
@@ -2391,6 +2394,34 @@ static void nvme_dev_list_remove(struct nvme_dev *dev)
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
@@ -2399,8 +2430,10 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
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
@@ -2654,6 +2687,9 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 		dev->reset_workfn = nvme_remove_disks;
 		queue_work(nvme_workq, &dev->reset_work);
 		spin_unlock(&dev_list_lock);
+	} else {
+		nvme_unfreeze_queues(dev);
+		nvme_set_irq_hints(dev);
 	}
 	dev->initialized = 1;
 	return 0;
@@ -2791,8 +2827,8 @@ static void nvme_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->reset_work);
 	misc_deregister(&dev->miscdev);
-	nvme_dev_remove(dev);
 	nvme_dev_shutdown(dev);
+	nvme_dev_remove(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
 	nvme_free_admin_tags(dev);
-- 
1.7.10.4
