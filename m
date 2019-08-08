From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  8 Aug 2019 13:53:20 -0700
Subject: [PATCH v3 2/7] nvme: return nvme_error_status for sync commands
 failure
In-Reply-To: <20190808205325.24036-1-sagi@grimberg.me>
References: <20190808205325.24036-1-sagi@grimberg.me>
Message-ID: <20190808205325.24036-3-sagi@grimberg.me>

callers should not rely on raw nvme status, blk_status_t
is more appropriate.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d2b4f57fa67e..f435c85c4062 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -803,7 +803,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
 	else
-		ret = nvme_req(req)->status;
+		ret = nvme_error_status(req);
  out:
 	blk_mq_free_request(req);
 	return ret;
@@ -894,7 +894,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
 	else
-		ret = nvme_req(req)->status;
+		ret = nvme_error_status(req);
 	if (result)
 		*result = le32_to_cpu(nvme_req(req)->result.u32);
 	if (meta && !ret && !write) {
-- 
2.17.1
