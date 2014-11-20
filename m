From: sbradshaw@micron.com (Sam Bradshaw)
Date: Thu, 20 Nov 2014 14:13:24 -0800
Subject: [PATCH] NVMe: Reduce divide operations
Message-ID: <546E6784.6000609@micron.com>

There are several expensive divide operations in the submit and 
completion paths that can be converted to less expensive arithmetic 
and logical operations.  Profiling shows significant drops in time 
spent in nvme_alloc_iod() under common workloads as a result of this 
change.

Patch is against Jens' for-3.19/drivers branch.

Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 9310fe5..a5e2ebc 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -360,8 +360,14 @@ static __le64 **iod_list(struct nvme_iod *iod)
  */
 static int nvme_npages(unsigned size, struct nvme_dev *dev)
 {
-	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev->page_size);
-	return DIV_ROUND_UP(8 * nprps, dev->page_size - 8);
+	unsigned page_size = (1 << dev->page_shift);
+	unsigned nprps = (size >> dev->page_shift) + 1;
+
+	if (size & (page_size - 1))
+		nprps++;
+	if ((nprps << 3) < (page_size - 8))
+		return 1;
+	return DIV_ROUND_UP(nprps << 3, page_size - 8);
 }
 
 static struct nvme_iod *
@@ -384,7 +390,7 @@ nvme_alloc_iod(unsigned nseg, unsigned nbytes, struct nvme_dev *dev, gfp_t gfp)
 
 void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 {
-	const int last_prp = dev->page_size / 8 - 1;
+	const int last_prp = (1 << (dev->page_shift - 3)) - 1;
 	int i;
 	__le64 **list = iod_list(iod);
 	dma_addr_t prp_dma = iod->first_dma;
@@ -459,7 +465,7 @@ int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod, int total_len,
 	__le64 **list = iod_list(iod);
 	dma_addr_t prp_dma;
 	int nprps, i;
-	u32 page_size = dev->page_size;
+	u32 page_size = 1 << dev->page_shift;
 
 	length -= (page_size - offset);
 	if (length <= 0)
@@ -1416,7 +1422,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
 
-	dev->page_size = 1 << page_shift;
+	dev->page_shift = page_shift;
 
 	dev->ctrl_config = NVME_CC_CSS_NVM;
 	dev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 258945f..f504fb8 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -100,9 +100,9 @@ struct nvme_dev {
 	char firmware_rev[8];
 	u32 max_hw_sectors;
 	u32 stripe_size;
-	u32 page_size;
 	u16 oncs;
 	u16 abort_limit;
+	u8 page_shift;
 	u8 event_limit;
 	u8 vwc;
 	u8 initialized;
