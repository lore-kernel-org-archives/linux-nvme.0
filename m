From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Mar 2019 10:43:08 -0700
Subject: [PATCH 3/8] nvme/pci: Remove tag check in nvme_process_cq
In-Reply-To: <20190308174313.5134-1-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
Message-ID: <20190308174313.5134-3-keith.busch@intel.com>

Simplify processing completions by removing the check for the optional
search tag. The timeout handling was the only place using this, but we
can check the request state directly instead of searching the completion
entries. There is a chance the command was not actually polled in this
implementation, but we don't want to escalate error recovery in that
case anyway, and the warning is still informative either way.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e72e34b0b441..45db4a39795e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1017,14 +1017,13 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 }
 
 static inline int nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
-				  u16 *end, unsigned int tag)
+				  u16 *end)
 {
 	int found = 0;
 
 	*start = nvmeq->cq_head;
 	while (nvme_cqe_pending(nvmeq)) {
-		if (tag == -1U || nvmeq->cqes[nvmeq->cq_head].command_id == tag)
-			found++;
+		found++;
 		nvme_update_cq_head(nvmeq);
 	}
 	*end = nvmeq->cq_head;
@@ -1047,7 +1046,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	rmb();
 	if (nvmeq->cq_head != nvmeq->last_cq_head)
 		ret = IRQ_HANDLED;
-	nvme_process_cq(nvmeq, &start, &end, -1);
+	nvme_process_cq(nvmeq, &start, &end);
 	nvmeq->last_cq_head = nvmeq->cq_head;
 	wmb();
 
@@ -1071,18 +1070,16 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
  * Poll for completions any queue, including those not dedicated to polling.
  * Can be called from any context.
  */
-static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
+static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	u16 start, end;
-	int found;
 
 	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
-	found = nvme_process_cq(nvmeq, &start, &end, tag);
+	nvme_process_cq(nvmeq, &start, &end);
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 
 	nvme_complete_cqes(nvmeq, start, end);
-	return found;
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx)
@@ -1095,7 +1092,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
-	found = nvme_process_cq(nvmeq, &start, &end, -1);
+	found = nvme_process_cq(nvmeq, &start, &end);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
 	nvme_complete_cqes(nvmeq, start, end);
@@ -1273,12 +1270,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	/*
 	 * Did we miss an interrupt?
 	 */
-	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags) &&
-	    nvme_poll_irqdisable(nvmeq, req->tag)) {
-		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, completion polled\n",
-			 req->tag, nvmeq->qid);
-		return BLK_EH_DONE;
+	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags)) {
+		nvme_poll_irqdisable(nvmeq);
+		if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT) {
+			dev_warn(dev->ctrl.device,
+				 "I/O %d QID %d timeout, completion polled\n",
+				 req->tag, nvmeq->qid);
+			return BLK_EH_DONE;
+		}
 	}
 
 	/*
@@ -1409,7 +1408,7 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 	else
 		nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
 
-	nvme_poll_irqdisable(nvmeq, -1);
+	nvme_poll_irqdisable(nvmeq);
 }
 
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
@@ -2286,7 +2285,7 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 		/* handle any remaining CQEs */
 		if (opcode == nvme_admin_delete_cq &&
 		    !test_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags))
-			nvme_poll_irqdisable(nvmeq, -1);
+			nvme_poll_irqdisable(nvmeq);
 
 		sent--;
 		if (nr_queues)
-- 
2.14.4
