From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon,  8 Apr 2019 18:39:59 +0300
Subject: [PATCH 2/2] nvmet: rename nvme_completion instances from rsp to cqe
In-Reply-To: <1554737999-26459-1-git-send-email-maxg@mellanox.com>
References: <1554737999-26459-1-git-send-email-maxg@mellanox.com>
Message-ID: <1554737999-26459-2-git-send-email-maxg@mellanox.com>

Use NVMe namings for improving code readability.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/core.c        | 22 +++++++++++-----------
 drivers/nvme/target/fabrics-cmd.c | 16 ++++++++--------
 drivers/nvme/target/fc.c          |  2 +-
 drivers/nvme/target/loop.c        |  6 +++---
 drivers/nvme/target/nvmet.h       |  4 ++--
 drivers/nvme/target/rdma.c        | 18 +++++++++---------
 drivers/nvme/target/tcp.c         |  8 ++++----
 7 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b3e765a..6feef3f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -644,7 +644,7 @@ static void nvmet_update_sq_head(struct nvmet_req *req)
 		} while (cmpxchg(&req->sq->sqhd, old_sqhd, new_sqhd) !=
 					old_sqhd);
 	}
-	req->rsp->sq_head = cpu_to_le16(req->sq->sqhd & 0x0000FFFF);
+	req->cqe->sq_head = cpu_to_le16(req->sq->sqhd & 0x0000FFFF);
 }
 
 static void nvmet_set_error(struct nvmet_req *req, u16 status)
@@ -653,7 +653,7 @@ static void nvmet_set_error(struct nvmet_req *req, u16 status)
 	struct nvme_error_slot *new_error_slot;
 	unsigned long flags;
 
-	req->rsp->status = cpu_to_le16(status << 1);
+	req->cqe->status = cpu_to_le16(status << 1);
 
 	if (!ctrl || req->error_loc == NVMET_NO_ERROR_LOC)
 		return;
@@ -673,15 +673,15 @@ static void nvmet_set_error(struct nvmet_req *req, u16 status)
 	spin_unlock_irqrestore(&ctrl->error_lock, flags);
 
 	/* set the more bit for this request */
-	req->rsp->status |= cpu_to_le16(1 << 14);
+	req->cqe->status |= cpu_to_le16(1 << 14);
 }
 
 static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
 	if (!req->sq->sqhd_disabled)
 		nvmet_update_sq_head(req);
-	req->rsp->sq_id = cpu_to_le16(req->sq->qid);
-	req->rsp->command_id = req->cmd->common.command_id;
+	req->cqe->sq_id = cpu_to_le16(req->sq->qid);
+	req->cqe->command_id = req->cmd->common.command_id;
 
 	if (unlikely(status))
 		nvmet_set_error(req, status);
@@ -838,8 +838,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->sg = NULL;
 	req->sg_cnt = 0;
 	req->transfer_len = 0;
-	req->rsp->status = 0;
-	req->rsp->sq_head = 0;
+	req->cqe->status = 0;
+	req->cqe->sq_head = 0;
 	req->ns = NULL;
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
@@ -1066,7 +1066,7 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
 			subsysnqn);
-		req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
+		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
 		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	}
 
@@ -1087,7 +1087,7 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 
 	pr_warn("could not find controller %d for subsys %s / host %s\n",
 		cntlid, subsysnqn, hostnqn);
-	req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
+	req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
 	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 
 out:
@@ -1185,7 +1185,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
 			subsysnqn);
-		req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
+		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
 		goto out;
 	}
 
@@ -1194,7 +1194,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!nvmet_host_allowed(subsys, hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
 			hostnqn, subsysnqn);
-		req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
+		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
 		up_read(&nvmet_config_sem);
 		status = NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR;
 		goto out_put_subsystem;
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 3a76ebc..3b9f79a 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -72,7 +72,7 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 			offsetof(struct nvmf_property_get_command, attrib);
 	}
 
-	req->rsp->result.u64 = cpu_to_le64(val);
+	req->cqe->result.u64 = cpu_to_le64(val);
 	nvmet_req_complete(req, status);
 }
 
@@ -124,7 +124,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 
 	if (c->cattr & NVME_CONNECT_DISABLE_SQFLOW) {
 		req->sq->sqhd_disabled = true;
-		req->rsp->sq_head = cpu_to_le16(0xffff);
+		req->cqe->sq_head = cpu_to_le16(0xffff);
 	}
 
 	if (ctrl->ops->install_queue) {
@@ -158,7 +158,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 
 	/* zero out initial completion result, assign values as needed */
-	req->rsp->result.u32 = 0;
+	req->cqe->result.u32 = 0;
 
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
@@ -172,7 +172,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		pr_warn("connect attempt for invalid controller ID %#x\n",
 			d->cntlid);
 		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
-		req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
+		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
 		goto out;
 	}
 
@@ -195,7 +195,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 
 	pr_info("creating controller %d for subsystem %s for NQN %s.\n",
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn);
-	req->rsp->result.u16 = cpu_to_le16(ctrl->cntlid);
+	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 out:
 	kfree(d);
@@ -222,7 +222,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out;
 
 	/* zero out initial completion result, assign values as needed */
-	req->rsp->result.u32 = 0;
+	req->cqe->result.u32 = 0;
 
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
@@ -240,14 +240,14 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	if (unlikely(qid > ctrl->subsys->max_qid)) {
 		pr_warn("invalid queue id (%d)\n", qid);
 		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
-		req->rsp->result.u32 = IPO_IATTR_CONNECT_SQE(qid);
+		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(qid);
 		goto out_ctrl_put;
 	}
 
 	status = nvmet_install_queue(ctrl, req);
 	if (status) {
 		/* pass back cntlid that had the issue of installing queue */
-		req->rsp->result.u16 = cpu_to_le16(ctrl->cntlid);
+		req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
 		goto out_ctrl_put;
 	}
 
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 98b7b1f..6733673 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2187,7 +2187,7 @@ enum {
 	}
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
-	fod->req.rsp = &fod->rspiubuf.cqe;
+	fod->req.cqe = &fod->rspiubuf.cqe;
 	fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index b9f623a..a3ae491 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -18,7 +18,7 @@
 struct nvme_loop_iod {
 	struct nvme_request	nvme_req;
 	struct nvme_command	cmd;
-	struct nvme_completion	rsp;
+	struct nvme_completion	cqe;
 	struct nvmet_req	req;
 	struct nvme_loop_queue	*queue;
 	struct work_struct	work;
@@ -94,7 +94,7 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
 {
 	struct nvme_loop_queue *queue =
 		container_of(req->sq, struct nvme_loop_queue, nvme_sq);
-	struct nvme_completion *cqe = req->rsp;
+	struct nvme_completion *cqe = req->cqe;
 
 	/*
 	 * AEN requests are special as they don't time out and can
@@ -207,7 +207,7 @@ static int nvme_loop_init_iod(struct nvme_loop_ctrl *ctrl,
 		struct nvme_loop_iod *iod, unsigned int queue_idx)
 {
 	iod->req.cmd = &iod->cmd;
-	iod->req.rsp = &iod->rsp;
+	iod->req.cqe = &iod->cqe;
 	iod->queue = &ctrl->queues[queue_idx];
 	INIT_WORK(&iod->work, nvme_loop_execute_work);
 	return 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 51e49ef..53d5a44 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -284,7 +284,7 @@ struct nvmet_fabrics_ops {
 
 struct nvmet_req {
 	struct nvme_command	*cmd;
-	struct nvme_completion	*rsp;
+	struct nvme_completion	*cqe;
 	struct nvmet_sq		*sq;
 	struct nvmet_cq		*cq;
 	struct nvmet_ns		*ns;
@@ -322,7 +322,7 @@ struct nvmet_req {
 
 static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
 {
-	req->rsp->result.u32 = cpu_to_le32(result);
+	req->cqe->result.u32 = cpu_to_le32(result);
 }
 
 /*
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index b727521..36d906a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -160,7 +160,7 @@ static inline bool nvmet_rdma_need_data_out(struct nvmet_rdma_rsp *rsp)
 {
 	return !nvme_is_write(rsp->req.cmd) &&
 		rsp->req.transfer_len &&
-		!rsp->req.rsp->status &&
+		!rsp->req.cqe->status &&
 		!(rsp->flags & NVMET_RDMA_REQ_INLINE_DATA);
 }
 
@@ -364,17 +364,17 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 		struct nvmet_rdma_rsp *r)
 {
 	/* NVMe CQE / RDMA SEND */
-	r->req.rsp = kmalloc(sizeof(*r->req.rsp), GFP_KERNEL);
-	if (!r->req.rsp)
+	r->req.cqe = kmalloc(sizeof(*r->req.cqe), GFP_KERNEL);
+	if (!r->req.cqe)
 		goto out;
 
-	r->send_sge.addr = ib_dma_map_single(ndev->device, r->req.rsp,
-			sizeof(*r->req.rsp), DMA_TO_DEVICE);
+	r->send_sge.addr = ib_dma_map_single(ndev->device, r->req.cqe,
+			sizeof(*r->req.cqe), DMA_TO_DEVICE);
 	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
 		goto out_free_rsp;
 
 	r->req.p2p_client = &ndev->device->dev;
-	r->send_sge.length = sizeof(*r->req.rsp);
+	r->send_sge.length = sizeof(*r->req.cqe);
 	r->send_sge.lkey = ndev->pd->local_dma_lkey;
 
 	r->send_cqe.done = nvmet_rdma_send_done;
@@ -389,7 +389,7 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 	return 0;
 
 out_free_rsp:
-	kfree(r->req.rsp);
+	kfree(r->req.cqe);
 out:
 	return -ENOMEM;
 }
@@ -398,8 +398,8 @@ static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
 		struct nvmet_rdma_rsp *r)
 {
 	ib_dma_unmap_single(ndev->device, r->send_sge.addr,
-				sizeof(*r->req.rsp), DMA_TO_DEVICE);
-	kfree(r->req.rsp);
+				sizeof(*r->req.cqe), DMA_TO_DEVICE);
+	kfree(r->req.cqe);
 }
 
 static int
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ad0df78..0d7df13 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -161,14 +161,14 @@ static inline bool nvmet_tcp_has_data_in(struct nvmet_tcp_cmd *cmd)
 
 static inline bool nvmet_tcp_need_data_in(struct nvmet_tcp_cmd *cmd)
 {
-	return nvmet_tcp_has_data_in(cmd) && !cmd->req.rsp->status;
+	return nvmet_tcp_has_data_in(cmd) && !cmd->req.cqe->status;
 }
 
 static inline bool nvmet_tcp_need_data_out(struct nvmet_tcp_cmd *cmd)
 {
 	return !nvme_is_write(cmd->req.cmd) &&
 		cmd->req.transfer_len > 0 &&
-		!cmd->req.rsp->status;
+		!cmd->req.cqe->status;
 }
 
 static inline bool nvmet_tcp_has_inline_data(struct nvmet_tcp_cmd *cmd)
@@ -377,7 +377,7 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 	pdu->hdr.plen =
 		cpu_to_le32(pdu->hdr.hlen + hdgst +
 				cmd->req.transfer_len + ddgst);
-	pdu->command_id = cmd->req.rsp->command_id;
+	pdu->command_id = cmd->req.cqe->command_id;
 	pdu->data_length = cpu_to_le32(cmd->req.transfer_len);
 	pdu->data_offset = cpu_to_le32(cmd->wbytes_done);
 
@@ -1206,7 +1206,7 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 			sizeof(*c->rsp_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
 	if (!c->rsp_pdu)
 		goto out_free_cmd;
-	c->req.rsp = &c->rsp_pdu->cqe;
+	c->req.cqe = &c->rsp_pdu->cqe;
 
 	c->data_pdu = page_frag_alloc(&queue->pf_cache,
 			sizeof(*c->data_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
-- 
1.8.3.1
