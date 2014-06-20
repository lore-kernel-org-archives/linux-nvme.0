From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Jun 2014 15:27:43 -0600
Subject: [PATCH] NVMe: Mismatched host/device page size support
Message-ID: <1403299663-31721-1-git-send-email-keith.busch@intel.com>

Adds support for devices with max page size smaller than the host's.
In the case we encounter such a host/device combination, the driver will
split a page into as many PRP entries as necessary for the device's page
size capabilities.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Tested on a SPARC with 8k pages and an NVMe device with 4k max page
size supported.

 drivers/block/nvme-core.c |   50 ++++++++++++++++++++++++++++-----------------
 include/linux/nvme.h      |    2 ++
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 02351e2..b4a0509 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -361,17 +361,17 @@ static __le64 **iod_list(struct nvme_iod *iod)
  * as it only leads to a small amount of wasted memory for the lifetime of
  * the I/O.
  */
-static int nvme_npages(unsigned size)
+static int nvme_npages(unsigned size, struct nvme_dev *dev)
 {
-	unsigned nprps = DIV_ROUND_UP(size + PAGE_SIZE, PAGE_SIZE);
-	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
+	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev->page_size);
+	return DIV_ROUND_UP(8 * nprps, dev->page_size - 8);
 }
 
 static struct nvme_iod *
-nvme_alloc_iod(unsigned nseg, unsigned nbytes, gfp_t gfp)
+nvme_alloc_iod(unsigned nseg, unsigned nbytes, gfp_t gfp, struct nvme_dev *dev)
 {
 	struct nvme_iod *iod = kmalloc(sizeof(struct nvme_iod) +
-				sizeof(__le64 *) * nvme_npages(nbytes) +
+				sizeof(__le64 *) * nvme_npages(nbytes, dev) +
 				sizeof(struct scatterlist) * nseg, gfp);
 
 	if (iod) {
@@ -388,7 +388,7 @@ nvme_alloc_iod(unsigned nseg, unsigned nbytes, gfp_t gfp)
 
 void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 {
-	const int last_prp = PAGE_SIZE / 8 - 1;
+	const int last_prp = dev->page_size / 8 - 1;
 	int i;
 	__le64 **list = iod_list(iod);
 	dma_addr_t prp_dma = iod->first_dma;
@@ -479,26 +479,27 @@ int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod, int total_len,
 	__le64 **list = iod_list(iod);
 	dma_addr_t prp_dma;
 	int nprps, i;
+	u32 page_size = dev->page_size;
 
-	length -= (PAGE_SIZE - offset);
+	length -= (page_size - offset);
 	if (length <= 0)
 		return total_len;
 
-	dma_len -= (PAGE_SIZE - offset);
+	dma_len -= (page_size - offset);
 	if (dma_len) {
-		dma_addr += (PAGE_SIZE - offset);
+		dma_addr += (page_size - offset);
 	} else {
 		sg = sg_next(sg);
 		dma_addr = sg_dma_address(sg);
 		dma_len = sg_dma_len(sg);
 	}
 
-	if (length <= PAGE_SIZE) {
+	if (length <= page_size) {
 		iod->first_dma = dma_addr;
 		return total_len;
 	}
 
-	nprps = DIV_ROUND_UP(length, PAGE_SIZE);
+	nprps = DIV_ROUND_UP(length, page_size);
 	if (nprps <= (256 / 8)) {
 		pool = dev->prp_small_pool;
 		iod->npages = 0;
@@ -511,13 +512,13 @@ int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod, int total_len,
 	if (!prp_list) {
 		iod->first_dma = dma_addr;
 		iod->npages = -1;
-		return (total_len - length) + PAGE_SIZE;
+		return (total_len - length) + page_size;
 	}
 	list[0] = prp_list;
 	iod->first_dma = prp_dma;
 	i = 0;
 	for (;;) {
-		if (i == PAGE_SIZE / 8) {
+		if (i == page_size >> 3) {
 			__le64 *old_prp_list = prp_list;
 			prp_list = dma_pool_alloc(pool, gfp, &prp_dma);
 			if (!prp_list)
@@ -528,9 +529,9 @@ int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod, int total_len,
 			i = 1;
 		}
 		prp_list[i++] = cpu_to_le64(dma_addr);
-		dma_len -= PAGE_SIZE;
-		dma_addr += PAGE_SIZE;
-		length -= PAGE_SIZE;
+		dma_len -= page_size;
+		dma_addr += page_size;
+		length -= page_size;
 		if (length <= 0)
 			break;
 		if (dma_len > 0)
@@ -737,7 +738,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	if ((bio->bi_rw & REQ_FLUSH) && psegs)
 		return nvme_split_flush_data(nvmeq, bio);
 
-	iod = nvme_alloc_iod(psegs, bio->bi_iter.bi_size, GFP_ATOMIC);
+	iod = nvme_alloc_iod(psegs, bio->bi_iter.bi_size, GFP_ATOMIC, ns->dev);
 	if (!iod)
 		return -ENOMEM;
 
@@ -1450,6 +1451,15 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	u32 aqa;
 	u64 cap = readq(&dev->bar->cap);
 	struct nvme_queue *nvmeq;
+	unsigned page_shift = PAGE_SHIFT;
+	unsigned dev_page_shift = NVME_CAP_MPSMAX(cap) + 12;
+
+	if (page_shift > dev_page_shift) {
+		dev_warn(&dev->pci_dev->dev,
+				"host/device page size mismatch %u/%u\n",
+				1 << page_shift, 1 << dev_page_shift);
+		page_shift = dev_page_shift;
+	}
 
 	result = nvme_disable_ctrl(dev, cap);
 	if (result < 0)
@@ -1465,8 +1475,10 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
 
+	dev->page_size = 1 << page_shift;
+
 	dev->ctrl_config = NVME_CC_ENABLE | NVME_CC_CSS_NVM;
-	dev->ctrl_config |= (PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
+	dev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
 	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
 	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 
@@ -1516,7 +1528,7 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
 	}
 
 	err = -ENOMEM;
-	iod = nvme_alloc_iod(count, length, GFP_KERNEL);
+	iod = nvme_alloc_iod(count, length, GFP_KERNEL, dev);
 	if (!iod)
 		goto put_pages;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 2bf4031..2a1dcaf 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -38,6 +38,7 @@ struct nvme_bar {
 #define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
 #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
 #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
+#define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
 
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
@@ -97,6 +98,7 @@ struct nvme_dev {
 	char firmware_rev[8];
 	u32 max_hw_sectors;
 	u32 stripe_size;
+	u32 page_size;
 	u16 oncs;
 	u16 abort_limit;
 	u8 vwc;
-- 
1.7.10.4
