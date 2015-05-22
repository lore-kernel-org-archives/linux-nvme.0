From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 May 2015 12:28:31 -0600
Subject: [PATCH] NVMe: Fix obtaining command result
Message-ID: <1432319311-2895-1-git-send-email-keith.busch@intel.com>

Replaces req->sense_len usage, which is not owned by the LLD, to
req->special to contain the command result for driver created commands,
and sets the result unconditionally on completion.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Jens Axboe <axboe at fb.com>
---
 drivers/block/nvme-core.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 03bd638..c42bc53 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -606,13 +606,16 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 			return;
 		}
 		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
-			req->sense_len = le32_to_cpup(&cqe->result);
 			req->errors = status;
 		} else {
 			req->errors = nvme_error_status(status);
 		}
 	} else
 		req->errors = 0;
+	if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
+		u32 result = le32_to_cpup(&cqe->result);
+		req->special = (void *)(uintptr_t)result;
+	}
 
 	if (cmd_rq->aborted)
 		dev_warn(nvmeq->dev->dev,
@@ -1015,8 +1018,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 
 	req->cmd = (unsigned char *)cmd;
 	req->cmd_len = sizeof(struct nvme_command);
-	req->sense = NULL;
-	req->sense_len = 0;
+	req->special = (void *)0;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, __GFP_WAIT);
@@ -1033,7 +1035,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (bio)
 		blk_rq_unmap_user(bio);
 	if (result)
-		*result = req->sense_len;
+		*result = (u32)(uintptr_t)req->special;
 	ret = req->errors;
  out:
 	blk_mq_free_request(req);
-- 
1.7.10.4
