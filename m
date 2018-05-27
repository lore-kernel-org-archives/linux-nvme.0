From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:17 +0300
Subject: [PATCH 12/17] nvme-rdma: Introduce nvme_rdma_set_keyed_sgl helper func
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-13-git-send-email-maxg@mellanox.com>

This function will be used to avoid code duplication while
setting keyed sgl fields.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a240800..b96cf88 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1074,14 +1074,23 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 	sg_free_table_chained(&req->sg_table, true);
 }
 
-static int nvme_rdma_set_sg_null(struct nvme_command *c)
+static void nvme_rdma_set_keyed_sgl(u64 addr, u64 length, u32 key,
+		struct nvme_command *c, bool invalidate)
 {
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
 
-	sg->addr = 0;
-	put_unaligned_le24(0, sg->length);
-	put_unaligned_le32(0, sg->key);
+	sg->addr = cpu_to_le64(addr);
+	put_unaligned_le24(length, sg->length);
+	put_unaligned_le32(key, sg->key);
 	sg->type = NVME_KEY_SGL_FMT_DATA_DESC << 4;
+	if (invalidate)
+		sg->type |= NVME_SGL_FMT_INVALIDATE;
+}
+
+static int nvme_rdma_set_sg_null(struct nvme_command *c)
+{
+	nvme_rdma_set_keyed_sgl(0, 0, 0, c, false);
+
 	return 0;
 }
 
@@ -1105,12 +1114,11 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
 static int nvme_rdma_map_sg_single(struct nvme_rdma_queue *queue,
 		struct nvme_rdma_request *req, struct nvme_command *c)
 {
-	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
+	nvme_rdma_set_keyed_sgl(sg_dma_address(req->sg_table.sgl),
+				sg_dma_len(req->sg_table.sgl),
+				queue->device->pd->unsafe_global_rkey,
+				c, false);
 
-	sg->addr = cpu_to_le64(sg_dma_address(req->sg_table.sgl));
-	put_unaligned_le24(sg_dma_len(req->sg_table.sgl), sg->length);
-	put_unaligned_le32(queue->device->pd->unsafe_global_rkey, sg->key);
-	sg->type = NVME_KEY_SGL_FMT_DATA_DESC << 4;
 	return 0;
 }
 
@@ -1118,7 +1126,6 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 		struct nvme_rdma_request *req, struct nvme_command *c,
 		int count)
 {
-	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
 	int nr;
 
 	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
@@ -1152,11 +1159,8 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 			     IB_ACCESS_REMOTE_READ |
 			     IB_ACCESS_REMOTE_WRITE;
 
-	sg->addr = cpu_to_le64(req->mr->iova);
-	put_unaligned_le24(req->mr->length, sg->length);
-	put_unaligned_le32(req->mr->rkey, sg->key);
-	sg->type = (NVME_KEY_SGL_FMT_DATA_DESC << 4) |
-			NVME_SGL_FMT_INVALIDATE;
+	nvme_rdma_set_keyed_sgl(req->mr->iova, req->mr->length, req->mr->rkey,
+				c, true);
 
 	return 0;
 }
-- 
1.8.3.1
