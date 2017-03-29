From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 Mar 2017 21:00:27 +0300
Subject: [PATCH 3/3] nvme-fc: increment request retries counter before
 requeuing
In-Reply-To: <1490810427-27776-1-git-send-email-sagi@grimberg.me>
References: <1490810427-27776-1-git-send-email-sagi@grimberg.me>
Message-ID: <1490810427-27776-4-git-send-email-sagi@grimberg.me>

This way our max retry limit holds as well.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 331ae9f8924d..2987f5ecd496 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1935,6 +1935,7 @@ nvme_fc_complete_rq(struct request *rq)
 
 	if (unlikely(rq->errors)) {
 		if (nvme_req_needs_retry(rq, rq->errors)) {
+			rq->retries++;
 			nvme_requeue_req(rq);
 			return;
 		}
-- 
2.7.4
