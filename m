From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Apr 2017 19:53:26 +0200
Subject: [PATCH] nvme-lightnvm: use blk_execute_rq nvme_nvm_submit_user_cmd
Message-ID: <20170425175326.6587-1-hch@lst.de>

Instead of reinventing it poorly.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/lightnvm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index de61a4a03d78..ddf28a743b5c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -570,13 +570,6 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.max_phys_sect		= 64,
 };
 
-static void nvme_nvm_end_user_vio(struct request *rq, int error)
-{
-	struct completion *waiting = rq->end_io_data;
-
-	complete(waiting);
-}
-
 static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 				struct nvme_ns *ns,
 				struct nvme_nvm_command *vcmd,
@@ -607,7 +600,6 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
 
 	rq->cmd_flags &= ~REQ_FAILFAST_DRIVER;
-	rq->end_io_data = &wait;
 
 	if (ppa_buf && ppa_len) {
 		ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
@@ -661,9 +653,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 	}
 
 submit:
-	blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_user_vio);
-
-	wait_for_completion_io(&wait);
+	blk_execute_rq(q, NULL, rq, 0);
 
 	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
-- 
2.11.0
