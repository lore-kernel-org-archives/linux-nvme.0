From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:51 -0700
Subject: [PATCHv3 10/12] NVMe: Command abort handling fixes
In-Reply-To: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
References: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420682153-3756-11-git-send-email-keith.busch@intel.com>

Aborts all requeued commands prior to killing the request_queue. For
commands that time out on a dying request queue, set the "Do Not Retry"
bit on the command status so the command cannot be requeued. Finanally, if
the driver is requested to abort a command it did not start, do nothing.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 66ade19..f562394 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1064,15 +1064,22 @@ static void nvme_cancel_queue_ios(struct blk_mq_hw_ctx *hctx,
 	void *ctx;
 	nvme_completion_fn fn;
 	struct nvme_cmd_info *cmd;
-	static struct nvme_completion cqe = {
-		.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
-	};
+	struct nvme_completion cqe;
+
+	if (!blk_mq_request_started(req))
+		return;
 
 	cmd = blk_mq_rq_to_pdu(req);
 
 	if (cmd->ctx == CMD_CTX_CANCELLED)
 		return;
 
+	if (blk_queue_dying(req->q))
+		cqe.status = cpu_to_le16((NVME_SC_ABORT_REQ | NVME_SC_DNR) << 1);
+	else
+		cqe.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
+
+
 	dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n",
 						req->tag, nvmeq->qid);
 	ctx = cancel_cmd_info(cmd, &fn);
@@ -2429,8 +2436,10 @@ static void nvme_dev_remove(struct nvme_dev *dev)
 	list_for_each_entry(ns, &dev->namespaces, list) {
 		if (ns->disk->flags & GENHD_FL_UP)
 			del_gendisk(ns->disk);
-		if (!blk_queue_dying(ns->queue))
+		if (!blk_queue_dying(ns->queue)) {
+			blk_mq_abort_requeue_list(ns->queue);
 			blk_cleanup_queue(ns->queue);
+		}
 	}
 }
 
-- 
1.7.10.4
