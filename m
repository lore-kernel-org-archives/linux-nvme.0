From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Tue, 15 Mar 2016 13:30:53 +0100 (CET)
Subject: [PATCH v2] nvme: avoid cqe corruption when update at the same time
 as  read
Message-ID: <2110767714.5479030.1458045053603.JavaMail.zimbra@kalray.eu>

Make sure the CQE phase (validity) is read before the rest of the
structure. The phase bit is the highest address and the CQE
read will happen on most platforms from lower to upper addresses
and will be done by multiple non-atomic loads. If the structure
is updated by PCI during the reads from the processor, the
processor may get a corrupted copy.

The addition of the new nvme_cqe_valid function that verifies
the validity bit also allows refactoring of the other CQE read
sequences.

Signed-off-by: Marta Rybczynska <marta.rybczynska at kalray.eu>
---
 drivers/nvme/host/pci.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e9f18e1..6d4a616 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -704,6 +704,13 @@ static void nvme_complete_rq(struct request *req)
 	blk_mq_end_request(req, error);
 }
 
+/* We read the CQE phase first to check if the rest of the entry is valid */
+static inline bool nvme_cqe_valid(struct nvme_queue *nvmeq, u16 head,
+	u16 phase)
+{
+	return (le16_to_cpu(nvmeq->cqes[head].status) & 1) == phase;
+}
+
 static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 {
 	u16 head, phase;
@@ -711,13 +718,10 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 	head = nvmeq->cq_head;
 	phase = nvmeq->cq_phase;
 
-	for (;;) {
+	while (nvme_cqe_valid(nvmeq, head, phase)) {
 		struct nvme_completion cqe = nvmeq->cqes[head];
-		u16 status = le16_to_cpu(cqe.status);
 		struct request *req;
 
-		if ((status & 1) != phase)
-			break;
 		if (++head == nvmeq->q_depth) {
 			head = 0;
 			phase = !phase;
@@ -748,7 +752,7 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 		req = blk_mq_tag_to_rq(*nvmeq->tags, cqe.command_id);
 		if (req->cmd_type == REQ_TYPE_DRV_PRIV && req->special)
 			memcpy(req->special, &cqe, sizeof(cqe));
-		blk_mq_complete_request(req, status >> 1);
+		blk_mq_complete_request(req, le16_to_cpu(cqe.status) >> 1);
 
 	}
 
@@ -789,18 +793,16 @@ static irqreturn_t nvme_irq(int irq, void *data)
 static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
-	struct nvme_completion cqe = nvmeq->cqes[nvmeq->cq_head];
-	if ((le16_to_cpu(cqe.status) & 1) != nvmeq->cq_phase)
-		return IRQ_NONE;
-	return IRQ_WAKE_THREAD;
+	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
+		return IRQ_WAKE_THREAD;
+	return IRQ_NONE;
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 
-	if ((le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].status) & 1) ==
-	    nvmeq->cq_phase) {
+	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
 		spin_lock_irq(&nvmeq->q_lock);
 		__nvme_process_cq(nvmeq, &tag);
 		spin_unlock_irq(&nvmeq->q_lock);
-- 
2.1.0
