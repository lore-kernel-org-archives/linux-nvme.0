From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  5 Jul 2017 10:13:38 +0300
Subject: [PATCH] nvme-rdma: unconditionally recycle the request mr
Message-ID: <1499238818-17963-1-git-send-email-sagi@grimberg.me>

When our RDMA queue-pair is torn down with high load
of I/O traffic, we have no way of knowing if the
memory region was actually registered by the reg_mr
work request as it completion flushes with error (hw
might have done it or not).

So in order to not deal with all this uncertanty, we
simply recycle the MR in reinit_request.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 96f361674b2a..98aecab58782 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -276,9 +276,6 @@ static int nvme_rdma_reinit_request(void *data, struct request *rq)
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	int ret = 0;
 
-	if (!req->mr->need_inval)
-		goto out;
-
 	ib_dereg_mr(req->mr);
 
 	req->mr = ib_alloc_mr(dev->pd, IB_MR_TYPE_MEM_REG,
-- 
2.7.4
