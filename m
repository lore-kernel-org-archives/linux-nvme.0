From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 21 Oct 2016 17:25:32 -0700
Subject: [PATCH 2/5] nvme: rename "pci" operations to "mmio"
In-Reply-To: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <147709593202.3733.18343149615618494644.stgit@dwillia2-desk3.amr.corp.intel.com>

In preparation for adding a platform_device nvme host, rename to a more
generic "mmio" prefix.

Signed-off-by: Dan Williams <dan.j.williams at intel.com>
---
 drivers/nvme/host/pci.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0fc99f0f2571..8c4330b95be8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -771,7 +771,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	return 0;
 }
 
-static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
+static void nvme_mmio_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 	struct nvme_queue *nvmeq = dev->queues[0];
@@ -1704,7 +1704,7 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
-static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
+static void nvme_mmio_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 
@@ -1826,38 +1826,38 @@ static int nvme_reset(struct nvme_dev *dev)
 	return 0;
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
 
-static int nvme_pci_reset_ctrl(struct nvme_ctrl *ctrl)
+static int nvme_mmio_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	return nvme_reset(to_nvme_dev(ctrl));
 }
 
-static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
-	.name			= "pcie",
+static const struct nvme_ctrl_ops nvme_mmio_ctrl_ops = {
+	.name			= "mmio",
 	.module			= THIS_MODULE,
-	.reg_read32		= nvme_pci_reg_read32,
-	.reg_write32		= nvme_pci_reg_write32,
-	.reg_read64		= nvme_pci_reg_read64,
-	.reset_ctrl		= nvme_pci_reset_ctrl,
-	.free_ctrl		= nvme_pci_free_ctrl,
-	.submit_async_event	= nvme_pci_submit_async_event,
+	.reg_read32		= nvme_mmio_reg_read32,
+	.reg_write32		= nvme_mmio_reg_write32,
+	.reg_read64		= nvme_mmio_reg_read64,
+	.reset_ctrl		= nvme_mmio_reset_ctrl,
+	.free_ctrl		= nvme_mmio_free_ctrl,
+	.submit_async_event	= nvme_mmio_submit_async_event,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
@@ -1912,7 +1912,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto put_pci;
 
-	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
+	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_mmio_ctrl_ops,
 			id->driver_data);
 	if (result)
 		goto release_pools;
