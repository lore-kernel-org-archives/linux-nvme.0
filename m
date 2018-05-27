From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:20 +0300
Subject: [PATCH 15/17] nvme-rdma: Add helper function for preparing sg list to
 RDMA operation
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-16-git-send-email-maxg@mellanox.com>

In orter to prepare a scatterlist for an RDMA the following actions should
be accomplished:
- Set a memory region (MR) to a dma mapped SG list.
- Set an appropriate work request (WR) for MR registration.
- Set an appropriate callbacks for MR registration and invalidation completions.

This helper also will be used for preparing protected sg list for T10-PI.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 53 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a54de37..f1d9759 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1134,14 +1134,16 @@ static int nvme_rdma_map_sg_single(struct nvme_rdma_queue *queue,
 	return 0;
 }
 
-static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
-		struct nvme_rdma_request *req, struct nvme_command *c,
-		int count)
+static int nvme_rdma_map_mr_sg(struct nvme_rdma_queue *queue,
+			       struct list_head *mr_pool,
+			       struct nvme_rdma_sgl *sgl, int nents)
 {
-	struct nvme_rdma_sgl *sgl = &req->data_sgl;
+	struct scatterlist *sg = sgl->sg_table.sgl;
+	struct ib_reg_wr *reg_wr = &sgl->reg_wr;
+	struct ib_cqe *reg_cqe = &sgl->reg_cqe;
 	int nr;
 
-	sgl->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
+	sgl->mr = ib_mr_pool_get(queue->qp, mr_pool);
 	if (WARN_ON_ONCE(!sgl->mr))
 		return -EAGAIN;
 
@@ -1149,9 +1151,9 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 	 * Align the MR to a 4K page size to match the ctrl page size and
 	 * the block virtual boundary.
 	 */
-	nr = ib_map_mr_sg(sgl->mr, sgl->sg_table.sgl, count, NULL, SZ_4K);
-	if (unlikely(nr < count)) {
-		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, sgl->mr);
+	nr = ib_map_mr_sg(sgl->mr, sg, nents, NULL, SZ_4K);
+	if (unlikely(nr < nents)) {
+		ib_mr_pool_put(queue->qp, mr_pool, sgl->mr);
 		sgl->mr = NULL;
 		if (nr < 0)
 			return nr;
@@ -1160,17 +1162,32 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 
 	ib_update_fast_reg_key(sgl->mr, ib_inc_rkey(sgl->mr->rkey));
 
-	sgl->reg_cqe.done = nvme_rdma_memreg_done;
+	reg_cqe->done = nvme_rdma_memreg_done;
+	memset(reg_wr, 0, sizeof(*reg_wr));
+	reg_wr->wr.opcode = IB_WR_REG_MR;
+	reg_wr->wr.wr_cqe = reg_cqe;
+	reg_wr->wr.num_sge = 0;
+	reg_wr->mr = sgl->mr;
+	reg_wr->key = sgl->mr->rkey;
+	reg_wr->access = IB_ACCESS_LOCAL_WRITE |
+			 IB_ACCESS_REMOTE_READ |
+			 IB_ACCESS_REMOTE_WRITE;
+
+	return 0;
+}
+
+static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
+		struct nvme_rdma_request *req, struct nvme_command *c,
+		int nents)
+{
+	struct nvme_rdma_sgl *sgl = &req->data_sgl;
+	int ret;
+
+	ret = nvme_rdma_map_mr_sg(queue, &queue->qp->rdma_mrs, sgl, nents);
+	if (unlikely(ret))
+		return -EAGAIN;
+
 	sgl->inv_cqe.done = nvme_rdma_inv_rkey_done;
-	memset(&sgl->reg_wr, 0, sizeof(sgl->reg_wr));
-	sgl->reg_wr.wr.opcode = IB_WR_REG_MR;
-	sgl->reg_wr.wr.wr_cqe = &sgl->reg_cqe;
-	sgl->reg_wr.wr.num_sge = 0;
-	sgl->reg_wr.mr = sgl->mr;
-	sgl->reg_wr.key = sgl->mr->rkey;
-	sgl->reg_wr.access = IB_ACCESS_LOCAL_WRITE |
-			     IB_ACCESS_REMOTE_READ |
-			     IB_ACCESS_REMOTE_WRITE;
 
 	nvme_rdma_set_keyed_sgl(sgl->mr->iova, sgl->mr->length, sgl->mr->rkey,
 				c, true);
-- 
1.8.3.1
