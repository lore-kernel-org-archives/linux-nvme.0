From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  9 Mar 2017 15:16:40 +0200
Subject: [PATCH rfc 08/10] nvme-rdma: Support blk_poll_batch
In-Reply-To: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
Message-ID: <1489065402-14757-9-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a17eef3ef6ff..29ac8fcb8d2c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1488,6 +1488,13 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	return found;
 }
 
+static int nvme_rdma_poll_batch(struct blk_mq_hw_ctx *hctx, unsigned int batch)
+{
+	struct nvme_rdma_queue *queue = hctx->driver_data;
+
+	return ib_process_cq_direct(queue->ib_cq, batch);
+}
+
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
@@ -1519,6 +1526,7 @@ static struct blk_mq_ops nvme_rdma_mq_ops = {
 	.reinit_request	= nvme_rdma_reinit_request,
 	.init_hctx	= nvme_rdma_init_hctx,
 	.poll		= nvme_rdma_poll,
+	.poll_batch	= nvme_rdma_poll_batch,
 	.timeout	= nvme_rdma_timeout,
 };
 
-- 
2.7.4
