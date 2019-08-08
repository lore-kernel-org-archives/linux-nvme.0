From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  8 Aug 2019 16:25:31 -0700
Subject: [PATCH v4 2/7] nvme: return a proper errno for sync commands failure
In-Reply-To: <20190808232536.4258-1-sagi@grimberg.me>
References: <20190808232536.4258-1-sagi@grimberg.me>
Message-ID: <20190808232536.4258-3-sagi@grimberg.me>

callers should not rely on raw nvme status, instead return
is more appropriate errno that relates to blk_status_t.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d2b4f57fa67e..c259586eeadc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -803,7 +803,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
 	else
-		ret = nvme_req(req)->status;
+		ret = blk_status_to_errno(nvme_error_status(req));
  out:
 	blk_mq_free_request(req);
 	return ret;
@@ -894,7 +894,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
 	else
-		ret = nvme_req(req)->status;
+		ret = blk_status_to_errno(nvme_error_status(req));
 	if (result)
 		*result = le32_to_cpu(nvme_req(req)->result.u32);
 	if (meta && !ret && !write) {
-- 
2.17.1
