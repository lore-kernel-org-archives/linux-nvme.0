From: hch@lst.de (Christoph Hellwig)
Date: Thu, 14 Jun 2018 14:22:15 +0200
Subject: [PATCH 3/3] nvme-fabrics: fix and refine state checks in
 __nvmf_check_ready
In-Reply-To: <20180614122215.4395-1-hch@lst.de>
References: <20180614122215.4395-1-hch@lst.de>
Message-ID: <20180614122215.4395-4-hch@lst.de>

 - make sure we only allow internally generates commands in any non-live
   state
 - only allow connect commands on non-live queues when actually in the
   new or connecting states
 - treat all other non-live, non-dead states the same as a default
   cach-all

This fixes a regression where we could not shutdown a controller
orderly as we didn't allow the internal generated Property Set
command, and also ensures we don't accidentally let a Connect command
through in the wrong state.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fabrics.c | 39 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 6b4e253b9347..903eb4545e26 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -556,34 +556,33 @@ EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
 bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		bool queue_live)
 {
-	struct nvme_command *cmd = nvme_req(rq)->cmd;
+	struct nvme_request *req = nvme_req(rq);
 
+	/*
+	 * If we are in some state of setup or teardown only allow
+	 * internally generated commands.
+	 */
+	if (!blk_rq_is_passthrough(rq) || (req->flags & NVME_REQ_USERCMD))
+		return false;
+
+	/*
+	 * Only allow commands on a live queue, except for the connect command,
+	 * which is require to set the queue live in the appropinquate states.
+	 */
 	switch (ctrl->state) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
-	case NVME_CTRL_DELETING:
-		/*
-		 * If queue is live, allow only commands that are internally
-		 * generated pass through.  These are commands on the admin
-		 * queue to initialize the controller. This will reject any
-		 * ioctl admin cmds received while initializing.
-		 */
-		if (queue_live && !(nvme_req(rq)->flags & NVME_REQ_USERCMD))
+		if (req->cmd->common.opcode == nvme_fabrics_command &&
+		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
 			return true;
-
-		/*
-		 * If the queue is not live, allow only a connect command.  This
-		 * will reject any ioctl admin cmd as well as initialization
-		 * commands if the controller reverted the queue to non-live.
-		 */
-		if (!queue_live && blk_rq_is_passthrough(rq) &&
-		     cmd->common.opcode == nvme_fabrics_command &&
-		     cmd->fabrics.fctype == nvme_fabrics_type_connect)
-			return true;
-		return false;
+		break;
 	default:
+		break;
+	case NVME_CTRL_DEAD:
 		return false;
 	}
+
+	return queue_live;
 }
 EXPORT_SYMBOL_GPL(__nvmf_check_ready);
 
-- 
2.17.1
