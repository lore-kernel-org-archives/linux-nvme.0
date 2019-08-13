From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 12 Aug 2019 23:42:59 -0700
Subject: [PATCH v6 2/7] nvme: return a proper status for sync commands failure
In-Reply-To: <20190813064304.7344-1-sagi@grimberg.me>
References: <20190813064304.7344-1-sagi@grimberg.me>
Message-ID: <20190813064304.7344-3-sagi@grimberg.me>

callers should not rely on raw nvme status, instead return
is more appropriate blk_status_t.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 867c8977eb3e..f9bc10407f1b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -774,7 +774,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
- * if the result is positive, it's an NVM Express status code
+ * if the result is positive, it's a blk_status_t status code
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
@@ -805,7 +805,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
 	else
-		ret = nvme_req(req)->status;
+		ret = nvme_error_status(req);
  out:
 	blk_mq_free_request(req);
 	return ret;
-- 
2.17.1
