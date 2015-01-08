From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:48 -0700
Subject: [PATCHv3 07/12] NVMe: Start all requests
In-Reply-To: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
References: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420682153-3756-8-git-send-email-keith.busch@intel.com>

Once the nvme callback is set for a request, the driver can start it
and make it available for timeout handling. For timed out commands on a
device that is not initialized, this fixes potential deadlocks that can
occur on startup and shutdown when a device is unresponsive since they
can now be cancelled.

Asynchronous requests do not have any expected timeout, so these are
using the new "REQ_NO_TIMEOUT" request flags.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index f7d083b..286fa4c 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -215,6 +215,7 @@ static void nvme_set_info(struct nvme_cmd_info *cmd, void *ctx,
 	cmd->fn = handler;
 	cmd->ctx = ctx;
 	cmd->aborted = 0;
+	blk_mq_start_request(blk_mq_rq_from_pdu(cmd));
 }
 
 /* Special values must be less than 0x1000 */
@@ -664,8 +665,6 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 	}
 
-	blk_mq_start_request(req);
-
 	nvme_set_info(cmd, iod, req_completion);
 	spin_lock_irq(&nvmeq->q_lock);
 	if (req->cmd_flags & REQ_DISCARD)
@@ -835,6 +834,7 @@ static int nvme_submit_async_admin_req(struct nvme_dev *dev)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
+	req->cmd_flags |= REQ_NO_TIMEOUT;
 	cmd_info = blk_mq_rq_to_pdu(req);
 	nvme_set_info(cmd_info, req, async_req_completion);
 
@@ -1086,8 +1086,16 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 
 	dev_warn(nvmeq->q_dmadev, "Timeout I/O %d QID %d\n", req->tag,
 							nvmeq->qid);
-	if (nvmeq->dev->initialized)
-		nvme_abort_req(req);
+
+	if (!nvmeq->dev->initialized) {
+		/*
+		 * Force cancelled command frees the request, which requires we
+		 * return BLK_EH_NOT_HANDLED.
+		 */
+		nvme_cancel_queue_ios(nvmeq->hctx, req, nvmeq, reserved);
+		return BLK_EH_NOT_HANDLED;
+	}
+	nvme_abort_req(req);
 
 	/*
 	 * The aborted req will be completed on receiving the abort req.
-- 
1.7.10.4
