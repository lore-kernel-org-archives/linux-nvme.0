From: keith.busch@intel.com (Keith Busch)
Date: Thu, 19 Feb 2015 11:10:30 -0700
Subject: [PATCH] NVMe: Fix potential corruption during shutdown
Message-ID: <1424369430-30813-1-git-send-email-keith.busch@intel.com>

The driver has to end unreturned commands at some point if the controller
has not provided a completion. The driver tried to be safe by deleting
IO queues prior to ending all unfinished commands. That should cause the
controller to internally abort inflight commands, but queue deletion
request does not have to be successful, so all bets are off.

We still have to make progress, so to be safe, this patch doesn't clear
a queue to release the dma mapping for a command until after the pci
device has been disabled.

This patch removes the special handling during device initialization
so controller recovery can be done all the time. This is possible since
the controller is initialized outside pci probe now.

Reported-by: Nilish Choudhury <nilesh.choudhury at oracle.com>
Reported-by: Giang Li <giang.le at intel.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
As mentioned, this patch is dependent on this one:

 http://lists.infradead.org/pipermail/linux-nvme/2015-February/001526.html

 drivers/block/nvme-core.c |   49 ++++++++++++++++++---------------------------
 include/linux/nvme.h      |    1 -
 2 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 99b7139..0bae3d4 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1158,29 +1158,18 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = cmd->nvmeq;
 
-	/*
-	 * The aborted req will be completed on receiving the abort req.
-	 * We enable the timer again. If hit twice, it'll cause a device reset,
-	 * as the device then is in a faulty state.
-	 */
-	int ret = BLK_EH_RESET_TIMER;
-
 	dev_warn(nvmeq->q_dmadev, "Timeout I/O %d QID %d\n", req->tag,
 							nvmeq->qid);
-
 	spin_lock_irq(&nvmeq->q_lock);
-	if (!nvmeq->dev->initialized) {
-		/*
-		 * Force cancelled command frees the request, which requires we
-		 * return BLK_EH_NOT_HANDLED.
-		 */
-		nvme_cancel_queue_ios(nvmeq->hctx, req, nvmeq, reserved);
-		ret = BLK_EH_NOT_HANDLED;
-	} else
-		nvme_abort_req(req);
+	nvme_abort_req(req);
 	spin_unlock_irq(&nvmeq->q_lock);
 
-	return ret;
+	/*
+	 * The aborted req will be completed on receiving the abort req.
+	 * We enable the timer again. If hit twice, it'll cause a device reset,
+	 * as the device then is in a faulty state.
+	 */
+	return BLK_EH_RESET_TIMER;
 }
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
@@ -1233,7 +1222,6 @@ static void nvme_clear_queue(struct nvme_queue *nvmeq)
 	struct blk_mq_hw_ctx *hctx = nvmeq->hctx;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	nvme_process_cq(nvmeq);
 	if (hctx && hctx->tags)
 		blk_mq_tag_busy_iter(hctx, nvme_cancel_queue_ios, nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -1256,7 +1244,10 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 	}
 	if (!qid && dev->admin_q)
 		blk_mq_freeze_queue_start(dev->admin_q);
-	nvme_clear_queue(nvmeq);
+
+	spin_lock_irq(&nvmeq->q_lock);
+	nvme_process_cq(nvmeq);
+	spin_unlock_irq(&nvmeq->q_lock);
 }
 
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
@@ -1923,8 +1914,7 @@ static int nvme_kthread(void *data)
 		spin_lock(&dev_list_lock);
 		list_for_each_entry_safe(dev, next, &dev_list, node) {
 			int i;
-			if (readl(&dev->bar->csts) & NVME_CSTS_CFS &&
-							dev->initialized) {
+			if (readl(&dev->bar->csts) & NVME_CSTS_CFS) {
 				if (work_busy(&dev->reset_work))
 					continue;
 				list_del_init(&dev->node);
@@ -2358,8 +2348,6 @@ static struct nvme_delq_ctx *nvme_get_dq(struct nvme_delq_ctx *dq)
 static void nvme_del_queue_end(struct nvme_queue *nvmeq)
 {
 	struct nvme_delq_ctx *dq = nvmeq->cmdinfo.ctx;
-
-	nvme_clear_queue(nvmeq);
 	nvme_put_dq(dq);
 }
 
@@ -2502,7 +2490,6 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	int i;
 	u32 csts = -1;
 
-	dev->initialized = 0;
 	nvme_dev_list_remove(dev);
 
 	if (dev->bar) {
@@ -2513,7 +2500,6 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 		for (i = dev->queue_count - 1; i >= 0; i--) {
 			struct nvme_queue *nvmeq = dev->queues[i];
 			nvme_suspend_queue(nvmeq);
-			nvme_clear_queue(nvmeq);
 		}
 	} else {
 		nvme_disable_io_queues(dev);
@@ -2521,6 +2507,9 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 		nvme_disable_queue(dev, 0);
 	}
 	nvme_dev_unmap(dev);
+
+	for (i = dev->queue_count - 1; i >= 0; i--)
+		nvme_clear_queue(dev->queues[i]);
 }
 
 static void nvme_dev_remove(struct nvme_dev *dev)
@@ -2770,7 +2759,6 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 		nvme_unfreeze_queues(dev);
 		nvme_set_irq_hints(dev);
 	}
-	dev->initialized = 1;
 	return 0;
 }
 
@@ -2877,11 +2865,12 @@ static void nvme_async_probe(struct work_struct *work)
 		goto reset;
 
 	nvme_set_irq_hints(dev);
-	dev->initialized = 1;
 	return;
  reset:
-	dev->reset_workfn = nvme_reset_failed_dev;
-	queue_work(nvme_workq, &dev->reset_work);
+	if (!work_busy(&dev->reset_work)) {
+		dev->reset_workfn = nvme_reset_failed_dev;
+		queue_work(nvme_workq, &dev->reset_work);
+	}
 }
 
 static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0969b08..a5b8e27 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -106,7 +106,6 @@ struct nvme_dev {
 	u16 abort_limit;
 	u8 event_limit;
 	u8 vwc;
-	u8 initialized;
 };
 
 /*
-- 
1.7.10.4
