From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 27 Feb 2017 19:00:19 +0200
Subject: [PATCH 1/2] nvme-loop: retrieve iod from the cqe command_id
Message-ID: <1488214820-3578-1-git-send-email-sagi@grimberg.me>

useful to validate that the we didn't mess up
the command_id.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d1f06e7768ff..8e19bf48691c 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -113,11 +113,20 @@ static void nvme_loop_complete_rq(struct request *req)
 	blk_mq_end_request(req, error);
 }
 
+static struct blk_mq_tags *nvme_loop_tagset(struct nvme_loop_queue *queue)
+{
+	u32 queue_idx = nvme_loop_queue_idx(queue);
+
+	if (queue_idx == 0)
+		return queue->ctrl->admin_tag_set.tags[queue_idx];
+	return queue->ctrl->tag_set.tags[queue_idx - 1];
+}
+
 static void nvme_loop_queue_response(struct nvmet_req *req)
 {
-	struct nvme_loop_iod *iod =
-		container_of(req, struct nvme_loop_iod, req);
-	struct nvme_completion *cqe = &iod->rsp;
+	struct nvme_loop_queue *queue =
+		container_of(req->sq, struct nvme_loop_queue, nvme_sq);
+	struct nvme_completion *cqe = req->rsp;
 
 	/*
 	 * AEN requests are special as they don't time out and can
@@ -125,13 +134,23 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
 	 * aborts.  We don't even bother to allocate a struct request
 	 * for them but rather special case them here.
 	 */
-	if (unlikely(nvme_loop_queue_idx(iod->queue) == 0 &&
+	if (unlikely(nvme_loop_queue_idx(queue) == 0 &&
 			cqe->command_id >= NVME_LOOP_AQ_BLKMQ_DEPTH)) {
-		nvme_complete_async_event(&iod->queue->ctrl->ctrl, cqe->status,
+		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	} else {
-		struct request *rq = blk_mq_rq_from_pdu(iod);
+		struct request *rq;
+		struct nvme_loop_iod *iod;
+
+		rq = blk_mq_tag_to_rq(nvme_loop_tagset(queue), cqe->command_id);
+		if (!rq) {
+			dev_err(queue->ctrl->ctrl.device,
+				"tag 0x%x on queue %d not found\n",
+				cqe->command_id, nvme_loop_queue_idx(queue));
+			return;
+		}
 
+		iod = blk_mq_rq_to_pdu(rq);
 		iod->nvme_req.result = cqe->result;
 		blk_mq_complete_request(rq, le16_to_cpu(cqe->status) >> 1);
 	}
-- 
2.7.4
