From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 17:28:08 +0300
Subject: [PATCH v2 2/4] nvme-pci: factor out cqe handling into a dedicated
 routine
In-Reply-To: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
References: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497796090-14808-3-git-send-email-sagi@grimberg.me>

Makes the code slightly more readable.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 53 ++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 042cfe5ef8e9..26eb1743f8bc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -741,6 +741,35 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 	}
 }
 
+static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
+		struct nvme_completion *cqe)
+{
+	struct request *req;
+
+	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
+		dev_warn(nvmeq->dev->ctrl.device,
+			"invalid id %d completed on queue %d\n",
+			cqe->command_id, le16_to_cpu(cqe->sq_id));
+		return;
+	}
+
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
+
+	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
+	nvme_end_request(req, cqe->status, cqe->result);
+}
+
 static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 {
 	u16 head, phase;
@@ -750,7 +779,6 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 
 	while (nvme_cqe_valid(nvmeq, head, phase)) {
 		struct nvme_completion cqe = nvmeq->cqes[head];
-		struct request *req;
 
 		if (++head == nvmeq->q_depth) {
 			head = 0;
@@ -760,28 +788,7 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 		if (tag && *tag == cqe.command_id)
 			*tag = -1;
 
-		if (unlikely(cqe.command_id >= nvmeq->q_depth)) {
-			dev_warn(nvmeq->dev->ctrl.device,
-				"invalid id %d completed on queue %d\n",
-				cqe.command_id, le16_to_cpu(cqe.sq_id));
-			continue;
-		}
-
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
-
-		req = blk_mq_tag_to_rq(*nvmeq->tags, cqe.command_id);
-		nvme_end_request(req, cqe.status, cqe.result);
+		nvme_handle_cqe(nvmeq, &cqe);
 	}
 
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
-- 
2.7.4
