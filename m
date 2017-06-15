From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 20:41:46 +0300
Subject: [PATCH 1/3] nvme-pci: Split __nvme_process_cq to poll and handle
In-Reply-To: <1497548508-29447-1-git-send-email-sagi@grimberg.me>
References: <1497548508-29447-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497548508-29447-2-git-send-email-sagi@grimberg.me>

Just some rework to split the logic and make it slightly
more readable. This will help us to easily add the irq-poll
logic.

Also, introduce nvme_ring_cq_doorbell helper to mask out the
cq_vector validity check.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 114 +++++++++++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cf091705b0a9..a99a483a8bb5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -60,7 +60,7 @@ MODULE_PARM_DESC(max_host_mem_size_mb,
 struct nvme_dev;
 struct nvme_queue;
 
-static void nvme_process_cq(struct nvme_queue *nvmeq);
+static int nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
 /*
@@ -729,76 +729,100 @@ static inline bool nvme_cqe_valid(struct nvme_queue *nvmeq, u16 head,
 	return (le16_to_cpu(nvmeq->cqes[head].status) & 1) == phase;
 }
 
-static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
+static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 {
-	u16 head, phase;
+	u16 head = nvmeq->cq_head;
 
-	head = nvmeq->cq_head;
-	phase = nvmeq->cq_phase;
+	if (likely(nvmeq->cq_vector >= 0)) {
+		if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
+						      nvmeq->dbbuf_cq_ei))
+			writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+	}
+}
 
-	while (nvme_cqe_valid(nvmeq, head, phase)) {
-		struct nvme_completion cqe = nvmeq->cqes[head];
-		struct request *req;
+static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
+		struct nvme_completion *cqe)
+{
+	struct request *req;
 
-		if (++head == nvmeq->q_depth) {
-			head = 0;
-			phase = !phase;
-		}
+	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
+		dev_warn(nvmeq->dev->ctrl.device,
+			"invalid id %d completed on queue %d\n",
+			cqe->command_id, le16_to_cpu(cqe->sq_id));
+		return;
+	}
 
-		if (tag && *tag == cqe.command_id)
-			*tag = -1;
+	/*
+	 * AEN requests are special as they don't time out and can
+	 * survive any kind of queue freeze and often don't respond to
+	 * aborts.  We don't even bother to allocate a struct request
+	 * for them but rather special case them here.
+	 */
+	if (unlikely(nvmeq->qid == 0 &&
+			cqe->command_id >= NVME_AQ_BLKMQ_DEPTH)) {
+		nvme_complete_async_event(&nvmeq->dev->ctrl,
+				cqe->status, &cqe->result);
+		return;
+	}
 
-		if (unlikely(cqe.command_id >= nvmeq->q_depth)) {
-			dev_warn(nvmeq->dev->ctrl.device,
-				"invalid id %d completed on queue %d\n",
-				cqe.command_id, le16_to_cpu(cqe.sq_id));
-			continue;
-		}
+	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
+	nvme_end_request(req, cqe->status, cqe->result);
+}
 
-		/*
-		 * AEN requests are special as they don't time out and can
-		 * survive any kind of queue freeze and often don't respond to
-		 * aborts.  We don't even bother to allocate a struct request
-		 * for them but rather special case them here.
-		 */
-		if (unlikely(nvmeq->qid == 0 &&
-				cqe.command_id >= NVME_AQ_BLKMQ_DEPTH)) {
-			nvme_complete_async_event(&nvmeq->dev->ctrl,
-					cqe.status, &cqe.result);
-			continue;
-		}
+static inline bool nvme_read_cqe(struct nvme_queue *nvmeq,
+		struct nvme_completion *cqe)
+{
+	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
+		*cqe = nvmeq->cqes[nvmeq->cq_head];
 
-		req = blk_mq_tag_to_rq(*nvmeq->tags, cqe.command_id);
-		nvme_end_request(req, cqe.status, cqe.result);
+		if (++nvmeq->cq_head == nvmeq->q_depth) {
+			nvmeq->cq_head = 0;
+			nvmeq->cq_phase = !nvmeq->cq_phase;
+		}
+		return true;
 	}
+	return false;
+}
 
-	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
-		return;
+static int __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
+{
+	struct nvme_completion cqe;
+	int consumed = 0;
 
-	if (likely(nvmeq->cq_vector >= 0))
-		if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
-						      nvmeq->dbbuf_cq_ei))
-			writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
-	nvmeq->cq_head = head;
-	nvmeq->cq_phase = phase;
+	while (nvme_read_cqe(nvmeq, &cqe)) {
+		nvme_handle_cqe(nvmeq, &cqe);
+		consumed++;
+
+		if (tag && *tag == cqe.command_id) {
+			*tag = -1;
+			break;
+		}
+	}
+
+	if (consumed) {
+		nvme_ring_cq_doorbell(nvmeq);
+		nvmeq->cqe_seen = 1;
+	}
 
-	nvmeq->cqe_seen = 1;
+	return consumed;
 }
 
-static void nvme_process_cq(struct nvme_queue *nvmeq)
+static int nvme_process_cq(struct nvme_queue *nvmeq)
 {
-	__nvme_process_cq(nvmeq, NULL);
+	return __nvme_process_cq(nvmeq, NULL);
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	irqreturn_t result;
 	struct nvme_queue *nvmeq = data;
+
 	spin_lock(&nvmeq->q_lock);
 	nvme_process_cq(nvmeq);
 	result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
 	nvmeq->cqe_seen = 0;
 	spin_unlock(&nvmeq->q_lock);
+
 	return result;
 }
 
-- 
2.7.4
