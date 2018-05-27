From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:19 +0300
Subject: [PATCH 14/17] nvme-rdma: refactor cmd mapping/unmapping mechanism
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-15-git-send-email-maxg@mellanox.com>

Split the IO request mapping for RDMA operation to a structured
procedure:
- map the rq data sgl to rdma data_sgl
- map the rdma data_sgl to nvme descriptor

This is a preparation patch for adding T10-PI support.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 114 +++++++++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3b63811..a54de37 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1055,28 +1055,35 @@ static int nvme_rdma_inv_rkey(struct nvme_rdma_queue *queue, u32 rkey,
 	return ib_post_send(queue->qp, &wr, &bad_wr);
 }
 
-static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
-		struct request *rq)
+static void nvme_rdma_unmap_data_sgl(struct nvme_rdma_queue *queue,
+		struct nvme_rdma_sgl *sgl, struct request *rq)
 {
-	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
-	struct nvme_rdma_sgl *sgl = &req->data_sgl;
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
 
+	ib_dma_unmap_sg(ibdev, sgl->sg_table.sgl,
+			sgl->nents, rq_data_dir(rq) ==
+				    WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+	sg_free_table_chained(&sgl->sg_table, true);
+}
+
+static void nvme_rdma_unmap_cmd(struct nvme_rdma_queue *queue,
+		struct request *rq)
+{
+	struct nvme_rdma_request *req;
+
 	if (!blk_rq_payload_bytes(rq))
 		return;
 
-	if (sgl->mr) {
-		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, sgl->mr);
-		sgl->mr = NULL;
+	req = blk_mq_rq_to_pdu(rq);
+	if (req->data_sgl.mr) {
+		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->data_sgl.mr);
+		req->data_sgl.mr = NULL;
 	}
 
-	ib_dma_unmap_sg(ibdev, sgl->sg_table.sgl,
-			sgl->nents, rq_data_dir(rq) ==
-				    WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-
+	nvme_rdma_unmap_data_sgl(queue, &req->data_sgl, rq);
 	nvme_cleanup_cmd(rq);
-	sg_free_table_chained(&sgl->sg_table, true);
 }
 
 static void nvme_rdma_set_keyed_sgl(u64 addr, u64 length, u32 key,
@@ -1171,7 +1178,49 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 	return 0;
 }
 
-static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
+static int nvme_rdma_map_data_sgl(struct nvme_rdma_sgl *sgl,
+		struct request *rq, struct ib_device *ibdev, int *count)
+{
+	int ret;
+
+	sgl->sg_table.sgl = sgl->first_sgl;
+	ret = sg_alloc_table_chained(&sgl->sg_table,
+			blk_rq_nr_phys_segments(rq), sgl->sg_table.sgl);
+	if (unlikely(ret))
+		return -ENOMEM;
+
+	sgl->nents = blk_rq_map_sg(rq->q, rq, sgl->sg_table.sgl);
+
+	*count = ib_dma_map_sg(ibdev, sgl->sg_table.sgl, sgl->nents,
+		    rq_data_dir(rq) == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	if (unlikely(*count <= 0)) {
+		ret = -EIO;
+		goto out_free_table;
+	}
+
+	return 0;
+
+out_free_table:
+	sg_free_table_chained(&sgl->sg_table, true);
+	return ret;
+}
+
+static int nvme_rdma_map_rq(struct nvme_rdma_queue *queue,
+		struct nvme_rdma_request *req, struct request *rq,
+		struct nvme_command *c, int nents)
+{
+	if (nents == 1) {
+		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
+		    blk_rq_payload_bytes(rq) <=	nvme_rdma_inline_data_size(queue))
+			return nvme_rdma_map_sg_inline(queue, req, c);
+		if (queue->device->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY)
+			return nvme_rdma_map_sg_single(queue, req, c);
+	}
+
+	return nvme_rdma_map_sg_fr(queue, req, c, nents);
+}
+
+static int nvme_rdma_setup_cmd(struct nvme_rdma_queue *queue,
 		struct request *rq, struct nvme_command *c)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
@@ -1188,32 +1237,19 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	if (!blk_rq_payload_bytes(rq))
 		return nvme_rdma_set_sg_null(c);
 
-	sgl->sg_table.sgl = sgl->first_sgl;
-	ret = sg_alloc_table_chained(&sgl->sg_table,
-			blk_rq_nr_phys_segments(rq), sgl->sg_table.sgl);
-	if (ret)
-		return -ENOMEM;
-
-	sgl->nents = blk_rq_map_sg(rq->q, rq, sgl->sg_table.sgl);
-
-	count = ib_dma_map_sg(ibdev, sgl->sg_table.sgl, sgl->nents,
-		    rq_data_dir(rq) == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-	if (unlikely(count <= 0)) {
-		sg_free_table_chained(&sgl->sg_table, true);
-		return -EIO;
-	}
+	ret = nvme_rdma_map_data_sgl(sgl, rq, ibdev, &count);
+	if (unlikely(ret))
+		return ret;
 
-	if (count == 1) {
-		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
-		    blk_rq_payload_bytes(rq) <=
-				nvme_rdma_inline_data_size(queue))
-			return nvme_rdma_map_sg_inline(queue, req, c);
+	ret = nvme_rdma_map_rq(queue, req, rq, c, count);
+	if (unlikely(ret))
+		goto out_unmap_data_sgl;
 
-		if (dev->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY)
-			return nvme_rdma_map_sg_single(queue, req, c);
-	}
+	return 0;
 
-	return nvme_rdma_map_sg_fr(queue, req, c, count);
+out_unmap_data_sgl:
+	nvme_rdma_unmap_data_sgl(queue, sgl, rq);
+	return ret;
 }
 
 static void nvme_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -1645,7 +1681,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
-	err = nvme_rdma_map_data(queue, rq, c);
+	err = nvme_rdma_setup_cmd(queue, rq, c);
 	if (unlikely(err < 0)) {
 		dev_err(queue->ctrl->ctrl.device,
 			     "Failed to map data (%d)\n", err);
@@ -1661,7 +1697,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
 			req->data_sgl.mr ? &req->data_sgl.reg_wr.wr : NULL);
 	if (unlikely(err)) {
-		nvme_rdma_unmap_data(queue, rq);
+		nvme_rdma_unmap_cmd(queue, rq);
 		goto err;
 	}
 
@@ -1697,7 +1733,7 @@ static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 
-	nvme_rdma_unmap_data(req->queue, rq);
+	nvme_rdma_unmap_cmd(req->queue, rq);
 	nvme_complete_rq(rq);
 }
 
-- 
1.8.3.1
