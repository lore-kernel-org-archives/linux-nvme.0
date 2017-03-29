From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 Mar 2017 21:00:25 +0300
Subject: [PATCH 1/3] nvme-rdma: increment request retries counter before
 requeuing
In-Reply-To: <1490810427-27776-1-git-send-email-sagi@grimberg.me>
References: <1490810427-27776-1-git-send-email-sagi@grimberg.me>
Message-ID: <1490810427-27776-2-git-send-email-sagi@grimberg.me>

This way our max retry limit holds as well.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a92791c485d1..c8f703e68d73 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1526,6 +1526,7 @@ static void nvme_rdma_complete_rq(struct request *rq)
 
 	if (unlikely(rq->errors)) {
 		if (nvme_req_needs_retry(rq, rq->errors)) {
+			rq->retries++;
 			nvme_requeue_req(rq);
 			return;
 		}
-- 
2.7.4
