From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed,  6 Dec 2017 18:21:20 +0200
Subject: [PATCH 1/1] nvme-rdma: remove redundant boolean for inline_data
Message-ID: <1512577280-32595-1-git-send-email-maxg@mellanox.com>

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 37af565..225f7f1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -66,7 +66,6 @@ struct nvme_rdma_request {
 	struct ib_sge		sge[1 + NVME_RDMA_MAX_INLINE_SEGMENTS];
 	u32			num_sge;
 	int			nents;
-	bool			inline_data;
 	struct ib_reg_wr	reg_wr;
 	struct ib_cqe		reg_cqe;
 	struct nvme_rdma_queue  *queue;
@@ -1086,7 +1085,6 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
 	sg->length = cpu_to_le32(sg_dma_len(req->sg_table.sgl));
 	sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
 
-	req->inline_data = true;
 	req->num_sge++;
 	return 0;
 }
@@ -1158,7 +1156,6 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	int count, ret;
 
 	req->num_sge = 1;
-	req->inline_data = false;
 	refcount_set(&req->ref, 2); /* send and recv completions */
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
-- 
1.8.3.1
