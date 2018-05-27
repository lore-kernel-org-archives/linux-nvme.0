From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:18 +0300
Subject: [PATCH 13/17] nvme-rdma: introduce nvme_rdma_sgl structure
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-14-git-send-email-maxg@mellanox.com>

This structure will bind all the necessary properties for mapping and
sending an sg list received from the block layer (that may also will
need a memory registration). This is a preparation patch for adding
T10-PI support that will use this structure to map the integrity sg list
as well.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 111 +++++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 51 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b96cf88..3b63811 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -55,23 +55,27 @@ struct nvme_rdma_qe {
 	u64			dma;
 };
 
+struct nvme_rdma_sgl {
+	struct ib_mr		*mr;
+	int			nents;
+	struct ib_reg_wr	reg_wr;
+	struct ib_cqe		reg_cqe;
+	struct ib_cqe		inv_cqe;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+};
+
 struct nvme_rdma_queue;
 struct nvme_rdma_request {
 	struct nvme_request	req;
-	struct ib_mr		*mr;
 	struct nvme_rdma_qe	sqe;
 	union nvme_result	result;
 	__le16			status;
 	refcount_t		ref;
 	struct ib_sge		sge[1 + NVME_RDMA_MAX_INLINE_SEGMENTS];
 	u32			num_sge;
-	int			nents;
-	struct ib_reg_wr	reg_wr;
-	struct ib_cqe		reg_cqe;
-	struct ib_cqe		inv_cqe;
 	struct nvme_rdma_queue  *queue;
-	struct sg_table		sg_table;
-	struct scatterlist	first_sgl[];
+	struct nvme_rdma_sgl	data_sgl;
 };
 
 enum nvme_rdma_queue_flags {
@@ -689,8 +693,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 		set->reserved_tags = 2; /* connect + keep-alive */
 		set->numa_node = NUMA_NO_NODE;
-		set->cmd_size = sizeof(struct nvme_rdma_request) +
-			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		set->cmd_size = sizeof(struct nvme_rdma_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
 		set->timeout = ADMIN_TIMEOUT;
@@ -703,8 +706,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->reserved_tags = 1; /* fabric connect */
 		set->numa_node = NUMA_NO_NODE;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
-		set->cmd_size = sizeof(struct nvme_rdma_request) +
-			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		set->cmd_size = sizeof(struct nvme_rdma_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
@@ -1020,8 +1022,10 @@ static void nvme_rdma_memreg_done(struct ib_cq *cq, struct ib_wc *wc)
 
 static void nvme_rdma_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 {
+	struct nvme_rdma_sgl *sgl =
+		container_of(wc->wr_cqe, struct nvme_rdma_sgl, inv_cqe);
 	struct nvme_rdma_request *req =
-		container_of(wc->wr_cqe, struct nvme_rdma_request, inv_cqe);
+		container_of(sgl, struct nvme_rdma_request, data_sgl);
 	struct request *rq = blk_mq_rq_from_pdu(req);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
@@ -1055,23 +1059,24 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 		struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_sgl *sgl = &req->data_sgl;
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
 
 	if (!blk_rq_payload_bytes(rq))
 		return;
 
-	if (req->mr) {
-		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
-		req->mr = NULL;
+	if (sgl->mr) {
+		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, sgl->mr);
+		sgl->mr = NULL;
 	}
 
-	ib_dma_unmap_sg(ibdev, req->sg_table.sgl,
-			req->nents, rq_data_dir(rq) ==
+	ib_dma_unmap_sg(ibdev, sgl->sg_table.sgl,
+			sgl->nents, rq_data_dir(rq) ==
 				    WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
 	nvme_cleanup_cmd(rq);
-	sg_free_table_chained(&req->sg_table, true);
+	sg_free_table_chained(&sgl->sg_table, true);
 }
 
 static void nvme_rdma_set_keyed_sgl(u64 addr, u64 length, u32 key,
@@ -1099,12 +1104,12 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
 {
 	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
 
-	req->sge[1].addr = sg_dma_address(req->sg_table.sgl);
-	req->sge[1].length = sg_dma_len(req->sg_table.sgl);
+	req->sge[1].addr = sg_dma_address(req->data_sgl.sg_table.sgl);
+	req->sge[1].length = sg_dma_len(req->data_sgl.sg_table.sgl);
 	req->sge[1].lkey = queue->device->pd->local_dma_lkey;
 
 	sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
-	sg->length = cpu_to_le32(sg_dma_len(req->sg_table.sgl));
+	sg->length = cpu_to_le32(sg_dma_len(req->data_sgl.sg_table.sgl));
 	sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
 
 	req->num_sge++;
@@ -1114,8 +1119,8 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
 static int nvme_rdma_map_sg_single(struct nvme_rdma_queue *queue,
 		struct nvme_rdma_request *req, struct nvme_command *c)
 {
-	nvme_rdma_set_keyed_sgl(sg_dma_address(req->sg_table.sgl),
-				sg_dma_len(req->sg_table.sgl),
+	nvme_rdma_set_keyed_sgl(sg_dma_address(req->data_sgl.sg_table.sgl),
+				sg_dma_len(req->data_sgl.sg_table.sgl),
 				queue->device->pd->unsafe_global_rkey,
 				c, false);
 
@@ -1126,40 +1131,41 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 		struct nvme_rdma_request *req, struct nvme_command *c,
 		int count)
 {
+	struct nvme_rdma_sgl *sgl = &req->data_sgl;
 	int nr;
 
-	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
-	if (WARN_ON_ONCE(!req->mr))
+	sgl->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
+	if (WARN_ON_ONCE(!sgl->mr))
 		return -EAGAIN;
 
 	/*
 	 * Align the MR to a 4K page size to match the ctrl page size and
 	 * the block virtual boundary.
 	 */
-	nr = ib_map_mr_sg(req->mr, req->sg_table.sgl, count, NULL, SZ_4K);
+	nr = ib_map_mr_sg(sgl->mr, sgl->sg_table.sgl, count, NULL, SZ_4K);
 	if (unlikely(nr < count)) {
-		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
-		req->mr = NULL;
+		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, sgl->mr);
+		sgl->mr = NULL;
 		if (nr < 0)
 			return nr;
 		return -EINVAL;
 	}
 
-	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
+	ib_update_fast_reg_key(sgl->mr, ib_inc_rkey(sgl->mr->rkey));
 
-	req->reg_cqe.done = nvme_rdma_memreg_done;
-	req->inv_cqe.done = nvme_rdma_inv_rkey_done;
-	memset(&req->reg_wr, 0, sizeof(req->reg_wr));
-	req->reg_wr.wr.opcode = IB_WR_REG_MR;
-	req->reg_wr.wr.wr_cqe = &req->reg_cqe;
-	req->reg_wr.wr.num_sge = 0;
-	req->reg_wr.mr = req->mr;
-	req->reg_wr.key = req->mr->rkey;
-	req->reg_wr.access = IB_ACCESS_LOCAL_WRITE |
+	sgl->reg_cqe.done = nvme_rdma_memreg_done;
+	sgl->inv_cqe.done = nvme_rdma_inv_rkey_done;
+	memset(&sgl->reg_wr, 0, sizeof(sgl->reg_wr));
+	sgl->reg_wr.wr.opcode = IB_WR_REG_MR;
+	sgl->reg_wr.wr.wr_cqe = &sgl->reg_cqe;
+	sgl->reg_wr.wr.num_sge = 0;
+	sgl->reg_wr.mr = sgl->mr;
+	sgl->reg_wr.key = sgl->mr->rkey;
+	sgl->reg_wr.access = IB_ACCESS_LOCAL_WRITE |
 			     IB_ACCESS_REMOTE_READ |
 			     IB_ACCESS_REMOTE_WRITE;
 
-	nvme_rdma_set_keyed_sgl(req->mr->iova, req->mr->length, req->mr->rkey,
+	nvme_rdma_set_keyed_sgl(sgl->mr->iova, sgl->mr->length, sgl->mr->rkey,
 				c, true);
 
 	return 0;
@@ -1169,6 +1175,7 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 		struct request *rq, struct nvme_command *c)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_sgl *sgl = &req->data_sgl;
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
 	int count, ret;
@@ -1181,18 +1188,18 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	if (!blk_rq_payload_bytes(rq))
 		return nvme_rdma_set_sg_null(c);
 
-	req->sg_table.sgl = req->first_sgl;
-	ret = sg_alloc_table_chained(&req->sg_table,
-			blk_rq_nr_phys_segments(rq), req->sg_table.sgl);
+	sgl->sg_table.sgl = sgl->first_sgl;
+	ret = sg_alloc_table_chained(&sgl->sg_table,
+			blk_rq_nr_phys_segments(rq), sgl->sg_table.sgl);
 	if (ret)
 		return -ENOMEM;
 
-	req->nents = blk_rq_map_sg(rq->q, rq, req->sg_table.sgl);
+	sgl->nents = blk_rq_map_sg(rq->q, rq, sgl->sg_table.sgl);
 
-	count = ib_dma_map_sg(ibdev, req->sg_table.sgl, req->nents,
+	count = ib_dma_map_sg(ibdev, sgl->sg_table.sgl, sgl->nents,
 		    rq_data_dir(rq) == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	if (unlikely(count <= 0)) {
-		sg_free_table_chained(&req->sg_table, true);
+		sg_free_table_chained(&sgl->sg_table, true);
 		return -EIO;
 	}
 
@@ -1330,6 +1337,7 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 {
 	struct request *rq;
 	struct nvme_rdma_request *req;
+	struct nvme_rdma_sgl *sgl;
 	int ret = 0;
 
 	rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
@@ -1344,20 +1352,21 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 
 	req->status = cqe->status;
 	req->result = cqe->result;
+	sgl = &req->data_sgl;
 
 	if (wc->wc_flags & IB_WC_WITH_INVALIDATE) {
-		if (unlikely(wc->ex.invalidate_rkey != req->mr->rkey)) {
+		if (unlikely(wc->ex.invalidate_rkey != sgl->mr->rkey)) {
 			dev_err(queue->ctrl->ctrl.device,
 				"Bogus remote invalidation for rkey %#x\n",
-				req->mr->rkey);
+				sgl->mr->rkey);
 			nvme_rdma_error_recovery(queue->ctrl);
 		}
-	} else if (req->mr) {
-		ret = nvme_rdma_inv_rkey(queue, req->mr->rkey, &req->inv_cqe);
+	} else if (sgl->mr) {
+		ret = nvme_rdma_inv_rkey(queue, sgl->mr->rkey, &sgl->inv_cqe);
 		if (unlikely(ret < 0)) {
 			dev_err(queue->ctrl->ctrl.device,
 				"Queueing INV WR for rkey %#x failed (%d)\n",
-				req->mr->rkey, ret);
+				sgl->mr->rkey, ret);
 			nvme_rdma_error_recovery(queue->ctrl);
 		}
 		/* the local invalidation completion will end the request */
@@ -1650,7 +1659,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
-			req->mr ? &req->reg_wr.wr : NULL);
+			req->data_sgl.mr ? &req->data_sgl.reg_wr.wr : NULL);
 	if (unlikely(err)) {
 		nvme_rdma_unmap_data(queue, rq);
 		goto err;
-- 
1.8.3.1
