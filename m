From: hch@lst.de (Christoph Hellwig)
Date: Wed,  8 Jun 2016 14:30:58 +0200
Subject: [PATCH 03/11] nvme_rdma: update for req_op changes
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
Message-ID: <1465389066-19119-4-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4edc912..e938ab6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1453,7 +1453,7 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ib_dma_sync_single_for_device(dev, sqe->dma,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
-	if (rq->cmd_type == REQ_TYPE_FS && (rq->cmd_flags & REQ_FLUSH))
+	if (rq->cmd_type == REQ_TYPE_FS && req_op(rq) == REQ_OP_FLUSH)
 		flush = true;
 	ret = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
 			req->need_inval ? &req->reg_wr.wr : NULL, flush);
-- 
2.1.4
