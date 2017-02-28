From: parav@mellanox.com (Parav Pandit)
Date: Tue, 28 Feb 2017 13:54:42 -0600
Subject: [PATCHv1] nvmet: Avoid writing fabric_ops,
 queue pointers on every request.
Message-ID: <1488311682-11000-1-git-send-email-parav@mellanox.com>

Fabric operations are constants of a registered transport. They don't
change with every target request that gets processed by the nvmet-core.
Therefore this patch moves fabrics_ops initialization out of the hot
request processing path for rdma and fc.
It continues to remain in same way for loop target.

Additionally this patch further avoid nvme cq and sq pointer
initialization for every request during every request processing for
rdma because nvme queue linking occurs during queue allocation time for
AQ and IOQ.

As a result, in nvmet_req_init function, this change saves
initialization of 24 bytes constants on every datapath request and also
reduces function size by 32 bytes for rdma transport.

Changes from v0 to address Christoph's comment:
Avoiding long name functions, instead initializing them in
appropriate functions.

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/target/core.c  |  8 ++------
 drivers/nvme/target/fc.c    | 13 +++++++------
 drivers/nvme/target/loop.c  | 14 ++++++++++----
 drivers/nvme/target/nvmet.h |  3 +--
 drivers/nvme/target/rdma.c  |  8 +++++---
 5 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2fb7897..a7a670c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -464,15 +464,11 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 }
 EXPORT_SYMBOL_GPL(nvmet_sq_init);
 
-bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
-		struct nvmet_sq *sq, struct nvmet_fabrics_ops *ops)
+bool nvmet_req_init(struct nvmet_req *req)
 {
 	u8 flags = req->cmd->common.flags;
 	u16 status;
 
-	req->cq = cq;
-	req->sq = sq;
-	req->ops = ops;
 	req->sg = NULL;
 	req->sg_cnt = 0;
 	req->rsp->status = 0;
@@ -505,7 +501,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (status)
 		goto fail;
 
-	if (unlikely(!percpu_ref_tryget_live(&sq->ref))) {
+	if (unlikely(!percpu_ref_tryget_live(&req->sq->ref))) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto fail;
 	}
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 8f483ee..ab1c4db 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -142,6 +142,7 @@ struct nvmet_fc_tgt_assoc {
 	struct kref			ref;
 };
 
+static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops;
 
 static inline int
 nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
@@ -417,6 +418,8 @@ struct nvmet_fc_tgt_assoc {
 		fod->tgtport = tgtport;
 		fod->queue = queue;
 		fod->active = false;
+		fod->req.ops = &nvmet_fc_tgt_fcp_ops;
+
 		list_add_tail(&fod->fcp_list, &queue->fod_list);
 		spin_lock_init(&fod->flock);
 
@@ -1411,8 +1414,6 @@ enum {
 
 static void nvmet_fc_fcp_nvme_cmd_done(struct nvmet_req *nvme_req);
 
-static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops;
-
 static void
 nvmet_fc_xmt_ls_rsp_done(struct nvmefc_tgt_ls_req *lsreq)
 {
@@ -2014,10 +2015,10 @@ enum {
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
 
-	ret = nvmet_req_init(&fod->req,
-				&fod->queue->nvme_cq,
-				&fod->queue->nvme_sq,
-				&nvmet_fc_tgt_fcp_ops);
+	fod->req.cq = &fod->queue->nvme_cq;
+	fod->req.sq = &fod->queue->nvme_sq;
+
+	ret = nvmet_req_init(&fod->req);
 	if (!ret) {	/* bad SQE content */
 		nvmet_fc_abort_op(tgtport, fod->fcpreq);
 		return;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d1f06e7..ee22388 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -174,8 +174,11 @@ static int nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 	iod->req.port = nvmet_loop_port;
-	if (!nvmet_req_init(&iod->req, &queue->nvme_cq,
-			&queue->nvme_sq, &nvme_loop_ops)) {
+	iod->req.cq = &queue->nvme_cq;
+	iod->req.sq = &queue->nvme_sq;
+	iod->req.ops = &nvme_loop_ops;
+
+	if (!nvmet_req_init(&iod->req)) {
 		nvme_cleanup_cmd(req);
 		blk_mq_start_request(req);
 		nvme_loop_queue_response(&iod->req);
@@ -211,8 +214,11 @@ static void nvme_loop_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	iod->cmd.common.command_id = NVME_LOOP_AQ_BLKMQ_DEPTH;
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 
-	if (!nvmet_req_init(&iod->req, &queue->nvme_cq, &queue->nvme_sq,
-			&nvme_loop_ops)) {
+	iod->req.cq = &queue->nvme_cq;
+	iod->req.sq = &queue->nvme_sq;
+	iod->req.ops = &nvme_loop_ops;
+
+	if (!nvmet_req_init(&iod->req)) {
 		dev_err(ctrl->ctrl.device, "failed async event work\n");
 		return;
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6898231..d7d1d07 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -258,8 +258,7 @@ struct nvmet_async_event {
 u16 nvmet_parse_discovery_cmd(struct nvmet_req *req);
 u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req);
 
-bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
-		struct nvmet_sq *sq, struct nvmet_fabrics_ops *ops);
+bool nvmet_req_init(struct nvmet_req *req);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
 
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 9aa1da3..072068d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -402,6 +402,10 @@ static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
 		if (ret)
 			goto out_free;
 
+		rsp->req.cq = &queue->nvme_cq;
+		rsp->req.sq = &queue->nvme_sq;
+		rsp->req.ops = &nvmet_rdma_ops;
+
 		list_add_tail(&rsp->free_list, &queue->free_rsps);
 	}
 
@@ -707,7 +711,6 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 	cmd->n_rdma = 0;
 	cmd->req.port = queue->port;
 
-
 	ib_dma_sync_single_for_cpu(queue->dev->device,
 		cmd->cmd->sge[0].addr, cmd->cmd->sge[0].length,
 		DMA_FROM_DEVICE);
@@ -715,8 +718,7 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 		cmd->send_sge.addr, cmd->send_sge.length,
 		DMA_TO_DEVICE);
 
-	if (!nvmet_req_init(&cmd->req, &queue->nvme_cq,
-			&queue->nvme_sq, &nvmet_rdma_ops))
+	if (!nvmet_req_init(&cmd->req))
 		return;
 
 	status = nvmet_rdma_map_sgl(cmd);
-- 
1.8.3.1
