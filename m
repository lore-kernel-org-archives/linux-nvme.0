From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 Jun 2016 19:08:24 +0300
Subject: [PATCH] nvme-rdma: Always signal fabrics private commands
Message-ID: <1466698104-32521-1-git-send-email-sagi@grimberg.me>

Some RDMA adapters were observed to have some issues
with selective completion signaling which might cause
a use-after-free condition when the device accidentally
reports a completion when the caller context (wr_cqe)
was already freed.

The first time this was detected was for flush requests
that were not allocated from the tagset, now we see that
in the error path of fabrics connect (admin). The normal
I/O selective signaling is safe because we free the tagset
only when all the queue-pairs were drained.

Reported-by: Steve Wise <swise at opengridcomputing.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b939f89ad936..bf141cb4e671 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1453,7 +1453,8 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ib_dma_sync_single_for_device(dev, sqe->dma,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
-	if (rq->cmd_type == REQ_TYPE_FS && req_op(rq) == REQ_OP_FLUSH)
+	if ((rq->cmd_type == REQ_TYPE_FS && req_op(rq) == REQ_OP_FLUSH) ||
+	    rq->cmd_type == REQ_TYPE_DRV_PRIV)
 		flush = true;
 	ret = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
 			req->need_inval ? &req->reg_wr.wr : NULL, flush);
-- 
1.9.1
