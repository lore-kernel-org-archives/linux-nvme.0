From: hch@lst.de (Christoph Hellwig)
Date: Wed, 30 May 2018 08:11:16 +0200
Subject: [PATCH] nvme-fabrics: allow internal passthrough command on deleting
 controllers
Message-ID: <20180530061116.23610-1-hch@lst.de>

Without this we can't cleanly shut down.

Based on analysis an an earlier patch from Hannes Reinecke.

Fixes: bb06ec31452f ("nvme: expand nvmf_check_if_ready checks")
Reported-by: Hannes Reinecke <hare at suse.de>
Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: James Smart <james.smart at broadcom.com>
---

Note: Pending full testing on FC by James..


 drivers/nvme/host/fabrics.c | 79 +++++++++++++++----------------------
 1 file changed, 31 insertions(+), 48 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index aa318136460e..5f5f7067c41d 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -545,71 +545,54 @@ blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		return BLK_STS_OK;
 
 	switch (ctrl->state) {
-	case NVME_CTRL_DELETING:
-		goto reject_io;
-
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
+	case NVME_CTRL_DELETING:
+		/*
+		 * This is the case of starting a new or deleting an association
+		 * but connectivity was lost before it was fully created or torn
+		 * down. We need to error the commands used to initialize the
+		 * controller so the reconnect can go into a retry attempt.  The
+		 * commands should all be marked REQ_FAILFAST_DRIVER, which will
+		 * hit the reject path below. Anything else will be queued while
+		 * the state settles.
+		 */
 		if (!is_connected)
-			/*
-			 * This is the case of starting a new
-			 * association but connectivity was lost
-			 * before it was fully created. We need to
-			 * error the commands used to initialize the
-			 * controller so the reconnect can go into a
-			 * retry attempt. The commands should all be
-			 * marked REQ_FAILFAST_DRIVER, which will hit
-			 * the reject path below. Anything else will
-			 * be queued while the state settles.
-			 */
-			goto reject_or_queue_io;
-
-		if ((queue_live &&
-		     !(nvme_req(rq)->flags & NVME_REQ_USERCMD)) ||
-		    (!queue_live && blk_rq_is_passthrough(rq) &&
-		     cmd->common.opcode == nvme_fabrics_command &&
-		     cmd->fabrics.fctype == nvme_fabrics_type_connect))
-			/*
-			 * If queue is live, allow only commands that
-			 * are internally generated pass through. These
-			 * are commands on the admin queue to initialize
-			 * the controller. This will reject any ioctl
-			 * admin cmds received while initializing.
-			 *
-			 * If the queue is not live, allow only a
-			 * connect command. This will reject any ioctl
-			 * admin cmd as well as initialization commands
-			 * if the controller reverted the queue to non-live.
-			 */
+			break;
+
+		/*
+		 * If queue is live, allow only commands that are internally
+		 * generated pass through.  These are commands on the admin
+		 * queue to initialize the controller. This will reject any
+		 * ioctl admin cmds received while initializing.
+		 */
+		if (queue_live && !(nvme_req(rq)->flags & NVME_REQ_USERCMD))
 			return BLK_STS_OK;
 
 		/*
-		 * fall-thru to the reject_or_queue_io clause
+		 * If the queue is not live, allow only a connect command.  This
+		 * will reject any ioctl admin cmd as well as initialization
+		 * commands if the controller reverted the queue to non-live.
 		 */
+		if (!queue_live && blk_rq_is_passthrough(rq) &&
+		     cmd->common.opcode == nvme_fabrics_command &&
+		     cmd->fabrics.fctype == nvme_fabrics_type_connect)
+			return BLK_STS_OK;
 		break;
-
-	/* these cases fall-thru
-	 * case NVME_CTRL_LIVE:
-	 * case NVME_CTRL_RESETTING:
-	 */
 	default:
 		break;
 	}
 
-reject_or_queue_io:
 	/*
-	 * Any other new io is something we're not in a state to send
-	 * to the device. Default action is to busy it and retry it
-	 * after the controller state is recovered. However, anything
-	 * marked for failfast or nvme multipath is immediately failed.
-	 * Note: commands used to initialize the controller will be
-	 *  marked for failfast.
+	 * Any other new io is something we're not in a state to send to the
+	 * device.  Default action is to busy it and retry it after the
+	 * controller state is recovered. However, anything marked for failfast
+	 * or nvme multipath is immediately failed.  Note: commands used to
+	 * initialize the controller will be marked for failfast.
 	 * Note: nvme cli/ioctl commands are marked for failfast.
 	 */
 	if (!blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
-
-reject_io:
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
 	return BLK_STS_IOERR;
 }
-- 
2.17.0
