From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 14 Aug 2017 15:29:26 +0300
Subject: [PATCH 1/1] nvme-rdma: Use unlikely macro in the fast path
Message-ID: <1502713766-10055-1-git-send-email-maxg@mellanox.com>

This patch slightly improves performance (mainly for small block sizes).

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index da04df1..8540dbb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -856,7 +856,7 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 
 	if (req->mr->need_inval) {
 		res = nvme_rdma_inv_rkey(queue, req);
-		if (res < 0) {
+		if (unlikely(res < 0)) {
 			dev_err(ctrl->ctrl.device,
 				"Queueing INV WR for rkey %#x failed (%d)\n",
 				req->mr->rkey, res);
@@ -921,7 +921,7 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 	int nr;
 
 	nr = ib_map_mr_sg(req->mr, req->sg_table.sgl, count, NULL, PAGE_SIZE);
-	if (nr < count) {
+	if (unlikely(nr < count)) {
 		if (nr < 0)
 			return nr;
 		return -EINVAL;
@@ -1057,7 +1057,7 @@ static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
 		first = &wr;
 
 	ret = ib_post_send(queue->qp, first, &bad_wr);
-	if (ret) {
+	if (unlikely(ret)) {
 		dev_err(queue->ctrl->ctrl.device,
 			     "%s failed with error code %d\n", __func__, ret);
 	}
@@ -1083,7 +1083,7 @@ static int nvme_rdma_post_recv(struct nvme_rdma_queue *queue,
 	wr.num_sge  = 1;
 
 	ret = ib_post_recv(queue->qp, &wr, &bad_wr);
-	if (ret) {
+	if (unlikely(ret)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"%s failed with error code %d\n", __func__, ret);
 	}
@@ -1443,7 +1443,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_mq_start_request(rq);
 
 	err = nvme_rdma_map_data(queue, rq, c);
-	if (err < 0) {
+	if (unlikely(err < 0)) {
 		dev_err(queue->ctrl->ctrl.device,
 			     "Failed to map data (%d)\n", err);
 		nvme_cleanup_cmd(rq);
@@ -1457,7 +1457,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		flush = true;
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
 			req->mr->need_inval ? &req->reg_wr.wr : NULL, flush);
-	if (err) {
+	if (unlikely(err)) {
 		nvme_rdma_unmap_data(queue, rq);
 		goto err;
 	}
-- 
1.7.1
