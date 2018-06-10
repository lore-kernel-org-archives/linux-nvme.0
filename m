From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 10 Jun 2018 16:58:29 +0300
Subject: [PATCH 1/1] nvme-rdma: fix error flow during mapping request data
Message-ID: <1528639109-1978-1-git-send-email-maxg@mellanox.com>

After dma mapping the sgl, we map the sgl to nvme sgl descriptor. In case
of failure during the last mapping we never dma unmap the sgl.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2aba038..7cd4199 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1189,21 +1189,38 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	count = ib_dma_map_sg(ibdev, req->sg_table.sgl, req->nents,
 		    rq_data_dir(rq) == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	if (unlikely(count <= 0)) {
-		sg_free_table_chained(&req->sg_table, true);
-		return -EIO;
+		ret = -EIO;
+		goto out_free_table;
 	}
 
 	if (count == 1) {
 		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
 		    blk_rq_payload_bytes(rq) <=
-				nvme_rdma_inline_data_size(queue))
-			return nvme_rdma_map_sg_inline(queue, req, c);
+				nvme_rdma_inline_data_size(queue)) {
+			ret = nvme_rdma_map_sg_inline(queue, req, c);
+			goto out;
+		}
 
-		if (dev->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY)
-			return nvme_rdma_map_sg_single(queue, req, c);
+		if (dev->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY) {
+			ret = nvme_rdma_map_sg_single(queue, req, c);
+			goto out;
+		}
 	}
 
-	return nvme_rdma_map_sg_fr(queue, req, c, count);
+	ret = nvme_rdma_map_sg_fr(queue, req, c, count);
+out:
+	if (unlikely(ret))
+		goto out_unmap_sg;
+
+	return 0;
+
+out_unmap_sg:
+	ib_dma_unmap_sg(ibdev, req->sg_table.sgl,
+			req->nents, rq_data_dir(rq) ==
+			WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+out_free_table:
+	sg_free_table_chained(&req->sg_table, true);
+	return ret;
 }
 
 static void nvme_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
-- 
1.8.3.1
