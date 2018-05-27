From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:21 +0300
Subject: [PATCH 16/17] nvme-rdma: Introduce nvme_rdma_first_wr helper function
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-17-git-send-email-maxg@mellanox.com>

This patch doesn't change any logic and is needed only for improving
code readability.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f1d9759..88f2f00 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1668,6 +1668,15 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	return BLK_EH_HANDLED;
 }
 
+static inline struct ib_send_wr *
+nvme_rdma_first_wr(struct nvme_rdma_request *req)
+{
+	if (req->data_sgl.mr)
+		return &req->data_sgl.reg_wr.wr;
+
+	return NULL;
+}
+
 static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -1712,7 +1721,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
-			req->data_sgl.mr ? &req->data_sgl.reg_wr.wr : NULL);
+				  nvme_rdma_first_wr(req));
 	if (unlikely(err)) {
 		nvme_rdma_unmap_cmd(queue, rq);
 		goto err;
-- 
1.8.3.1
