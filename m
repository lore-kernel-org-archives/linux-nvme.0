From: jsmart2021@gmail.com (James Smart)
Date: Mon, 12 Mar 2018 09:32:22 -0700
Subject: [PATCH] nvme_fc: io timeout should defer abort to ctrl reset
Message-ID: <20180312163222.23043-1-jsmart2021@gmail.com>

The current nvme_fc code, when an io times out, will abort the io
on the fc link, then call the error recovery routine to reset the
controller. It is during the reset of the controller that the
transport will wait for all ios to be aborted before sending a
Disconnect LS to the target.

However, the reset routine only waits for the io which it generates
the abort for to complete. Any io that was aborted just prior to the
reset isn't in it's list to wait for. Thus the Disconnect is getting
sent before the aborts have completed.

Correct by removing the abort in the timeout handler. The reset will
generate the abort. At that point the timeout handler can be simplified
to request the reset (via the error handler) and restart the timeout
timer.

Also fixes a small typo in a comment in the reset handler.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 590c5b99cae8..b3ada7076801 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2080,20 +2080,10 @@ nvme_fc_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
-	int ret;
-
-	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE ||
-			atomic_read(&op->state) == FCPOP_STATE_ABORTED)
-		return BLK_EH_RESET_TIMER;
-
-	ret = __nvme_fc_abort_op(ctrl, op);
-	if (ret)
-		/* io wasn't active to abort */
-		return BLK_EH_NOT_HANDLED;
 
 	/*
 	 * we can't individually ABTS an io without affecting the queue,
-	 * thus killing the queue, adn thus the association.
+	 * thus killing the queue, and thus the association.
 	 * So resolve by performing a controller reset, which will stop
 	 * the host/io stack, terminate the association on the link,
 	 * and recreate an association on the link.
-- 
2.13.1
