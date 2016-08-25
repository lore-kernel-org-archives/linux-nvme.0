From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 26 Aug 2016 00:41:14 +0300
Subject: [PATCH 1/2] nvme-rdma: Get rid of duplicate variable
In-Reply-To: <1472161275-6642-1-git-send-email-sagi@grimberg.me>
References: <1472161275-6642-1-git-send-email-sagi@grimberg.me>
Message-ID: <1472161275-6642-2-git-send-email-sagi@grimberg.me>

We already have need_inval in ib_mr, lets use
that instead.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c133256fd745..881ac28575ef 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -77,7 +77,6 @@ struct nvme_rdma_request {
 	u32			num_sge;
 	int			nents;
 	bool			inline_data;
-	bool			need_inval;
 	struct ib_reg_wr	reg_wr;
 	struct ib_cqe		reg_cqe;
 	struct nvme_rdma_queue  *queue;
@@ -286,7 +285,7 @@ static int nvme_rdma_reinit_request(void *data, struct request *rq)
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	int ret = 0;
 
-	if (!req->need_inval)
+	if (!req->mr->need_inval)
 		goto out;
 
 	ib_dereg_mr(req->mr);
@@ -298,7 +297,7 @@ static int nvme_rdma_reinit_request(void *data, struct request *rq)
 		req->mr = NULL;
 	}
 
-	req->need_inval = false;
+	req->mr->need_inval = false;
 
 out:
 	return ret;
@@ -850,7 +849,7 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 	if (!blk_rq_bytes(rq))
 		return;
 
-	if (req->need_inval) {
+	if (req->mr->need_inval) {
 		res = nvme_rdma_inv_rkey(queue, req);
 		if (res < 0) {
 			dev_err(ctrl->ctrl.device,
@@ -936,7 +935,7 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 			     IB_ACCESS_REMOTE_READ |
 			     IB_ACCESS_REMOTE_WRITE;
 
-	req->need_inval = true;
+	req->mr->need_inval = true;
 
 	sg->addr = cpu_to_le64(req->mr->iova);
 	put_unaligned_le24(req->mr->length, sg->length);
@@ -959,7 +958,7 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 
 	req->num_sge = 1;
 	req->inline_data = false;
-	req->need_inval = false;
+	req->mr->need_inval = false;
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
 
@@ -1146,7 +1145,7 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 
 	if ((wc->wc_flags & IB_WC_WITH_INVALIDATE) &&
 	    wc->ex.invalidate_rkey == req->mr->rkey)
-		req->need_inval = false;
+		req->mr->need_inval = false;
 
 	blk_mq_complete_request(rq, status);
 
@@ -1476,7 +1475,7 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (rq->cmd_type == REQ_TYPE_FS && req_op(rq) == REQ_OP_FLUSH)
 		flush = true;
 	ret = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
-			req->need_inval ? &req->reg_wr.wr : NULL, flush);
+			req->mr->need_inval ? &req->reg_wr.wr : NULL, flush);
 	if (ret) {
 		nvme_rdma_unmap_data(queue, rq);
 		goto err;
-- 
1.9.1
