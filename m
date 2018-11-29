From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Nov 2018 20:12:59 +0100
Subject: [PATCH 02/13] nvme-pci: use atomic bitops to mark a queue enabled
In-Reply-To: <20181129191310.9795-1-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
Message-ID: <20181129191310.9795-3-hch@lst.de>

This gets rid of all the messing with cq_vector and the ->polled field
by using an atomic bitop to mark the queue enabled or not.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 43 ++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a1bb4bb92e7f..022395a319f4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -201,7 +201,8 @@ struct nvme_queue {
 	u16 last_cq_head;
 	u16 qid;
 	u8 cq_phase;
-	u8 polled;
+	unsigned long flags;
+#define NVMEQ_ENABLED		0
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -927,7 +928,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * We should not need to do this, but we're still using this to
 	 * ensure we can drain requests on a dying queue.
 	 */
-	if (unlikely(nvmeq->cq_vector < 0 && !nvmeq->polled))
+	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
 		return BLK_STS_IOERR;
 
 	ret = nvme_setup_cmd(ns, req, &cmnd);
@@ -1395,31 +1396,19 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
  */
 static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 {
-	int vector;
-
-	spin_lock_irq(&nvmeq->cq_lock);
-	if (nvmeq->cq_vector == -1 && !nvmeq->polled) {
-		spin_unlock_irq(&nvmeq->cq_lock);
+	if (!test_and_clear_bit(NVMEQ_ENABLED, &nvmeq->flags))
 		return 1;
-	}
-	vector = nvmeq->cq_vector;
-	nvmeq->dev->online_queues--;
-	nvmeq->cq_vector = -1;
-	nvmeq->polled = false;
-	spin_unlock_irq(&nvmeq->cq_lock);
 
-	/*
-	 * Ensure that nvme_queue_rq() sees it ->cq_vector == -1 without
-	 * having to grab the lock.
-	 */
+	/* ensure that nvme_queue_rq() sees NVMEQ_ENABLED cleared */
 	mb();
 
+	nvmeq->dev->online_queues--;
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
-
-	if (vector != -1)
-		pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
-
+	if (nvmeq->cq_vector == -1)
+		return 0;
+	pci_free_irq(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector, nvmeq);
+	nvmeq->cq_vector = -1;
 	return 0;
 }
 
@@ -1578,13 +1567,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	else if (result)
 		goto release_cq;
 
-	/*
-	 * Set cq_vector after alloc cq/sq, otherwise nvme_suspend_queue will
-	 * invoke free_irq for it and cause a 'Trying to free already-free IRQ
-	 * xxx' warning if the create CQ/SQ command times out.
-	 */
 	nvmeq->cq_vector = vector;
-	nvmeq->polled = polled;
 	nvme_init_queue(nvmeq, qid);
 
 	if (vector != -1) {
@@ -1593,11 +1576,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 			goto release_sq;
 	}
 
+	set_bit(NVMEQ_ENABLED, &nvmeq->flags);
 	return result;
 
 release_sq:
 	nvmeq->cq_vector = -1;
-	nvmeq->polled = false;
 	dev->online_queues--;
 	adapter_delete_sq(dev, qid);
 release_cq:
@@ -1751,6 +1734,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 		return result;
 	}
 
+	set_bit(NVMEQ_ENABLED, &nvmeq->flags);
 	return result;
 }
 
@@ -2173,6 +2157,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	if (nr_io_queues == 0)
 		return 0;
+	
+	clear_bit(NVMEQ_ENABLED, &adminq->flags);
 
 	if (dev->cmb_use_sqes) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
@@ -2227,6 +2213,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		adminq->cq_vector = -1;
 		return result;
 	}
+	set_bit(NVMEQ_ENABLED, &adminq->flags);
 	return nvme_create_io_queues(dev);
 }
 
-- 
2.19.1
