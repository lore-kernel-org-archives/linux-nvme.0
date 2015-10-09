From: hch@lst.de (Christoph Hellwig)
Date: Fri,  9 Oct 2015 18:55:55 +0200
Subject: [PATCH 2/3] nvme: simplify nvme_setup_prps calling convention
In-Reply-To: <1444409756-7317-1-git-send-email-hch@lst.de>
References: <1444409756-7317-1-git-send-email-hch@lst.de>
Message-ID: <1444409756-7317-3-git-send-email-hch@lst.de>

Pass back a true/false value instead of the length which needs a compare
with the bytes in the request and drop the pointless gfp_t argument.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0a85fab..5692f18 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -655,9 +655,8 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	blk_mq_complete_request(req, status);
 }
 
-/* length is in bytes.  gfp flags indicates whether we may sleep. */
-static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
-		int total_len, gfp_t gfp)
+static bool nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
+		int total_len)
 {
 	struct dma_pool *pool;
 	int length = total_len;
@@ -673,7 +672,7 @@ static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 
 	length -= (page_size - offset);
 	if (length <= 0)
-		return total_len;
+		return true;
 
 	dma_len -= (page_size - offset);
 	if (dma_len) {
@@ -686,7 +685,7 @@ static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 
 	if (length <= page_size) {
 		iod->first_dma = dma_addr;
-		return total_len;
+		return true;
 	}
 
 	nprps = DIV_ROUND_UP(length, page_size);
@@ -698,11 +697,11 @@ static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 		iod->npages = 1;
 	}
 
-	prp_list = dma_pool_alloc(pool, gfp, &prp_dma);
+	prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 	if (!prp_list) {
 		iod->first_dma = dma_addr;
 		iod->npages = -1;
-		return (total_len - length) + page_size;
+		return false;
 	}
 	list[0] = prp_list;
 	iod->first_dma = prp_dma;
@@ -710,9 +709,9 @@ static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 	for (;;) {
 		if (i == page_size >> 3) {
 			__le64 *old_prp_list = prp_list;
-			prp_list = dma_pool_alloc(pool, gfp, &prp_dma);
+			prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
-				return total_len - length;
+				return false;
 			list[iod->npages++] = prp_list;
 			prp_list[0] = old_prp_list[i - 1];
 			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
@@ -732,7 +731,7 @@ static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 		dma_len = sg_dma_len(sg);
 	}
 
-	return total_len;
+	return true;
 }
 
 static void nvme_submit_priv(struct nvme_queue *nvmeq, struct request *req,
@@ -898,8 +897,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (!dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir))
 			goto retry_cmd;
 
-		if (blk_rq_bytes(req) !=
-                    nvme_setup_prps(dev, iod, blk_rq_bytes(req), GFP_ATOMIC)) {
+		if (!nvme_setup_prps(dev, iod, blk_rq_bytes(req))) {
 			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
 			goto retry_cmd;
 		}
-- 
1.9.1
