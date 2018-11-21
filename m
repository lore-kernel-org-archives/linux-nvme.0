From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 17:23:42 +0100
Subject: [PATCH 08/13] nvme-pci: remove the CQ lock for interrupt driven queues
In-Reply-To: <20181121162347.17430-1-hch@lst.de>
References: <20181121162347.17430-1-hch@lst.de>
Message-ID: <20181121162347.17430-9-hch@lst.de>

Now that we can't poll regular, interrupt driven I/O queues there
is almost nothing that can race with an interrupt.  The only
possible other contexts polling a CQ are the error handler and
queue shutdown, and both are so far off in the slow path that
we can simply use the big hammer of disabling interrupts.

With that we can stop taking the cq_lock for normal queues.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ef10279f4e58..330510176a97 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -186,7 +186,8 @@ struct nvme_queue {
 	struct nvme_dev *dev;
 	spinlock_t sq_lock;
 	struct nvme_command *sq_cmds;
-	spinlock_t cq_lock ____cacheline_aligned_in_smp;
+	 /* only used for poll queues: */
+	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
 	volatile struct nvme_completion *cqes;
 	struct blk_mq_tags **tags;
 	dma_addr_t sq_dma_addr;
@@ -1021,12 +1022,16 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	irqreturn_t ret = IRQ_NONE;
 	u16 start, end;
 
-	spin_lock(&nvmeq->cq_lock);
+	/*
+	 * The rmb/wmb pair ensures we see all updates from a previous run of
+	 * the irq handler, even if that was on another CPU.
+	 */
+	rmb();
 	if (nvmeq->cq_head != nvmeq->last_cq_head)
 		ret = IRQ_HANDLED;
 	nvme_process_cq(nvmeq, &start, &end, -1);
 	nvmeq->last_cq_head = nvmeq->cq_head;
-	spin_unlock(&nvmeq->cq_lock);
+	wmb();
 
 	if (start != end) {
 		nvme_complete_cqes(nvmeq, start, end);
@@ -1050,13 +1055,24 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
  */
 static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
 {
-	unsigned long flags;
+	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	u16 start, end;
 	int found;
 
-	spin_lock_irqsave(&nvmeq->cq_lock, flags);
+	/*
+	 * For a poll queue we need to protect against the polling thread
+	 * using the CQ lock.  For normal interrupt driven threads we have
+	 * to disable the interrupt to avoid racing with it.
+	 */
+	if (nvmeq->cq_vector == -1)
+		spin_lock(&nvmeq->cq_poll_lock);
+	else
+		disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 	found = nvme_process_cq(nvmeq, &start, &end, tag);
-	spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
+	if (nvmeq->cq_vector == -1)
+		spin_unlock(&nvmeq->cq_poll_lock);
+	else
+		enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 
 	nvme_complete_cqes(nvmeq, start, end);
 	return found;
@@ -1071,9 +1087,9 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
 
-	spin_lock(&nvmeq->cq_lock);
+	spin_lock(&nvmeq->cq_poll_lock);
 	found = nvme_process_cq(nvmeq, &start, &end, -1);
-	spin_unlock(&nvmeq->cq_lock);
+	spin_unlock(&nvmeq->cq_poll_lock);
 
 	nvme_complete_cqes(nvmeq, start, end);
 	return found;
@@ -1453,7 +1469,7 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	nvmeq->q_dmadev = dev->dev;
 	nvmeq->dev = dev;
 	spin_lock_init(&nvmeq->sq_lock);
-	spin_lock_init(&nvmeq->cq_lock);
+	spin_lock_init(&nvmeq->cq_poll_lock);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
@@ -1489,7 +1505,6 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 
-	spin_lock_irq(&nvmeq->cq_lock);
 	nvmeq->sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
@@ -1497,7 +1512,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	nvme_dbbuf_init(dev, nvmeq, qid);
 	dev->online_queues++;
-	spin_unlock_irq(&nvmeq->cq_lock);
+	wmb(); /* ensure the first interrupt sees the initialization */
 }
 
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
-- 
2.19.1
