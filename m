From: jsmart2021@gmail.com (James Smart)
Date: Tue, 26 Sep 2017 21:13:17 -0700
Subject: [PATCH] nvme_fc: correct io timeout behavior
Message-ID: <20170927041317.6575-1-jsmart2021@gmail.com>

the transport io timeout behavior wasn't quite correct. It ignored
that the io termination is supposed to be synchronous so it possibly
allowed the blk request to be restarted while the io associated was
still aborting. Timeouts on reserved commands, those used for
association create, where never timing out, they hung out forever.
We also were setting DNR in cases where we wanted to allow an io
retry, which caused apps to see errors they shouldn't have.

Thus following changes made:
- clean up how we set the Aborted status and DNR
- don't treat reserved commands differently, let them timeout.
  Other retry policies will kick in.
- rather than wait for aborts to finish and block the thread,
  initiate the abort and restart the timeout timer. The abort
  will complete and complete the io.
- in cases of timeout while port is disconnected or abort is in
  progress, simply restart the timeout timer. The devloss
  functionality and abort completion will resolve it.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index af075e998944..346513cb8b49 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1374,7 +1374,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
 
 	if (atomic_read(&op->state) == FCPOP_STATE_ABORTED)
-		status = cpu_to_le16((NVME_SC_ABORT_REQ | NVME_SC_DNR) << 1);
+		status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
 	else if (freq->status)
 		status = cpu_to_le16(NVME_SC_INTERNAL << 1);
 
@@ -1445,15 +1445,22 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		goto check_error;
 	}
 
+	if (unlikely(!status && op->flags & FCOP_FLAGS_TERMIO))
+		status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
+
+	/*
+	 * Force failures of commands if we're killing the controller
+	 * or have an error on a command used to create an new association
+	 */
+	if (status && (blk_queue_dying(rq->q) ||
+			ctrl->ctrl.state == NVME_CTRL_NEW ||
+			ctrl->ctrl.state == NVME_CTRL_RECONNECTING))
+		status |= cpu_to_le16(NVME_SC_DNR << 1);
+
 	complete_rq = __nvme_fc_fcpop_chk_teardowns(ctrl, op);
-	if (!complete_rq) {
-		if (unlikely(op->flags & FCOP_FLAGS_TERMIO)) {
-			status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
-			if (blk_queue_dying(rq->q))
-				status |= cpu_to_le16(NVME_SC_DNR << 1);
-		}
+	if (!complete_rq)
 		nvme_end_request(rq, status, result);
-	} else
+	else
 		__nvme_fc_final_op_cleanup(rq);
 
 check_error:
@@ -1842,13 +1849,14 @@ nvme_fc_timeout(struct request *rq, bool reserved)
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
 	int ret;
 
-	if (reserved)
+	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE ||
+			atomic_read(&op->state) == FCPOP_STATE_ABORTED)
 		return BLK_EH_RESET_TIMER;
 
 	ret = __nvme_fc_abort_op(ctrl, op);
 	if (ret)
-		/* io wasn't active to abort consider it done */
-		return BLK_EH_HANDLED;
+		/* io wasn't active to abort */
+		return BLK_EH_NOT_HANDLED;
 
 	/*
 	 * we can't individually ABTS an io without affecting the queue,
@@ -1859,7 +1867,12 @@ nvme_fc_timeout(struct request *rq, bool reserved)
 	 */
 	nvme_fc_error_recovery(ctrl, "io timeout error");
 
-	return BLK_EH_HANDLED;
+	/*
+	 * the io abort has been initiated. Have the reset timer
+	 * restarted and the abort completion will complete the io
+	 * shortly. Avoids a synchronous wait while the abort finishes.
+	 */
+	return BLK_EH_RESET_TIMER;
 }
 
 static int
-- 
2.13.1
