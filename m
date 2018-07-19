From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 19 Jul 2018 17:06:27 -0600
Subject: [RCF PATCH 1/2] nvme: pci: Move CMB allocation into a pool.
In-Reply-To: <20180719230628.31494-1-scott.bauer@intel.com>
References: <20180719230628.31494-1-scott.bauer@intel.com>
Message-ID: <20180719230628.31494-2-scott.bauer@intel.com>

This switches the CMB allocation from straight offset calculations
into allocating from a pool.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 drivers/nvme/host/pci.c | 58 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8dcae11bbf3a..b8c81be4a985 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -30,6 +30,7 @@
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/sed-opal.h>
+#include <linux/genalloc.h>
 
 #include "nvme.h"
 
@@ -100,7 +101,7 @@ struct nvme_dev {
 	struct mutex shutdown_lock;
 	bool subsystem;
 	void __iomem *cmb;
-	pci_bus_addr_t cmb_bus_addr;
+	struct gen_pool *cmb_pool;
 	u64 cmb_size;
 	u32 cmbsz;
 	u32 cmbloc;
@@ -1300,6 +1301,12 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 	if (nvmeq->sq_cmds)
 		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
 					nvmeq->sq_cmds, nvmeq->sq_dma_addr);
+	if (nvmeq->sq_cmds_io) {
+		gen_pool_free(nvmeq->dev->cmb_pool,(unsigned long)nvmeq->sq_cmds_io,
+			      roundup(SQ_SIZE(nvmeq->q_depth),
+				      nvmeq->dev->ctrl.page_size));
+		nvmeq->sq_cmds_io = NULL;
+	}
 }
 
 static void nvme_free_queues(struct nvme_dev *dev, int lowest)
@@ -1467,14 +1474,19 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
-	int result;
+	int result = -ENOMEM;
 	s16 vector;
+	unsigned size;
 
+	size = roundup(SQ_SIZE(nvmeq->q_depth), dev->ctrl.page_size);
 	if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
-		unsigned offset = (qid - 1) * roundup(SQ_SIZE(nvmeq->q_depth),
-						      dev->ctrl.page_size);
-		nvmeq->sq_dma_addr = dev->cmb_bus_addr + offset;
-		nvmeq->sq_cmds_io = dev->cmb + offset;
+		nvmeq->sq_cmds_io = (void *) gen_pool_alloc(dev->cmb_pool, size);
+		if (!nvmeq->sq_cmds_io)
+			return result;
+
+		nvmeq->sq_dma_addr =
+			gen_pool_virt_to_phys(dev->cmb_pool,
+					      (unsigned long)nvmeq->sq_cmds_io);
 	}
 
 	/*
@@ -1710,8 +1722,7 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	u64 size, offset;
 	resource_size_t bar_size;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int bar;
-
+	int bar, ret;
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!dev->cmbsz)
 		return;
@@ -1733,24 +1744,51 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	 * for example, due to being behind a bridge. Reduce the CMB to
 	 * the reported size of the BAR
 	 */
+
 	if (size > bar_size - offset)
 		size = bar_size - offset;
 
+	dev->cmb_pool = gen_pool_create(PAGE_SHIFT, dev_to_node(&pdev->dev));
+	if (!dev->cmb_pool)
+		return;
+
 	dev->cmb = ioremap_wc(pci_resource_start(pdev, bar) + offset, size);
 	if (!dev->cmb)
-		return;
-	dev->cmb_bus_addr = pci_bus_address(pdev, bar) + offset;
+		goto unwind_pool;
+
+	ret = gen_pool_add_virt(dev->cmb_pool, (unsigned long) dev->cmb,
+				pci_bus_address(pdev, bar) + offset,
+				size, dev_to_node(&pdev->dev));
+
+	if (ret) {
+		pr_err("%s: failed to add our virt to the gen pool\n", __func__);
+		goto unwind_pool_cmb;
+	}
+
 	dev->cmb_size = size;
 
 	if (sysfs_add_file_to_group(&dev->ctrl.device->kobj,
 				    &dev_attr_cmb.attr, NULL))
 		dev_warn(dev->ctrl.device,
 			 "failed to add sysfs attribute for CMB\n");
+
+	return;
+
+ unwind_pool_cmb:
+	iounmap(dev->cmb);
+	dev->cmb = NULL;
+ unwind_pool:
+	gen_pool_destroy(dev->cmb_pool);
+	dev->cmb_pool = NULL;
 }
 
 static inline void nvme_release_cmb(struct nvme_dev *dev)
 {
 	if (dev->cmb) {
+		if (use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS))
+			nvme_free_queues(dev, 1);
+		gen_pool_destroy(dev->cmb_pool);
+		dev->cmb_pool = NULL;
 		iounmap(dev->cmb);
 		dev->cmb = NULL;
 		sysfs_remove_file_from_group(&dev->ctrl.device->kobj,
-- 
2.17.1
