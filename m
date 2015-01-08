From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:53 -0700
Subject: [PATCHv3 12/12] NVMe: Fix locking on abort handling
In-Reply-To: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
References: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420682153-3756-13-git-send-email-keith.busch@intel.com>

The queues and device need to be locked when messing with them.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 761a454..e0a5b3e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1021,14 +1021,19 @@ static void nvme_abort_req(struct request *req)
 	struct nvme_command cmd;
 
 	if (!nvmeq->qid || cmd_rq->aborted) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dev_list_lock, flags);
 		if (work_busy(&dev->reset_work))
-			return;
+			goto out;
 		list_del_init(&dev->node);
 		dev_warn(&dev->pci_dev->dev,
 			"I/O %d QID %d timeout, reset controller\n",
 							req->tag, nvmeq->qid);
 		dev->reset_workfn = nvme_reset_failed_dev;
 		queue_work(nvme_workq, &dev->reset_work);
+ out:
+		spin_unlock_irqrestore(&dev_list_lock, flags);
 		return;
 	}
 
@@ -1096,25 +1101,29 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = cmd->nvmeq;
 
+	/*
+	 * The aborted req will be completed on receiving the abort req.
+	 * We enable the timer again. If hit twice, it'll cause a device reset,
+	 * as the device then is in a faulty state.
+	 */
+	int ret = BLK_EH_RESET_TIMER;
+
 	dev_warn(nvmeq->q_dmadev, "Timeout I/O %d QID %d\n", req->tag,
 							nvmeq->qid);
 
+	spin_lock_irq(&nvmeq->q_lock);
 	if (!nvmeq->dev->initialized) {
 		/*
 		 * Force cancelled command frees the request, which requires we
 		 * return BLK_EH_NOT_HANDLED.
 		 */
 		nvme_cancel_queue_ios(nvmeq->hctx, req, nvmeq, reserved);
-		return BLK_EH_NOT_HANDLED;
-	}
-	nvme_abort_req(req);
+		ret = BLK_EH_NOT_HANDLED;
+	} else
+		nvme_abort_req(req);
+	spin_unlock_irq(&nvmeq->q_lock);
 
-	/*
-	 * The aborted req will be completed on receiving the abort req.
-	 * We enable the timer again. If hit twice, it'll cause a device reset,
-	 * as the device then is in a faulty state.
-	 */
-	return BLK_EH_RESET_TIMER;
+	return ret;
 }
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
-- 
1.7.10.4
