From: parav@mellanox.com (Parav Pandit)
Date: Tue,  7 Feb 2017 16:37:46 -0600
Subject: [PATCH] nvmet: Avoid writing fabric_ops,
 queue pointers on every request.
Message-ID: <1486507066-23168-1-git-send-email-parav@mellanox.com>

Fabric operations are constants of a registered transport. They don't
change with every target request that gets processed by the nvmet-core.
Therefore this patch moves fabrics_ops initialization out of the hot
request processing path for rdma and fc.
It continues to remain in same way for loop target through extra API.

Additionally this patch further avoid nvme cq and sq pointer
initialization for every request during every request processing
for rdma because nvme queue linking occurs during queue allocation
time for AQ and IOQ.

As a result, in nvmet_req_init function, this change saves
initialization of 24 bytes constants on every datapath request and
also reduces function size by 32 bytes for rdma transport.

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/target/core.c  |  8 ++------
 drivers/nvme/target/fc.c    | 11 +++++------
 drivers/nvme/target/loop.c  | 15 +++++++++++----
 drivers/nvme/target/nvmet.h | 16 ++++++++++++++--
 drivers/nvme/target/rdma.c  |  7 +++++--
 5 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b1d66ed..e55d650 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -463,15 +463,11 @@ int nvmet_sq_init(struct nvmet_sq *sq)
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
@@ -504,7 +500,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (status)
 		goto fail;
 
-	if (unlikely(!percpu_ref_tryget_live(&sq->ref))) {
+	if (unlikely(!percpu_ref_tryget_live(&req->sq->ref))) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto fail;
 	}
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 173e842..8b201c0 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -30,7 +30,6 @@
 
 /* *************************** Data Structures/Defines ****************** */
 
-
 #define NVMET_LS_CTX_COUNT		4
 
 /* for this implementation, assume small single frame rqst/rsp */
@@ -210,6 +209,7 @@ struct nvmet_fc_tgt_assoc {
 static LIST_HEAD(nvmet_fc_target_list);
 static DEFINE_IDA(nvmet_fc_tgtport_cnt);
 
+static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops;
 
 static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
 static void nvmet_fc_handle_fcp_rqst_work(struct work_struct *work);
@@ -417,6 +417,7 @@ struct nvmet_fc_tgt_assoc {
 		fod->tgtport = tgtport;
 		fod->queue = queue;
 		fod->active = false;
+		nvmet_req_fabric_ops_init(&fod->req, &nvmet_fc_tgt_fcp_ops);
 		list_add_tail(&fod->fcp_list, &queue->fod_list);
 		spin_lock_init(&fod->flock);
 
@@ -1403,8 +1404,6 @@ enum {
 
 static void nvmet_fc_fcp_nvme_cmd_done(struct nvmet_req *nvme_req);
 
-static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops;
-
 static void
 nvmet_fc_xmt_ls_rsp_done(struct nvmefc_tgt_ls_req *lsreq)
 {
@@ -2008,10 +2007,10 @@ enum {
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
 
-	ret = nvmet_req_init(&fod->req,
+	nvmet_req_link_to_nvme_queues(&fod->req,
 				&fod->queue->nvme_cq,
-				&fod->queue->nvme_sq,
-				&nvmet_fc_tgt_fcp_ops);
+				&fod->queue->nvme_sq);
+	ret = nvmet_req_init(&fod->req);
 	if (!ret) {	/* bad SQE content */
 		nvmet_fc_abort_op(tgtport, fod->fcpreq);
 		return;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9aaa700..2f7ca34 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -174,8 +174,12 @@ static int nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 	iod->req.port = nvmet_loop_port;
-	if (!nvmet_req_init(&iod->req, &queue->nvme_cq,
-			&queue->nvme_sq, &nvme_loop_ops)) {
+
+	nvmet_req_link_to_nvme_queues(&iod->req,
+				&queue->nvme_cq, &queue->nvme_sq);
+	nvmet_req_fabric_ops_init(&iod->req, &nvme_loop_ops);
+
+	if (!nvmet_req_init(&iod->req)) {
 		nvme_cleanup_cmd(req);
 		blk_mq_start_request(req);
 		nvme_loop_queue_response(&iod->req);
@@ -211,8 +215,11 @@ static void nvme_loop_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	iod->cmd.common.command_id = NVME_LOOP_AQ_BLKMQ_DEPTH;
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 
-	if (!nvmet_req_init(&iod->req, &queue->nvme_cq, &queue->nvme_sq,
-			&nvme_loop_ops)) {
+	nvmet_req_link_to_nvme_queues(&iod->req,
+				&queue->nvme_cq, &queue->nvme_sq);
+	nvmet_req_fabric_ops_init(&iod->req, &nvme_loop_ops);
+
+	if (!nvmet_req_init(&iod->req)) {
 		dev_err(ctrl->ctrl.device, "failed async event work\n");
 		return;
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 23d5eb1..48486c2 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -259,8 +259,20 @@ struct nvmet_async_event {
 int nvmet_parse_discovery_cmd(struct nvmet_req *req);
 int nvmet_parse_fabrics_cmd(struct nvmet_req *req);
 
-bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
-		struct nvmet_sq *sq, struct nvmet_fabrics_ops *ops);
+static inline void nvmet_req_fabric_ops_init(struct nvmet_req *req,
+		struct nvmet_fabrics_ops *ops)
+{
+	req->ops = ops;
+}
+
+static inline void nvmet_req_link_to_nvme_queues(struct nvmet_req *req,
+	struct nvmet_cq *cq, struct nvmet_sq *sq)
+{
+	req->cq = cq;
+	req->sq = sq;
+}
+
+bool nvmet_req_init(struct nvmet_req *req);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
 
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 8c3760a..1a57ab3 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -402,6 +402,10 @@ static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
 		if (ret)
 			goto out_free;
 
+		nvmet_req_link_to_nvme_queues(&rsp->req,
+					&queue->nvme_cq, &queue->nvme_sq);
+		nvmet_req_fabric_ops_init(&rsp->req, &nvmet_rdma_ops);
+
 		list_add_tail(&rsp->free_list, &queue->free_rsps);
 	}
 
@@ -698,8 +702,7 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 	cmd->n_rdma = 0;
 	cmd->req.port = queue->port;
 
-	if (!nvmet_req_init(&cmd->req, &queue->nvme_cq,
-			&queue->nvme_sq, &nvmet_rdma_ops))
+	if (!nvmet_req_init(&cmd->req))
 		return;
 
 	status = nvmet_rdma_map_sgl(cmd);
-- 
1.8.3.1
