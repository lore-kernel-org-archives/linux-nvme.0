From: drake@endlessm.com (Daniel Drake)
Date: Thu, 20 Jun 2019 13:13:30 +0800
Subject: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
In-Reply-To: <20190620051333.2235-1-drake@endlessm.com>
References: <20190620051333.2235-1-drake@endlessm.com>
Message-ID: <20190620051333.2235-3-drake@endlessm.com>

From: Dan Williams <dan.j.williams@intel.com>

In preparation for adding a platform_device nvme host, rename to a more
generic "mmio" prefix.

Signed-off-by: Dan Williams <dan.j.williams at intel.com>
Signed-off-by: Daniel Drake <drake at endlessm.com>
---
 drivers/nvme/host/pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 524d6bd6d095..42990b93349d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1108,7 +1108,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 	return found;
 }
 
-static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
+static void nvme_mmio_submit_async_event(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 	struct nvme_queue *nvmeq = &dev->queues[0];
@@ -2448,7 +2448,7 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
-static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
+static void nvme_mmio_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 
@@ -2610,42 +2610,42 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
+static int nvme_mmio_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 {
 	*val = readl(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
+static int nvme_mmio_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 {
 	writel(val, to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
+static int nvme_mmio_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
 	*val = readq(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
+static int nvme_mmio_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 {
 	struct pci_dev *pdev = to_pci_dev(to_nvme_dev(ctrl)->dev);
 
 	return snprintf(buf, size, "%s", dev_name(&pdev->dev));
 }
 
-static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
+static const struct nvme_ctrl_ops nvme_mmio_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
 	.flags			= NVME_F_METADATA_SUPPORTED |
 				  NVME_F_PCI_P2PDMA,
-	.reg_read32		= nvme_pci_reg_read32,
-	.reg_write32		= nvme_pci_reg_write32,
-	.reg_read64		= nvme_pci_reg_read64,
-	.free_ctrl		= nvme_pci_free_ctrl,
-	.submit_async_event	= nvme_pci_submit_async_event,
-	.get_address		= nvme_pci_get_address,
+	.reg_read32		= nvme_mmio_reg_read32,
+	.reg_write32		= nvme_mmio_reg_write32,
+	.reg_read64		= nvme_mmio_reg_read64,
+	.free_ctrl		= nvme_mmio_free_ctrl,
+	.submit_async_event	= nvme_mmio_submit_async_event,
+	.get_address		= nvme_mmio_get_address,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
@@ -2758,7 +2758,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release_pools;
 	}
 
-	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
+	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_mmio_ctrl_ops,
 			quirks);
 	if (result)
 		goto release_mempool;
-- 
2.20.1
