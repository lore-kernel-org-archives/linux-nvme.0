From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 17:23:39 +0100
Subject: [PATCH 05/13] nvme-pci: consolidate code for polling non-dedicated
 queues
In-Reply-To: <20181121162347.17430-1-hch@lst.de>
References: <20181121162347.17430-1-hch@lst.de>
Message-ID: <20181121162347.17430-6-hch@lst.de>

We have three places that can poll for I/O completions on a normal
interrupt-enabled queue.  All of them are in slow path code, so
consolidate them to a single helper that uses spin_lock_irqsave and
removes the fast path cqe_pending check.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a68d71ffd0b9..2965e4bb4e41 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1043,17 +1043,19 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
+/*
+ * Poll for completions any queue, including those not dedicated to polling.
+ * Can be called from any context.
+ */
+static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
 {
+	unsigned long flags;
 	u16 start, end;
 	int found;
 
-	if (!nvme_cqe_pending(nvmeq))
-		return 0;
-
-	spin_lock_irq(&nvmeq->cq_lock);
+	spin_lock_irqsave(&nvmeq->cq_lock, flags);
 	found = nvme_process_cq(nvmeq, &start, &end, tag);
-	spin_unlock_irq(&nvmeq->cq_lock);
+	spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
 
 	nvme_complete_cqes(nvmeq, start, end);
 	return found;
@@ -1250,7 +1252,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	/*
 	 * Did we miss an interrupt?
 	 */
-	if (__nvme_poll(nvmeq, req->tag)) {
+	if (nvme_poll_irqdisable(nvmeq, req->tag)) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, completion polled\n",
 			 req->tag, nvmeq->qid);
@@ -1377,18 +1379,13 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
 	struct nvme_queue *nvmeq = &dev->queues[0];
-	u16 start, end;
 
 	if (shutdown)
 		nvme_shutdown_ctrl(&dev->ctrl);
 	else
 		nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
 
-	spin_lock_irq(&nvmeq->cq_lock);
-	nvme_process_cq(nvmeq, &start, &end, -1);
-	spin_unlock_irq(&nvmeq->cq_lock);
-
-	nvme_complete_cqes(nvmeq, start, end);
+	nvme_poll_irqdisable(nvmeq, -1);
 }
 
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
@@ -2186,17 +2183,9 @@ static void nvme_del_queue_end(struct request *req, blk_status_t error)
 static void nvme_del_cq_end(struct request *req, blk_status_t error)
 {
 	struct nvme_queue *nvmeq = req->end_io_data;
-	u16 start, end;
 
-	if (!error) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&nvmeq->cq_lock, flags);
-		nvme_process_cq(nvmeq, &start, &end, -1);
-		spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
-
-		nvme_complete_cqes(nvmeq, start, end);
-	}
+	if (!error)
+		nvme_poll_irqdisable(nvmeq, -1);
 
 	nvme_del_queue_end(req, error);
 }
-- 
2.19.1
