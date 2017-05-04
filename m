From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 May 2017 13:33:08 +0300
Subject: [PATCH 04/11] nvme-rdma: Don't rearm the CQ when polling directly
In-Reply-To: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
Message-ID: <1493893995-27063-5-git-send-email-sagi@grimberg.me>

We don't need it as the core polling context will take
are of rearming the completion queue.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5a29e1ea1934..d76fcb22b2c4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1496,7 +1496,6 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	struct ib_wc wc;
 	int found = 0;
 
-	ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
 	while (ib_poll_cq(cq, 1, &wc) > 0) {
 		struct ib_cqe *cqe = wc.wr_cqe;
 
-- 
2.7.4
