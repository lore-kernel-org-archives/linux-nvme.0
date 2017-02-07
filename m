From: parav@mellanox.com (Parav Pandit)
Date: Tue,  7 Feb 2017 16:39:30 -0600
Subject: [PATCH] nvme-rdma: Support 2 inline data SGEs for write commands.
Message-ID: <1486507170-23285-1-git-send-email-parav@mellanox.com>

This patch allows to send data for write commands via maximum of 2 SGEs
for block write commands using RDMA's inherent sges support.

Number of send SGEs have almost no relation to the amount of inline data
size being advertised by the NVMe target. Though its likely that when
NVMe target advertises more than 4K or page size worth of inline data
size, multiple send sges can become more useful.

In future more advance implementation may be made available to refer to
exposed inline data size to decide upon number of SGEs for IOQ.
Until than just make use of RDMA adapters capability.
Most adapters known to support 3 send sges (cmd + data) or more.
So this shouldn't break any current deployments.
It is also tested with ConnectX-4 RoCEv2 100Gb adapters, ext4 and xfs
filesystem and raw block IOs.

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/host/rdma.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 557f29b..fc66c9c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -40,7 +40,7 @@
 
 #define NVME_RDMA_MAX_SEGMENTS		256
 
-#define NVME_RDMA_MAX_INLINE_SEGMENTS	1
+#define NVME_RDMA_MAX_INLINE_SEGMENTS	2
 
 static const char *const nvme_rdma_cm_status_strs[] = {
 	[NVME_RDMA_CM_INVALID_LEN]	= "invalid length",
@@ -913,16 +913,23 @@ static int nvme_rdma_set_sg_null(struct nvme_command *c)
 }
 
 static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
-		struct nvme_rdma_request *req, struct nvme_command *c)
+		struct nvme_rdma_request *req, struct nvme_command *c,
+		int count)
 {
 	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
-
-	req->sge[1].addr = sg_dma_address(req->sg_table.sgl);
-	req->sge[1].length = sg_dma_len(req->sg_table.sgl);
-	req->sge[1].lkey = queue->device->pd->local_dma_lkey;
+	int i;
+	u32 len = 0;
+
+	for (i = 0; i < count; i++) {
+		req->sge[i + 1].addr = sg_dma_address(&req->sg_table.sgl[i]);
+		req->sge[i + 1].length = sg_dma_len(&req->sg_table.sgl[i]);
+		req->sge[i + 1].lkey = queue->device->pd->local_dma_lkey;
+		len += sg_dma_len(&req->sg_table.sgl[i]);
+		req->num_sge++;
+	}
 
 	sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
-	sg->length = cpu_to_le32(sg_dma_len(req->sg_table.sgl));
+	sg->length = cpu_to_le32(len);
 	sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
 
 	req->inline_data = true;
@@ -1012,13 +1019,13 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 		return -EIO;
 	}
 
-	if (count == 1) {
+	if (count <= NVME_RDMA_MAX_INLINE_SEGMENTS) {
 		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
 		    blk_rq_payload_bytes(rq) <=
 				nvme_rdma_inline_data_size(queue))
-			return nvme_rdma_map_sg_inline(queue, req, c);
+			return nvme_rdma_map_sg_inline(queue, req, c, count);
 
-		if (dev->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY)
+		if (count == 1 && dev->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY)
 			return nvme_rdma_map_sg_single(queue, req, c);
 	}
 
-- 
1.8.3.1
