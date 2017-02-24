From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 Feb 2017 17:59:28 -0500
Subject: [PATCH] nvme/pci: Poll CQ on timeout
Message-ID: <1487977168-5347-1-git-send-email-keith.busch@intel.com>

If an IO timeout occurs, it's helpful to know if the controller did not
post a completion or the driver missed an interrupt. While we never expect
the latter, this patch will make it possible to tell the difference so
we don't have to guess.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f4f86d7..3ed1a84 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -745,10 +745,8 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
-	struct nvme_queue *nvmeq = hctx->driver_data;
-
 	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
 		spin_lock_irq(&nvmeq->q_lock);
 		__nvme_process_cq(nvmeq, &tag);
@@ -761,6 +759,13 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	return 0;
 }
 
+static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+
+	return __nvme_poll(nvmeq, tag);
+}
+
 static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
@@ -859,6 +864,16 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_command cmd;
 
 	/*
+	 * Did we miss an interrupt?
+	 */
+	if (__nvme_poll(nvmeq, req->tag)) {
+		dev_warn(dev->ctrl.device,
+			 "I/O %d QID %d timeout, completion polled\n",
+			 req->tag, nvmeq->qid);
+		return BLK_EH_HANDLED;
+	}
+
+	/*
 	 * Shutdown immediately if controller times out while starting. The
 	 * reset work will see the pci device disabled when it gets the forced
 	 * cancellation error. All outstanding requests are completed on
-- 
2.5.5
