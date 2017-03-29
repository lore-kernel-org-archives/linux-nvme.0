From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 Mar 2017 21:00:26 +0300
Subject: [PATCH 2/3] nvme-loop: increment request retries counter before
 requeuing
In-Reply-To: <1490810427-27776-1-git-send-email-sagi@grimberg.me>
References: <1490810427-27776-1-git-send-email-sagi@grimberg.me>
Message-ID: <1490810427-27776-3-git-send-email-sagi@grimberg.me>

This way our max retry limit holds as well.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 227a5320879e..6a54e387379e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -98,6 +98,7 @@ static void nvme_loop_complete_rq(struct request *req)
 
 	if (unlikely(req->errors)) {
 		if (nvme_req_needs_retry(req, req->errors)) {
+			req->retries++;
 			nvme_requeue_req(req);
 			return;
 		}
-- 
2.7.4
