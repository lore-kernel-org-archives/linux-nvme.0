From: keith.busch@intel.com (Keith Busch)
Date: Mon, 24 Jun 2013 14:30:55 -0600
Subject: [PATCHv3 1/5] NVMe: Group pci related actions in functions
In-Reply-To: <1372105859-27850-1-git-send-email-keith.busch@intel.com>
References: <1372105859-27850-1-git-send-email-keith.busch@intel.com>
Message-ID: <1372105859-27850-2-git-send-email-keith.busch@intel.com>

This will make it easier to reuse these outside probe/remove.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |  116 +++++++++++++++++++++++++++------------------
 1 files changed, 70 insertions(+), 46 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 07d527c..3751888 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1192,9 +1192,6 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	u64 cap = readq(&dev->bar->cap);
 	struct nvme_queue *nvmeq;
 
-	dev->dbs = ((void __iomem *)dev->bar) + 4096;
-	dev->db_stride = NVME_CAP_STRIDE(cap);
-
 	result = nvme_disable_ctrl(dev, cap);
 	if (result < 0)
 		return result;
@@ -1686,6 +1683,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (db_bar_size > 8192) {
 		iounmap(dev->bar);
 		dev->bar = ioremap(pci_resource_start(pdev, 0), db_bar_size);
+		if (!dev->bar)
+			return -ENOMEM;
 		dev->dbs = ((void __iomem *)dev->bar) + 4096;
 		dev->queues[0]->q_db = dev->dbs;
 	}
@@ -1830,6 +1829,63 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	return res;
 }
 
+static int nvme_dev_map(struct nvme_dev *dev)
+{
+	int bars, result = -ENOMEM;
+	struct pci_dev *pdev = dev->pci_dev;
+
+	if (pci_enable_device_mem(pdev))
+		return result;
+
+	dev->entry[0].vector = pdev->irq;
+	pci_set_master(pdev);
+	bars = pci_select_bars(pdev, IORESOURCE_MEM);
+	if (pci_request_selected_regions(pdev, bars, "nvme"))
+		goto disable_pci;
+
+	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)))
+		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+	else if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(32)))
+		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	else
+		goto disable_pci;
+
+	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+	pci_set_drvdata(pdev, dev);
+
+	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
+	if (!dev->bar)
+		goto disable;
+
+	dev->db_stride = NVME_CAP_STRIDE(readq(&dev->bar->cap));
+	dev->dbs = ((void __iomem *)dev->bar) + 4096;
+
+	return 0;
+
+ disable:
+	pci_release_regions(pdev);
+ disable_pci:
+	pci_disable_device(pdev);
+	return result;
+}
+
+static void nvme_dev_unmap(struct nvme_dev *dev)
+{
+	if (dev->pci_dev->msi_enabled)
+		pci_disable_msi(dev->pci_dev);
+	else if (dev->pci_dev->msix_enabled)
+		pci_disable_msix(dev->pci_dev);
+
+	if (dev->bar) {
+		iounmap(dev->bar);
+		dev->bar = 0;
+	}
+
+	pci_release_regions(dev->pci_dev);
+	if (pci_is_enabled(dev->pci_dev))
+		pci_disable_device(dev->pci_dev);
+}
+
 static int nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
@@ -1906,15 +1962,9 @@ static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 	nvme_dev_remove(dev);
-	if (dev->pci_dev->msi_enabled)
-		pci_disable_msi(dev->pci_dev);
-	else if (dev->pci_dev->msix_enabled)
-		pci_disable_msix(dev->pci_dev);
-	iounmap(dev->bar);
+	nvme_dev_unmap(dev);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
-	pci_disable_device(dev->pci_dev);
-	pci_release_regions(dev->pci_dev);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -1957,7 +2007,7 @@ static const struct file_operations nvme_dev_fops = {
 
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int bars, result = -ENOMEM;
+	int result = -ENOMEM;
 	struct nvme_dev *dev;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -1972,39 +2022,19 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dev->queues)
 		goto free;
 
-	if (pci_enable_device_mem(pdev))
-		goto free;
-	pci_set_master(pdev);
-	bars = pci_select_bars(pdev, IORESOURCE_MEM);
-	if (pci_request_selected_regions(pdev, bars, "nvme"))
-		goto disable;
-
 	INIT_LIST_HEAD(&dev->namespaces);
 	dev->pci_dev = pdev;
-	pci_set_drvdata(pdev, dev);
-
-	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)))
-		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
-	else if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(32)))
-		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	else
-		goto disable;
-
 	result = nvme_set_instance(dev);
 	if (result)
-		goto disable;
-
-	dev->entry[0].vector = pdev->irq;
+		goto free;
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
-		goto disable_msix;
+		goto release;
 
-	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
-	if (!dev->bar) {
-		result = -ENOMEM;
-		goto disable_msix;
-	}
+	result = nvme_dev_map(dev);
+	if (result)
+		goto release_pools;
 
 	result = nvme_configure_admin_queue(dev);
 	if (result)
@@ -2040,17 +2070,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	nvme_free_queues(dev);
  unmap:
-	iounmap(dev->bar);
- disable_msix:
-	if (dev->pci_dev->msi_enabled)
-		pci_disable_msi(dev->pci_dev);
-	else if (dev->pci_dev->msix_enabled)
-		pci_disable_msix(dev->pci_dev);
-	nvme_release_instance(dev);
+	nvme_dev_unmap(dev);
+ release_pools:
 	nvme_release_prp_pools(dev);
- disable:
-	pci_disable_device(pdev);
-	pci_release_regions(pdev);
+ release:
+	nvme_release_instance(dev);
  free:
 	kfree(dev->queues);
 	kfree(dev->entry);
-- 
1.7.0.4
