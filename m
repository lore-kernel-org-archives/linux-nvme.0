From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 17:23:43 +0100
Subject: [PATCH 09/13] nvme-rdma: remove I/O polling support
In-Reply-To: <20181121162347.17430-1-hch@lst.de>
References: <20181121162347.17430-1-hch@lst.de>
Message-ID: <20181121162347.17430-10-hch@lst.de>

The code was always a bit of a hack that digs far too much into
RDMA core internals.  Lets kick it out and reimplement proper
dedicated poll queues as needed.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/rdma.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ccfde6c7c0a5..a62e9f177c06 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1736,29 +1736,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_IOERR;
 }
 
-static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
-{
-	struct nvme_rdma_queue *queue = hctx->driver_data;
-	struct ib_cq *cq = queue->ib_cq;
-	struct ib_wc wc;
-	int found = 0;
-
-	while (ib_poll_cq(cq, 1, &wc) > 0) {
-		struct ib_cqe *cqe = wc.wr_cqe;
-
-		if (cqe) {
-			if (cqe->done == nvme_rdma_recv_done) {
-				nvme_rdma_recv_done(cq, &wc);
-				found++;
-			} else {
-				cqe->done(cq, &wc);
-			}
-		}
-	}
-
-	return found;
-}
-
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
@@ -1780,7 +1757,6 @@ static const struct blk_mq_ops nvme_rdma_mq_ops = {
 	.init_request	= nvme_rdma_init_request,
 	.exit_request	= nvme_rdma_exit_request,
 	.init_hctx	= nvme_rdma_init_hctx,
-	.poll		= nvme_rdma_poll,
 	.timeout	= nvme_rdma_timeout,
 	.map_queues	= nvme_rdma_map_queues,
 };
-- 
2.19.1
