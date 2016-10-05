From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  5 Oct 2016 12:42:14 +0300
Subject: [PATCH rfc 6/6] nvme-pci: Get rid of threaded interrupts
In-Reply-To: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
Message-ID: <1475660534-16681-7-git-send-email-sagi@grimberg.me>

Now that we use irq-poll and will never call bio_endio
from hard irq context we don't need it.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a1de66f13e80..07248b5c14ce 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -58,9 +58,6 @@
  */
 #define NVME_AQ_BLKMQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AERS)
 
-static int use_threaded_interrupts;
-module_param(use_threaded_interrupts, int, 0);
-
 static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0644);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
@@ -757,14 +754,6 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t nvme_irq_check(int irq, void *data)
-{
-	struct nvme_queue *nvmeq = data;
-	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
-		return IRQ_WAKE_THREAD;
-	return IRQ_NONE;
-}
-
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
@@ -1114,10 +1103,6 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 							const char *name)
 {
-	if (use_threaded_interrupts)
-		return request_threaded_irq(dev->entry[nvmeq->cq_vector].vector,
-					nvme_irq_check, nvme_irq, IRQF_SHARED,
-					name, nvmeq);
 	return request_irq(dev->entry[nvmeq->cq_vector].vector, nvme_irq,
 				IRQF_SHARED, name, nvmeq);
 }
-- 
2.7.4
