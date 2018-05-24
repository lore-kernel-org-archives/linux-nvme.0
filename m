From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 May 2018 14:34:59 -0600
Subject: [PATCHv3 8/9] nvme-pci: Queue creation error handling
In-Reply-To: <20180524203500.14081-1-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
Message-ID: <20180524203500.14081-9-keith.busch@intel.com>

This patch sets the nvmeq's cq_vector only after the cq was successfully
created. This way a device reset doesn't mistakenly believe that the
vector is allocated. In case a reset does occur during queue creation,
this patch will return status immediately instead of trying to unwind
the created queues since the device won't be able to delete queues anyway.

This patch will also handle device reported failures correctly. These
errors are reported as positive nvme status codes, which were previously
not handled at all.

Based-on-patch-by: Jianchao Wang <jianchao.w.wang at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7c8076411dbc..e12b4ee91254 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1079,7 +1079,7 @@ static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 }
 
 static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
-						struct nvme_queue *nvmeq)
+			    struct nvme_queue *nvmeq, u16 vector)
 {
 	struct nvme_command c;
 	int flags = NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED;
@@ -1094,7 +1094,7 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	c.create_cq.cqid = cpu_to_le16(qid);
 	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(flags);
-	c.create_cq.irq_vector = cpu_to_le16(nvmeq->cq_vector);
+	c.create_cq.irq_vector = cpu_to_le16(vector);
 
 	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
 }
@@ -1477,6 +1477,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
+	u16 vector;
 
 	if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
 		unsigned offset = (qid - 1) * roundup(SQ_SIZE(nvmeq->q_depth),
@@ -1489,16 +1490,20 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	 * A queue's vector matches the queue identifier unless the controller
 	 * has only one vector available.
 	 */
-	nvmeq->cq_vector = dev->num_vecs == 1 ? 0 : qid;
-	result = adapter_alloc_cq(dev, qid, nvmeq);
-	if (result < 0)
-		goto release_vector;
+	vector = dev->num_vecs == 1 ? 0 : qid;
+	result = adapter_alloc_cq(dev, qid, nvmeq, vector);
+	if (result)
+		return result;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
 	if (result < 0)
+		return result;
+	else if (result)
 		goto release_cq;
 
 	nvme_init_queue(nvmeq, qid);
+
+	nvmeq->cq_vector = vector;
 	result = queue_request_irq(nvmeq);
 	if (result < 0)
 		goto release_sq;
@@ -1506,12 +1511,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	return result;
 
  release_sq:
+	nvmeq->cq_vector = -1;
 	dev->online_queues--;
 	adapter_delete_sq(dev, qid);
  release_cq:
 	adapter_delete_cq(dev, qid);
- release_vector:
-	nvmeq->cq_vector = -1;
 	return result;
 }
 
-- 
2.14.3
