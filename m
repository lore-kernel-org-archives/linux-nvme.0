From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Jun 2018 10:16:16 +0200
Subject: [PATCH 1/4] nvme-fabrics: refactor queue ready check
In-Reply-To: <99751a08-8485-787f-95bc-862b8f9d02ed@broadcom.com>
References: <20180611154647.32558-1-hch@lst.de>
 <20180611154647.32558-2-hch@lst.de>
 <99751a08-8485-787f-95bc-862b8f9d02ed@broadcom.com>
Message-ID: <20180613081616.GA23377@lst.de>

On Tue, Jun 12, 2018@02:45:16PM -0700, James Smart wrote:
> Additionally, if a user-mode delete request is made while in the middle of 
> a RECONNECT, and the io the if_ready is looking at is part of the reconnect 
> - we're allowing the connect command to go out/complete even though we're 
> in the middle of deleting it.?? May well be fine - but I don't know why 
> we're letting all this io through simply because we didn't want to add a 
> check for a property_set() on a reset or delete.

so what about something like this on top of the series (untested so far):


diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index dc87719a5c9e..a36a74b2cb8e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -556,24 +556,31 @@ EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
 bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		bool queue_live)
 {
-	if (ctrl->state == NVME_CTRL_DEAD)
-		return false;
+	struct nvme_request *req = nvme_req(rq);
 
 	/*
-	 * If the queue is not live the only thing allowed is a connect
-	 * command to actually set the queue live.
+	 * If we are in some state of setup or teardown only allow
+	 * internally generated commands.
 	 */
-	if (!queue_live &&
-	    (nvme_req(rq)->cmd->common.opcode != nvme_fabrics_command ||
-	     nvme_req(rq)->cmd->fabrics.fctype != nvme_fabrics_type_connect))
+	if (!blk_rq_is_passthrough(rq) || (req->flags & NVME_REQ_USERCMD))
 		return false;
 
 	/*
-	 * If we are in some state of setup or teardown only allow
-	 * internally generated commands.
+	 * Only allow commands on a live queue, except for the connect command,
+	 * which is require to set the queue live in the appropinquate states.
 	 */
-	return blk_rq_is_passthrough(rq) &&
-		!(nvme_req(rq)->flags & NVME_REQ_USERCMD);
+	switch (ctrl->state) {
+	case NVME_CTRL_DEAD:
+		return false;
+	case NVME_CTRL_NEW:
+	case NVME_CTRL_CONNECTING:
+		if (req->cmd->common.opcode == nvme_fabrics_command &&
+		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
+			return true;
+		/*FALLTHRU*/
+	default:
+		return queue_live;
+	}
 }
 EXPORT_SYMBOL_GPL(__nvmf_check_ready);
 
