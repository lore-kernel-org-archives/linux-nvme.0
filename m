From: keith.busch@intel.com (Keith Busch)
Date: Wed, 12 Jul 2017 15:59:07 -0400
Subject: [PATCH] nvme/pci: Remove nvme_setup_prps BUG_ON
Message-ID: <1499889547-11018-1-git-send-email-keith.busch@intel.com>

This patch replaces the invalid nvme SGL kernel panic with a warning,
and returns an appropriate error. The warning will occur only on the
first occurance, and sgl details will be printed to help debug how the
request was allowed to form.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c4343c4..d321597 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -533,7 +533,7 @@ static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
 }
 #endif
 
-static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
+static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct dma_pool *pool;
@@ -550,7 +550,7 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 
 	length -= (page_size - offset);
 	if (length <= 0)
-		return true;
+		return BLK_STS_OK;
 
 	dma_len -= (page_size - offset);
 	if (dma_len) {
@@ -563,7 +563,7 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 
 	if (length <= page_size) {
 		iod->first_dma = dma_addr;
-		return true;
+		return BLK_STS_OK;
 	}
 
 	nprps = DIV_ROUND_UP(length, page_size);
@@ -579,7 +579,7 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 	if (!prp_list) {
 		iod->first_dma = dma_addr;
 		iod->npages = -1;
-		return false;
+		return BLK_STS_RESOURCE;
 	}
 	list[0] = prp_list;
 	iod->first_dma = prp_dma;
@@ -589,7 +589,7 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 			__le64 *old_prp_list = prp_list;
 			prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
-				return false;
+				return BLK_STS_RESOURCE;
 			list[iod->npages++] = prp_list;
 			prp_list[0] = old_prp_list[i - 1];
 			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
@@ -603,13 +603,29 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 			break;
 		if (dma_len > 0)
 			continue;
-		BUG_ON(dma_len < 0);
+		if (unlikely(dma_len < 0))
+			goto bad_sgl;
 		sg = sg_next(sg);
 		dma_addr = sg_dma_address(sg);
 		dma_len = sg_dma_len(sg);
 	}
 
-	return true;
+	return BLK_STS_OK;
+
+ bad_sgl:
+	if (WARN_ONCE(1, "Invalid SGL for payload:%d nents:%d\n",
+				blk_rq_payload_bytes(req), iod->nents)) {
+		for_each_sg(iod->sg, sg, iod->nents, i) {
+			dma_addr_t phys = sg_phys(sg);
+			pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
+			       "dma_address:%pad dma_length:%d\n", i, &phys,
+					sg->offset, sg->length,
+					&sg_dma_address(sg),
+					sg_dma_len(sg));
+		}
+	}
+	return BLK_STS_IOERR;
+
 }
 
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
@@ -631,7 +647,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				DMA_ATTR_NO_WARN))
 		goto out;
 
-	if (!nvme_setup_prps(dev, req))
+	ret = nvme_setup_prps(dev, req);
+	if (ret != BLK_STS_OK)
 		goto out_unmap;
 
 	ret = BLK_STS_IOERR;
-- 
2.5.5
