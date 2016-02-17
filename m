From: keith.busch@intel.com (Keith Busch)
Date: Wed, 17 Feb 2016 11:36:55 -0700
Subject: [PATCH-4.5-v3 5/5] NVMe: Don't unmap controller registers on reset
In-Reply-To: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455734215-20396-6-git-send-email-keith.busch@intel.com>

Unmapping the registers on reset or shutdown is not necessary. Keeping
the mapping simplifies reset handling.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 71 +++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 27042c0..f11daba 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1699,10 +1699,10 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	return 0;
 }
 
-static int nvme_dev_map(struct nvme_dev *dev)
+static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	u64 cap;
-	int bars, result = -ENOMEM;
+	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	if (pci_enable_device_mem(pdev))
@@ -1710,24 +1710,14 @@ static int nvme_dev_map(struct nvme_dev *dev)
 
 	dev->entry[0].vector = pdev->irq;
 	pci_set_master(pdev);
-	bars = pci_select_bars(pdev, IORESOURCE_MEM);
-	if (!bars)
-		goto disable_pci;
-
-	if (pci_request_selected_regions(pdev, bars, "nvme"))
-		goto disable_pci;
 
 	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
 	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
 		goto disable;
 
-	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
-	if (!dev->bar)
-		goto disable;
-
 	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
 		result = -ENODEV;
-		goto unmap;
+		goto disable;
 	}
 
 	/*
@@ -1737,7 +1727,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	if (!pdev->irq) {
 		result = pci_enable_msix(pdev, dev->entry, 1);
 		if (result < 0)
-			goto unmap;
+			goto disable;
 	}
 
 	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
@@ -1764,18 +1754,20 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	pci_save_state(pdev);
 	return 0;
 
- unmap:
-	iounmap(dev->bar);
-	dev->bar = NULL;
  disable:
-	pci_release_regions(pdev);
- disable_pci:
 	pci_disable_device(pdev);
 	return result;
 }
 
 static void nvme_dev_unmap(struct nvme_dev *dev)
 {
+	if (dev->bar)
+		iounmap(dev->bar);
+	pci_release_regions(to_pci_dev(dev->dev));
+}
+
+static void nvme_pci_disable(struct nvme_dev *dev)
+{
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	if (pdev->msi_enabled)
@@ -1783,12 +1775,6 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 	else if (pdev->msix_enabled)
 		pci_disable_msix(pdev);
 
-	if (dev->bar) {
-		iounmap(dev->bar);
-		dev->bar = NULL;
-		pci_release_regions(pdev);
-	}
-
 	if (pci_is_enabled(pdev)) {
 		pci_disable_pcie_error_reporting(pdev);
 		pci_disable_device(pdev);
@@ -1847,7 +1833,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_dev_list_remove(dev);
 
 	mutex_lock(&dev->shutdown_lock);
-	if (dev->bar) {
+	if (pci_is_enabled(to_pci_dev(dev->dev))) {
 		nvme_stop_queues(&dev->ctrl);
 		csts = readl(dev->bar + NVME_REG_CSTS);
 	}
@@ -1860,7 +1846,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
-	nvme_dev_unmap(dev);
+	nvme_pci_disable(dev);
 
 	for (i = dev->queue_count - 1; i >= 0; i--)
 		nvme_clear_queue(dev->queues[i]);
@@ -1926,12 +1912,12 @@ static void nvme_reset_work(struct work_struct *work)
 	 * If we're called to reset a live controller first shut it down before
 	 * moving on.
 	 */
-	if (dev->bar)
+	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
 
 	set_bit(NVME_CTRL_RESETTING, &dev->flags);
 
-	result = nvme_dev_map(dev);
+	result = nvme_pci_enable(dev);
 	if (result)
 		goto out;
 
@@ -2039,6 +2025,27 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.free_ctrl		= nvme_pci_free_ctrl,
 };
 
+static int nvme_dev_map(struct nvme_dev *dev)
+{
+	int bars;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	bars = pci_select_bars(pdev, IORESOURCE_MEM);
+	if (!bars)
+		return -ENODEV;
+	if (pci_request_selected_regions(pdev, bars, "nvme"))
+		return -ENODEV;
+
+	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
+	if (!dev->bar)
+		goto release;
+
+       return 0;
+  release:
+       pci_release_regions(pdev);
+       return -ENODEV;
+}
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int node, result = -ENOMEM;
@@ -2063,6 +2070,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
 
+	result = nvme_dev_map(dev);
+	if (result)
+		goto free;
+
 	INIT_LIST_HEAD(&dev->node);
 	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
@@ -2086,6 +2097,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_release_prp_pools(dev);
  put_pci:
 	put_device(dev->dev);
+	nvme_dev_unmap(dev);
  free:
 	kfree(dev->queues);
 	kfree(dev->entry);
@@ -2129,6 +2141,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_free_queues(dev, 0);
 	nvme_release_cmb(dev);
 	nvme_release_prp_pools(dev);
+	nvme_dev_unmap(dev);
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-- 
2.6.2.307.g37023ba
