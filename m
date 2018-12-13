From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Dec 2018 13:29:17 -0800
Subject: [PATCH] nvme-rdma: fix timeout handler
Message-ID: <20181213212917.8900-1-sagi@grimberg.me>

Currently, we have several problems with the timeout
handler:
1. If we timeout on the controller establishment flow, we will
hang because we don't execute the error recovery (and we shouldn't
because the create_ctrl flow needs to fail and cleanup on its own)
2. We might also hang if we get a disconnet on a queue while the
controller is already deleting. This racy flow can cause the
controller disable/shutdown admin command to hang.

We cannot complete a timed out request from the timeout handler
without mutual exclusion from the teardown flow (e.g.
nvme_rdma_error_recovery_work). So we serialize it in the
timeout handler and stop the queue to guarantee that no
one races with us from completing the request.

Reported-by: Jaesoo Lee <jalee at purestorage.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 80b3113b45fb..af8f4cedabc1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1080,12 +1080,13 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
-static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
-		return;
+		return -EBUSY;
 
 	queue_work(nvme_wq, &ctrl->err_work);
+	return 0;
 }
 
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
@@ -1693,18 +1694,30 @@ static enum blk_eh_timer_return
 nvme_rdma_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_queue *queue = req->queue;
+	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+
+	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
+		 rq->tag, nvme_rdma_queue_idx(queue));
 
-	dev_warn(req->queue->ctrl->ctrl.device,
-		 "I/O %d QID %d timeout, reset controller\n",
-		 rq->tag, nvme_rdma_queue_idx(req->queue));
+	if (nvme_rdma_error_recovery(req->queue->ctrl)) {
+		union nvme_result res = {};
 
-	/* queue error recovery */
-	nvme_rdma_error_recovery(req->queue->ctrl);
+		nvme_rdma_stop_queue(queue);
+		flush_work(&ctrl->err_work);
 
-	/* fail with DNR on cmd timeout */
-	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
+		/*
+		 * now no-one is competing with us, safely check if the
+		 * was completed and fail it if not.
+		 */
+		if (READ_ONCE(rq->state) != MQ_RQ_COMPLETE) {
+			nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
+			nvme_end_request(rq, NVME_SC_ABORT_REQ, res);
+			return BLK_EH_DONE;
+		}
+	}
 
-	return BLK_EH_DONE;
+	return BLK_EH_RESET_TIMER;
 }
 
 static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
-- 
2.17.1
