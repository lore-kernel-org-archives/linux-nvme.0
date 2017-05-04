From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu,  4 May 2017 11:07:35 -0700
Subject: [RFC 5/7] nvme_fc: change failure code on remoteport connectivity loss
In-Reply-To: <20170504180737.5472-1-jsmart2021@gmail.com>
References: <20170504180737.5472-1-jsmart2021@gmail.com>
Message-ID: <20170504180737.5472-6-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Rather than return BLK_MQ_RQ_QUEUE_ERROR if connectivity has been
lost to the remoteport, which gets reflected all the way back to the
user, change failure location to let the lldd bounce it and have it
fall back into the busy logic which requeues the io.

This addresses io failures that occur on ios issued right at the time
of connectivity loss.

Note: check of connectivity is not done under a lock to avoid a
fast-path performance penalty. Thus expectation is that LLDD will
validate the connectivity as well.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 419d4a85218d..a666f87e2437 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1916,13 +1916,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	u32 csn;
 	int ret;
 
-	/*
-	 * before attempting to send the io, check to see if we believe
-	 * the target device is present
-	 */
-	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
-		return BLK_MQ_RQ_QUEUE_ERROR;
-
 	if (!nvme_fc_ctrl_get(ctrl))
 		return BLK_MQ_RQ_QUEUE_ERROR;
 
@@ -1998,7 +1991,8 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 
 		nvme_fc_ctrl_put(ctrl);
 
-		if (ret != -EBUSY)
+		if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE &&
+				ret != -EBUSY)
 			return BLK_MQ_RQ_QUEUE_ERROR;
 
 		if (op->rq) {
-- 
2.11.0
