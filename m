From: jsmart2021@gmail.com (James Smart)
Date: Thu, 19 Oct 2017 16:11:39 -0700
Subject: [PATCH v2 2/2] nvme_fc: correct io timeout behavior
In-Reply-To: <20171019231139.23611-1-jsmart2021@gmail.com>
References: <20171019231139.23611-1-jsmart2021@gmail.com>
Message-ID: <20171019231139.23611-3-jsmart2021@gmail.com>

The transport io timeout behavior wasn't quite correct. It ignored
that the io error handler is supposed to be synchronous so it possibly
allowed the blk request to be restarted while the io associated was
still aborting. Timeouts on reserved commands, those used for
association create, were never timing out thus they hung out forever.

To correct:
If an io is times out while a remoteport is not connected, just
restart the io timer. The lack of connectivity will simultaneously
be resetting the controller, so the reset path will abort and terminate
the io.

If an io is times out while it was marked for transport abort, just
reset the io timer. The abort process is underway and will complete
the io.

Otherwise, if an io times out, abort the io. If the abort was
unsuccessful (unlikely) give up and return not handled.

If the abort was successful, as the abort process is underway it will
terminate the io, so rather than synchronously waiting, just restart
the io timer.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ce8617188d3a..78091bc7af69 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1903,13 +1903,14 @@ nvme_fc_timeout(struct request *rq, bool reserved)
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
@@ -1920,7 +1921,12 @@ nvme_fc_timeout(struct request *rq, bool reserved)
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
