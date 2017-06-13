From: hch@lst.de (Christoph Hellwig)
Date: Tue, 13 Jun 2017 09:15:20 +0200
Subject: [PATCH 3/4] nvme-fc: merge init_request methods
In-Reply-To: <20170613071521.5191-1-hch@lst.de>
References: <20170613071521.5191-1-hch@lst.de>
Message-ID: <20170613071521.5191-3-hch@lst.de>

Now that we get the tagset passed we can have a single implementation for
the I/O and admin queues.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fc.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ba9024a20bac..8c85d7c4123e 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1448,18 +1448,8 @@ nvme_fc_init_request(struct blk_mq_tag_set *set, struct request *rq,
 {
 	struct nvme_fc_ctrl *ctrl = set->driver_data;
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
-	struct nvme_fc_queue *queue = &ctrl->queues[hctx_idx+1];
-
-	return __nvme_fc_init_request(ctrl, queue, op, rq, queue->rqcnt++);
-}
-
-static int
-nvme_fc_init_admin_request(struct blk_mq_tag_set *set, struct request *rq,
-		unsigned int hctx_idx, unsigned int numa_node)
-{
-	struct nvme_fc_ctrl *ctrl = set->driver_data;
-	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
-	struct nvme_fc_queue *queue = &ctrl->queues[0];
+	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
+	struct nvme_fc_queue *queue = &ctrl->queues[queue_idx];
 
 	return __nvme_fc_init_request(ctrl, queue, op, rq, queue->rqcnt++);
 }
@@ -2695,7 +2685,7 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
 static const struct blk_mq_ops nvme_fc_admin_mq_ops = {
 	.queue_rq	= nvme_fc_queue_rq,
 	.complete	= nvme_fc_complete_rq,
-	.init_request	= nvme_fc_init_admin_request,
+	.init_request	= nvme_fc_init_request,
 	.exit_request	= nvme_fc_exit_request,
 	.reinit_request	= nvme_fc_reinit_request,
 	.init_hctx	= nvme_fc_init_admin_hctx,
-- 
2.11.0
