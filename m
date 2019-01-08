From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  8 Jan 2019 00:57:34 -0800
Subject: [PATCH v2] nvme-rdma: fix timeout handler
Message-ID: <20190108085734.9681-1-sagi@grimberg.me>

Currently, we have several problems with the timeout
handler:
1. If we timeout on the controller establishment flow, we will hang
because we don't execute the error recovery (and we shouldn't because
the create_ctrl flow needs to fail and cleanup on its own)
2. We might also hang if we get a disconnet on a queue while the
controller is already deleting. This racy flow can cause the controller
disable/shutdown admin command to hang.

We cannot complete a timed out request from the timeout handler without
mutual exclusion from the teardown flow (e.g. nvme_rdma_error_recovery_work).
So we serialize it in the timeout handler and teardown io and admin
queues to guarantee that no one races with us from completing the
request.

Reported-by: Jaesoo Lee <jalee at purestorage.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
This is a slightly different version that looks more like pci
behavior as we teardown the controller if we are connection
or deleting in the timeout handler.

 drivers/nvme/host/rdma.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e63f36c09c9a..079d59c04a0e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1681,18 +1681,28 @@ static enum blk_eh_timer_return
 nvme_rdma_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_queue *queue = req->queue;
+	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 
-	dev_warn(req->queue->ctrl->ctrl.device,
-		 "I/O %d QID %d timeout, reset controller\n",
-		 rq->tag, nvme_rdma_queue_idx(req->queue));
+	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
+		 rq->tag, nvme_rdma_queue_idx(queue));
 
-	/* queue error recovery */
-	nvme_rdma_error_recovery(req->queue->ctrl);
+	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
+		/*
+		 * teardown immediately if controller times out while starting
+		 * or we are already started error recovery. all outstanding
+		 * requests are completed on shutdown, so we return BLK_EH_DONE.
+		 */
+		flush_work(&ctrl->err_work);
+		nvme_rdma_teardown_io_queues(ctrl, false);
+		nvme_rdma_teardown_admin_queue(ctrl, false);
+		return BLK_EH_DONE;
+	}
 
-	/* fail with DNR on cmd timeout */
-	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
+	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
+	nvme_rdma_error_recovery(ctrl);
 
-	return BLK_EH_DONE;
+	return BLK_EH_RESET_TIMER;
 }
 
 static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
-- 
2.17.1
