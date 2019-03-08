From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Mar 2019 10:43:09 -0700
Subject: [PATCH 4/8] nvme/pci: Remove last_cq_seen
In-Reply-To: <20190308174313.5134-1-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
Message-ID: <20190308174313.5134-4-keith.busch@intel.com>

The driver had been saving the last CQ seen in case polling competes
with an interrupt handler in order to defeat spurious interrupt
detection. Polling only applies to special queues that don't have
interrupt handlers now, so we don't need to save this.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 45db4a39795e..62f29ab93f5a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -193,7 +193,6 @@ struct nvme_queue {
 	u16 sq_tail;
 	u16 last_sq_tail;
 	u16 cq_head;
-	u16 last_cq_head;
 	u16 qid;
 	u8 cq_phase;
 	unsigned long flags;
@@ -1044,10 +1043,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	 * the irq handler, even if that was on another CPU.
 	 */
 	rmb();
-	if (nvmeq->cq_head != nvmeq->last_cq_head)
-		ret = IRQ_HANDLED;
 	nvme_process_cq(nvmeq, &start, &end);
-	nvmeq->last_cq_head = nvmeq->cq_head;
 	wmb();
 
 	if (start != end) {
-- 
2.14.4
