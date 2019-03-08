From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Mar 2019 10:43:06 -0700
Subject: [PATCH 1/8] nvme/pci: Use a flag for polled queues
Message-ID: <20190308174313.5134-1-keith.busch@intel.com>

A negative value for the cq_vector used to mean the queue is either
disabled or a polled queue. However, we have a queue enabled flag,
so the cq_vector had been serving double duty.

Don't overload the meaning of cq_vector. Use a flag specific to the
polled queues instead.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 398c6333cf77..d12b2861bdcc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -189,7 +189,7 @@ struct nvme_queue {
 	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
 	u16 q_depth;
-	s16 cq_vector;
+	u16 cq_vector;
 	u16 sq_tail;
 	u16 last_sq_tail;
 	u16 cq_head;
@@ -200,6 +200,7 @@ struct nvme_queue {
 #define NVMEQ_ENABLED		0
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
+#define NVMEQ_POLLED		3
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -1141,7 +1142,7 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	struct nvme_command c;
 	int flags = NVME_QUEUE_PHYS_CONTIG;
 
-	if (vector != -1)
+	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags))
 		flags |= NVME_CQ_IRQ_ENABLED;
 
 	/*
@@ -1154,10 +1155,7 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	c.create_cq.cqid = cpu_to_le16(qid);
 	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(flags);
-	if (vector != -1)
-		c.create_cq.irq_vector = cpu_to_le16(vector);
-	else
-		c.create_cq.irq_vector = 0;
+	c.create_cq.irq_vector = cpu_to_le16(vector);
 
 	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
 }
@@ -1399,10 +1397,8 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	nvmeq->dev->online_queues--;
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
-	if (nvmeq->cq_vector == -1)
-		return 0;
-	pci_free_irq(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector, nvmeq);
-	nvmeq->cq_vector = -1;
+	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags))
+		pci_free_irq(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector, nvmeq);
 	return 0;
 }
 
@@ -1496,7 +1492,6 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->q_depth = depth;
 	nvmeq->qid = qid;
-	nvmeq->cq_vector = -1;
 	dev->ctrl.queue_count++;
 
 	return 0;
@@ -1541,7 +1536,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
-	s16 vector;
+	u16 vector = 0;
 
 	clear_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
 
@@ -1552,7 +1547,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	if (!polled)
 		vector = dev->num_vecs == 1 ? 0 : qid;
 	else
-		vector = -1;
+		set_bit(NVMEQ_POLLED, &nvmeq->flags);
 
 	result = adapter_alloc_cq(dev, qid, nvmeq, vector);
 	if (result)
@@ -1567,7 +1562,8 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	nvmeq->cq_vector = vector;
 	nvme_init_queue(nvmeq, qid);
 
-	if (vector != -1) {
+	if (!polled) {
+		nvmeq->cq_vector = vector;
 		result = queue_request_irq(nvmeq);
 		if (result < 0)
 			goto release_sq;
@@ -1577,7 +1573,6 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	return result;
 
 release_sq:
-	nvmeq->cq_vector = -1;
 	dev->online_queues--;
 	adapter_delete_sq(dev, qid);
 release_cq:
@@ -1733,7 +1728,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	nvme_init_queue(nvmeq, 0);
 	result = queue_request_irq(nvmeq);
 	if (result) {
-		nvmeq->cq_vector = -1;
+		dev->online_queues--;
 		return result;
 	}
 
@@ -2214,10 +2209,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * number of interrupts.
 	 */
 	result = queue_request_irq(adminq);
-	if (result) {
-		adminq->cq_vector = -1;
+	if (result)
 		return result;
-	}
 	set_bit(NVMEQ_ENABLED, &adminq->flags);
 
 	result = nvme_create_io_queues(dev);
-- 
2.14.4
