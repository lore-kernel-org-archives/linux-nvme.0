From: jsmart2021@gmail.com (James Smart)
Date: Tue, 18 Jul 2017 14:29:34 -0700
Subject: [PATCH] nvme_fc: address target disconnect race conditions in fcp io
 submit
Message-ID: <20170718212934.21410-1-jsmart2021@gmail.com>

There are cases where threads are in the process of submitting new
io when the LLDD calls in to remove the remote port. In some cases,
the next io actually goes to the LLDD, who knows the remoteport isn't
present and rejects it. To properly recovery/restart these i/o's we
don't want to hard fail them, we want to treat them as temporary
resource errors in which a delayed retry will work.

Add a couple more checks on remoteport connectivity and commonize the
busy response handling when it's seen.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8b6f3c849875..5c2a08ef08ba 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1888,7 +1888,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	 * the target device is present
 	 */
 	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
-		return BLK_STS_IOERR;
+		goto busy;
 
 	if (!nvme_fc_ctrl_get(ctrl))
 		return BLK_STS_IOERR;
@@ -1958,22 +1958,25 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 					queue->lldd_handle, &op->fcp_req);
 
 	if (ret) {
-		if (op->rq)			/* normal request */
+		if (!(op->flags & FCOP_FLAGS_AEN))
 			nvme_fc_unmap_data(ctrl, op->rq, op);
-		/* else - aen. no cleanup needed */
 
 		nvme_fc_ctrl_put(ctrl);
 
-		if (ret != -EBUSY)
+		if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE &&
+				ret != -EBUSY)
 			return BLK_STS_IOERR;
 
-		if (op->rq)
-			blk_mq_delay_run_hw_queue(queue->hctx, NVMEFC_QUEUE_DELAY);
-
-		return BLK_STS_RESOURCE;
+		goto busy;
 	}
 
 	return BLK_STS_OK;
+
+busy:
+	if (!(op->flags & FCOP_FLAGS_AEN) && queue->hctx)
+		blk_mq_delay_run_hw_queue(queue->hctx, NVMEFC_QUEUE_DELAY);
+
+	return BLK_STS_RESOURCE;
 }
 
 static blk_status_t
-- 
2.11.0
