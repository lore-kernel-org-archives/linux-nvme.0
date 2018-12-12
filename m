From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Wed, 12 Dec 2018 06:55:01 +0000
Subject: [PATCH 2/2] nvme-rdma: Handle completions if error_recovery fails
In-Reply-To: <20181212065501.21580-1-nitzanc@mellanox.com>
References: <20181212065501.21580-1-nitzanc@mellanox.com>
Message-ID: <20181212065501.21580-2-nitzanc@mellanox.com>

Error recovery might not be executed, in case ctrl.state
cannot be moved to RESETTING state. This might happen in:
 - state CONNECTING - during nvmf_connect command failure.
 - state DELETING - during nvmf_set_features command failure
                    (in nvme_shutdown_ctrl).

We need to complete these hanging requests with DNR error.

Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 101 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a9eed697505e..430dc5e6c77e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1055,32 +1055,52 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
-static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
-		return;
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
+		if (ctrl->ctrl.state == NVME_CTRL_RESETTING)
+			return 0;
+		else
+			return -EAGAIN;
+	}
 
 	queue_work(nvme_wq, &ctrl->err_work);
+	return 0;
 }
 
-static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
+static int nvme_rdma_wr_error(struct nvme_rdma_ctrl *ctrl, struct ib_wc *wc,
 		const char *op)
 {
-	struct nvme_rdma_queue *queue = cq->cq_context;
-	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
-
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
 		dev_info(ctrl->ctrl.device,
 			     "%s for CQE 0x%p failed with status %s (%d)\n",
 			     op, wc->wr_cqe,
 			     ib_wc_status_msg(wc->status), wc->status);
-	nvme_rdma_error_recovery(ctrl);
+	return nvme_rdma_error_recovery(ctrl);
+}
+
+static void nvme_rdma_req_error(struct nvme_rdma_request *req, struct ib_wc *wc,
+		const char *op)
+{
+	struct nvme_rdma_queue *queue = req->queue;
+	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+
+	if (nvme_rdma_wr_error(ctrl, wc, op) &&
+	    wc->status != IB_WC_WR_FLUSH_ERR) {
+		req->status = cpu_to_le16((NVME_SC_ABORT_REQ |
+					   NVME_SC_DNR) << 1);
+		nvme_end_request(blk_mq_rq_from_pdu(req), req->status,
+				 req->result);
+	}
 }
 
 static void nvme_rdma_memreg_done(struct ib_cq *cq, struct ib_wc *wc)
 {
+	struct nvme_rdma_request *req =
+		container_of(wc->wr_cqe, struct nvme_rdma_request, reg_cqe);
+
 	if (unlikely(wc->status != IB_WC_SUCCESS))
-		nvme_rdma_wr_error(cq, wc, "MEMREG");
+		nvme_rdma_req_error(req, wc, "MEMREG");
 }
 
 static void nvme_rdma_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -1090,7 +1110,7 @@ static void nvme_rdma_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct request *rq = blk_mq_rq_from_pdu(req);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
-		nvme_rdma_wr_error(cq, wc, "LOCAL_INV");
+		nvme_rdma_req_error(req, wc, "LOCAL_INV");
 		return;
 	}
 
@@ -1304,7 +1324,7 @@ static void nvme_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct request *rq = blk_mq_rq_from_pdu(req);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
-		nvme_rdma_wr_error(cq, wc, "SEND");
+		nvme_rdma_req_error(req, wc, "SEND");
 		return;
 	}
 
@@ -1380,8 +1400,10 @@ static struct blk_mq_tags *nvme_rdma_tagset(struct nvme_rdma_queue *queue)
 
 static void nvme_rdma_async_done(struct ib_cq *cq, struct ib_wc *wc)
 {
+	struct nvme_rdma_queue *queue = cq->cq_context;
+
 	if (unlikely(wc->status != IB_WC_SUCCESS))
-		nvme_rdma_wr_error(cq, wc, "ASYNC");
+		nvme_rdma_wr_error(queue->ctrl, wc, "ASYNC");
 }
 
 static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg)
@@ -1411,26 +1433,39 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg)
 	WARN_ON_ONCE(ret);
 }
 
-static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
-		struct nvme_completion *cqe, struct ib_wc *wc, int tag)
+static struct nvme_rdma_request *nvme_rdma_comp_to_req(
+		struct nvme_rdma_queue *queue, struct nvme_completion *cqe)
 {
 	struct request *rq;
 	struct nvme_rdma_request *req;
-	int ret = 0;
 
 	rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"tag 0x%x on QP %#x not found\n",
 			cqe->command_id, queue->qp->qp_num);
-		nvme_rdma_error_recovery(queue->ctrl);
-		return ret;
+		return NULL;
 	}
 	req = blk_mq_rq_to_pdu(rq);
-
 	req->status = cqe->status;
 	req->result = cqe->result;
 
+	return req;
+}
+
+static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
+		struct nvme_completion *cqe, struct ib_wc *wc, int tag)
+{
+	struct request *rq;
+	struct nvme_rdma_request *req;
+	int ret = 0;
+
+	req = nvme_rdma_comp_to_req(queue, cqe);
+	if (!req) {
+		nvme_rdma_error_recovery(queue->ctrl);
+		return ret;
+	}
+
 	if (wc->wc_flags & IB_WC_WITH_INVALIDATE) {
 		if (unlikely(wc->ex.invalidate_rkey != req->mr->rkey)) {
 			dev_err(queue->ctrl->ctrl.device,
@@ -1451,6 +1486,7 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 	}
 
 	if (refcount_dec_and_test(&req->ref)) {
+		rq = blk_mq_rq_from_pdu(req);
 		if (rq->tag == tag)
 			ret = 1;
 		nvme_end_request(rq, req->status, req->result);
@@ -1466,11 +1502,21 @@ static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
 	struct nvme_rdma_queue *queue = cq->cq_context;
 	struct ib_device *ibdev = queue->device->dev;
 	struct nvme_completion *cqe = qe->data;
+	struct nvme_rdma_request *req;
 	const size_t len = sizeof(struct nvme_completion);
 	int ret = 0;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
-		nvme_rdma_wr_error(cq, wc, "RECV");
+		if (!nvme_is_aen_req(nvme_rdma_queue_idx(queue),
+				     cqe->command_id) &&
+		    wc->status != IB_WC_WR_FLUSH_ERR) {
+			req = nvme_rdma_comp_to_req(queue, cqe);
+			if (req) {
+				nvme_rdma_req_error(req, wc, "RECV");
+				return 0;
+			}
+		}
+		nvme_rdma_wr_error(queue->ctrl, wc, "RECV");
 		return 0;
 	}
 
@@ -1679,16 +1725,21 @@ static enum blk_eh_timer_return
 nvme_rdma_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_ctrl *ctrl = req->queue->ctrl;
 
-	dev_warn(req->queue->ctrl->ctrl.device,
+	dev_warn(ctrl->ctrl.device,
 		 "I/O %d QID %d timeout, reset controller\n",
 		 rq->tag, nvme_rdma_queue_idx(req->queue));
 
-	/* queue error recovery */
-	nvme_rdma_error_recovery(req->queue->ctrl);
-
-	/* fail with DNR on cmd timeout */
-	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
+	/*
+	 * if error recovery succeed it will end the request,
+	 * otherwise we have to manually end it
+	 */
+	if (nvme_rdma_error_recovery(ctrl)) {
+		req->status = cpu_to_le16((NVME_SC_ABORT_REQ |
+					   NVME_SC_DNR) << 1);
+		nvme_end_request(rq, req->status, req->result);
+	}
 
 	return BLK_EH_DONE;
 }
-- 
2.14.3
