From: sandeep@purestorage.com (Sandeep Mann)
Date: Fri, 21 Apr 2017 17:24:15 -0600
Subject: [PATCH] nvme: change cq_vector to a bool and set to true after
 request_irq
Message-ID: <1492817055-33601-1-git-send-email-sandeep@purestorage.com>

Currently nvme_create_queue sets nvmeq->cq_vector early, before calling
adapter_alloc_cq/sq.  And once the queues have been instantiated, the last
step allocates the IRQ (request_irq).

Both adapter_alloc_cq/sq issue ADMIN commands for queue creation.  If the PCIe
link fails, while either ADMIN command is in flight, the cleanup code in
nvme_timeout will call nvme_suspend_queue, which calls free_irq with the
vector indexed by nvmeq->cq_vector.  This results free_irq on a vector that was
never allocated.

This fix changes cq_vector to a bool from an integer index and stores true after
the IRQ has been allocated.  The index is now derived from the nvmeq->qid.
---
 drivers/nvme/host/pci.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26a5fd0..c934538 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -127,7 +127,7 @@ struct nvme_queue {
 	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
 	u16 q_depth;
-	s16 cq_vector;
+	bool cq_vector;
 	u16 sq_tail;
 	u16 cq_head;
 	u16 qid;
@@ -135,6 +135,11 @@ struct nvme_queue {
 	u8 cqe_seen;
 };
 
+static inline u16 to_irq_vector(struct nvme_queue *q)
+{
+	return q->qid ? q->qid - 1 : 0;
+}
+
 /*
  * The nvme_iod describes the data in an I/O, including the list of PRP
  * entries.  You can't see it in this data structure because C doesn't let
@@ -206,7 +211,7 @@ static unsigned int nvme_cmd_size(struct nvme_dev *dev)
 
 static int nvmeq_irq(struct nvme_queue *nvmeq)
 {
-	return pci_irq_vector(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector);
+	return pci_irq_vector(to_pci_dev(nvmeq->dev->dev), to_irq_vector(nvmeq));
 }
 
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
@@ -612,7 +617,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_mq_start_request(req);
 
 	spin_lock_irq(&nvmeq->q_lock);
-	if (unlikely(nvmeq->cq_vector < 0)) {
+	if (unlikely(!nvmeq->cq_vector)) {
 		ret = BLK_MQ_RQ_QUEUE_ERROR;
 		spin_unlock_irq(&nvmeq->q_lock);
 		goto out_cleanup_iod;
@@ -712,7 +717,7 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return;
 
-	if (likely(nvmeq->cq_vector >= 0))
+	if (likely(nvmeq->cq_vector))
 		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
@@ -803,7 +808,7 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	c.create_cq.cqid = cpu_to_le16(qid);
 	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(flags);
-	c.create_cq.irq_vector = cpu_to_le16(nvmeq->cq_vector);
+	c.create_cq.irq_vector = cpu_to_le16(to_irq_vector(nvmeq));
 
 	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
 }
@@ -958,13 +963,13 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	int vector;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	if (nvmeq->cq_vector == -1) {
+	if (!nvmeq->cq_vector) {
 		spin_unlock_irq(&nvmeq->q_lock);
 		return 1;
 	}
 	vector = nvmeq_irq(nvmeq);
 	nvmeq->dev->online_queues--;
-	nvmeq->cq_vector = -1;
+	nvmeq->cq_vector = false;
 	spin_unlock_irq(&nvmeq->q_lock);
 
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
@@ -1063,7 +1068,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->q_depth = depth;
 	nvmeq->qid = qid;
-	nvmeq->cq_vector = -1;
+	nvmeq->cq_vector = false;
 	dev->queues[qid] = nvmeq;
 	dev->queue_count++;
 
@@ -1106,7 +1111,6 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
 
-	nvmeq->cq_vector = qid - 1;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
 		return result;
@@ -1118,6 +1122,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	result = queue_request_irq(nvmeq);
 	if (result < 0)
 		goto release_sq;
+	nvmeq->cq_vector = true;
 
 	nvme_init_queue(nvmeq, qid);
 	return result;
@@ -1235,12 +1240,11 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	if (result)
 		return result;
 
-	nvmeq->cq_vector = 0;
 	result = queue_request_irq(nvmeq);
 	if (result) {
-		nvmeq->cq_vector = -1;
 		return result;
 	}
+	nvmeq->cq_vector = true;
 
 	return result;
 }
@@ -1462,7 +1466,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	result = queue_request_irq(adminq);
 	if (result) {
-		adminq->cq_vector = -1;
+		adminq->cq_vector = false;
 		return result;
 	}
 	return nvme_create_io_queues(dev);
-- 
1.9.1
