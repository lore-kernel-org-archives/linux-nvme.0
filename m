From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 9 May 2018 07:31:00 -0700
Subject: [PATCH RFC 1/2] nvme-rdma: Support 8K inline
In-Reply-To: <cover.1525880285.git.swise@opengridcomputing.com>
References: <cover.1525880285.git.swise@opengridcomputing.com>
Message-ID: <1609e345042f2801f92e8831e8c83b688fad07eb.1525880285.git.swise@opengridcomputing.com>

Allow up to 2 pages of inline for NVMF WRITE operations.  This reduces
latency for 8K WRITEs by removing the need to issue a READ WR for IB,
or a REG_MR+READ WR chain for iWarp.

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1eb4438..9b8af98 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -40,7 +40,7 @@
 
 #define NVME_RDMA_MAX_SEGMENTS		256
 
-#define NVME_RDMA_MAX_INLINE_SEGMENTS	1
+#define NVME_RDMA_MAX_INLINE_SEGMENTS	2
 
 struct nvme_rdma_device {
 	struct ib_device	*dev;
@@ -1086,19 +1086,28 @@ static int nvme_rdma_set_sg_null(struct nvme_command *c)
 }
 
 static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
-		struct nvme_rdma_request *req, struct nvme_command *c)
+		struct nvme_rdma_request *req, int count,
+		struct nvme_command *c)
 {
 	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
+	u32 len;
 
 	req->sge[1].addr = sg_dma_address(req->sg_table.sgl);
 	req->sge[1].length = sg_dma_len(req->sg_table.sgl);
 	req->sge[1].lkey = queue->device->pd->local_dma_lkey;
+	len = req->sge[1].length;
+	if (count == 2) {
+		req->sge[2].addr = sg_dma_address(req->sg_table.sgl+1);
+		req->sge[2].length = sg_dma_len(req->sg_table.sgl+1);
+		req->sge[2].lkey = queue->device->pd->local_dma_lkey;
+		len += req->sge[2].length;
+	}
 
 	sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
-	sg->length = cpu_to_le32(sg_dma_len(req->sg_table.sgl));
+	sg->length = cpu_to_le32(len);
 	sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
 
-	req->num_sge++;
+	req->num_sge += count;
 	return 0;
 }
 
@@ -1191,13 +1200,13 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 		return -EIO;
 	}
 
-	if (count == 1) {
+	if (count <= 2) {
 		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
 		    blk_rq_payload_bytes(rq) <=
 				nvme_rdma_inline_data_size(queue))
 			return nvme_rdma_map_sg_inline(queue, req, c);
 
-		if (dev->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY)
+		if (count == 1 && dev->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY)
 			return nvme_rdma_map_sg_single(queue, req, c);
 	}
 
-- 
1.8.3.1
