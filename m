From: hare@suse.de (Hannes Reinecke)
Date: Mon, 12 Aug 2019 09:51:47 +0200
Subject: [PATCHv3] nvme: Return BLK_STS_TARGET if the DNR bit is set
Message-ID: <20190812075147.79598-1-hare@suse.de>

If the DNR bit is set we should not retry the command, even if
the standard status evaluation indicates so.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cc09b81fc7f4..5e1309709917 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -267,15 +267,20 @@ void nvme_complete_rq(struct request *req)
 	if (nvme_req(req)->ctrl->kas)
 		nvme_req(req)->ctrl->comp_seen = true;
 
-	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) &&
-		    blk_path_error(status)) {
-			nvme_failover_req(req);
-			return;
+	if (unlikely(status != BLK_STS_OK)) {
+		if (nvme_req_needs_retry(req)) {
+			if ((req->cmd_flags & REQ_NVME_MPATH) &&
+			    blk_path_error(status)) {
+				nvme_failover_req(req);
+				return;
+			}
+			if (!blk_queue_dying(req->q)) {
+				nvme_retry_req(req);
+				return;
+			}
 		}
-
-		if (!blk_queue_dying(req->q)) {
-			nvme_retry_req(req);
+		if (nvme_req(req)->status & NVME_SC_DNR) {
+			blk_mq_end_request(req, BLK_STS_TARGET);
 			return;
 		}
 	}
-- 
2.16.4
