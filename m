From: keith.busch@intel.com (Keith Busch)
Date: Mon,  6 May 2013 17:03:31 -0600
Subject: [PATCH 1/5] NVMe: Group pci related actions in functions
In-Reply-To: <1367881415-7978-1-git-send-email-keith.busch@intel.com>
References: <1367881415-7978-1-git-send-email-keith.busch@intel.com>
Message-ID: <1367881415-7978-2-git-send-email-keith.busch@intel.com>

This will make it easier to reuse these outside probe/remove.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   86 +++++++++++++++++++++++++++------------------
 1 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 310d573..b18ddef 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1156,9 +1156,6 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	u64 cap = readq(&dev->bar->cap);
 	struct nvme_queue *nvmeq;
 
-	dev->dbs = ((void __iomem *)dev->bar) + 4096;
-	dev->db_stride = NVME_CAP_STRIDE(cap);
-
 	result = nvme_disable_ctrl(dev, cap);
 	if (result < 0)
 		return result;
@@ -1770,6 +1767,47 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	return res;
 }
 
+static int nvme_dev_map(struct nvme_dev *dev)
+{
+	int bars, result = -ENOMEM;
+
+	if (pci_enable_device_mem(dev->pci_dev))
+		return result;
+
+	dev->entry[0].vector = dev->pci_dev->irq;
+	pci_set_master(dev->pci_dev);
+	bars = pci_select_bars(dev->pci_dev, IORESOURCE_MEM);
+	if (pci_request_selected_regions(dev->pci_dev, bars, "nvme"))
+		goto disable_pci;
+
+	dma_set_mask(&dev->pci_dev->dev, DMA_BIT_MASK(64));
+	dma_set_coherent_mask(&dev->pci_dev->dev, DMA_BIT_MASK(64));
+	pci_set_drvdata(dev->pci_dev, dev);
+
+	dev->bar = ioremap(pci_resource_start(dev->pci_dev, 0), 8192);
+	if (!dev->bar)
+		goto disable;
+
+	dev->db_stride = NVME_CAP_STRIDE(readq(&dev->bar->cap));
+	dev->dbs = ((void __iomem *)dev->bar) + 4096;
+
+	return 0;
+
+ disable:
+	pci_release_regions(dev->pci_dev);
+ disable_pci:
+	pci_disable_device(dev->pci_dev);
+	return result;
+}
+
+static void nvme_dev_unmap(struct nvme_dev *dev)
+{
+	pci_disable_msix(dev->pci_dev);
+	iounmap(dev->bar);
+	pci_disable_device(dev->pci_dev);
+	pci_release_regions(dev->pci_dev);
+}
+
 static int nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
@@ -1846,12 +1884,9 @@ static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 	nvme_dev_remove(dev);
-	pci_disable_msix(dev->pci_dev);
-	iounmap(dev->bar);
+	nvme_dev_unmap(dev);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
-	pci_disable_device(dev->pci_dev);
-	pci_release_regions(dev->pci_dev);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -1894,7 +1929,7 @@ static const struct file_operations nvme_dev_fops = {
 
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int bars, result = -ENOMEM;
+	int result = -ENOMEM;
 	struct nvme_dev *dev;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -1909,33 +1944,19 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
-	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
-	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
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
@@ -1971,14 +1992,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	nvme_free_queues(dev);
  unmap:
-	iounmap(dev->bar);
- disable_msix:
-	pci_disable_msix(pdev);
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
