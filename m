From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 17 Nov 2018 14:43:50 -0700
Subject: [PATCH 3/7] nvme-fc: remove unused poll implementation
In-Reply-To: <20181117214354.822-1-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
Message-ID: <20181117214354.822-4-axboe@kernel.dk>

This relies on the fc taget ops setting ->poll_queue, which
nobody does. Otherwise it just checks if something has
completed, which isn't very useful.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 drivers/nvme/host/fc.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 98c3c77f48f6..de797c641265 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2302,38 +2302,6 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir);
 }
 
-static struct blk_mq_tags *
-nvme_fc_tagset(struct nvme_fc_queue *queue)
-{
-	if (queue->qnum == 0)
-		return queue->ctrl->admin_tag_set.tags[queue->qnum];
-
-	return queue->ctrl->tag_set.tags[queue->qnum - 1];
-}
-
-static int
-nvme_fc_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
-
-{
-	struct nvme_fc_queue *queue = hctx->driver_data;
-	struct nvme_fc_ctrl *ctrl = queue->ctrl;
-	struct request *req;
-	struct nvme_fc_fcp_op *op;
-
-	req = blk_mq_tag_to_rq(nvme_fc_tagset(queue), tag);
-	if (!req)
-		return 0;
-
-	op = blk_mq_rq_to_pdu(req);
-
-	if ((atomic_read(&op->state) == FCPOP_STATE_ACTIVE) &&
-		 (ctrl->lport->ops->poll_queue))
-		ctrl->lport->ops->poll_queue(&ctrl->lport->localport,
-						 queue->lldd_handle);
-
-	return ((atomic_read(&op->state) != FCPOP_STATE_ACTIVE));
-}
-
 static void
 nvme_fc_submit_async_event(struct nvme_ctrl *arg)
 {
@@ -2404,7 +2372,6 @@ static const struct blk_mq_ops nvme_fc_mq_ops = {
 	.init_request	= nvme_fc_init_request,
 	.exit_request	= nvme_fc_exit_request,
 	.init_hctx	= nvme_fc_init_hctx,
-	.poll		= nvme_fc_poll,
 	.timeout	= nvme_fc_timeout,
 };
 
-- 
2.17.1
