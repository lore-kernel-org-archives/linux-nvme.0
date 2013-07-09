From: keith.busch@intel.com (Keith Busch)
Date: Tue,  9 Jul 2013 14:20:39 -0600
Subject: [PATCHv4 3/5] NVMe: Separate controller init from disk discovery
In-Reply-To: <1373401241-20259-1-git-send-email-keith.busch@intel.com>
References: <1373401241-20259-1-git-send-email-keith.busch@intel.com>
Message-ID: <1373401241-20259-4-git-send-email-keith.busch@intel.com>

This combines the controller initialization into one function, removing
IO queue setup from namespace discovery, and creates symetric functions
for device removal. The controller start and shutdown functions can now
be called from resume/suspend context as well as probe/remove.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   77 +++++++++++++++++++++++++++-----------------
 1 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 9ae3054..0d28015 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1841,10 +1841,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	dma_addr_t dma_addr;
 	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
 
-	res = nvme_setup_io_queues(dev);
-	if (res)
-		return res;
-
 	mem = dma_alloc_coherent(&dev->pci_dev->dev, 8192, &dma_addr,
 								GFP_KERNEL);
 	if (!mem)
@@ -1952,27 +1948,29 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 		pci_disable_device(dev->pci_dev);
 }
 
-static int nvme_dev_remove(struct nvme_dev *dev)
+static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
-	struct nvme_ns *ns, *next;
 	int i;
 
 	for (i = dev->queue_count - 1; i >= 0; i--)
 		 nvme_disable_queue(dev, i);
 
 	spin_lock(&dev_list_lock);
-	list_del(&dev->node);
+	list_del_init(&dev->node);
 	spin_unlock(&dev_list_lock);
 
+	nvme_dev_unmap(dev);
+}
+
+static void nvme_dev_remove(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns, *next;
+
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
 		list_del(&ns->list);
 		del_gendisk(ns->disk);
 		nvme_ns_free(ns);
 	}
-
-	nvme_free_queues(dev);
-
-	return 0;
 }
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
@@ -2032,7 +2030,8 @@ static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 	nvme_dev_remove(dev);
-	nvme_dev_unmap(dev);
+	nvme_dev_shutdown(dev);
+	nvme_free_queues(dev);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
 	kfree(dev->queues);
@@ -2075,6 +2074,37 @@ static const struct file_operations nvme_dev_fops = {
 	.compat_ioctl	= nvme_dev_ioctl,
 };
 
+static int nvme_dev_start(struct nvme_dev *dev)
+{
+	int result;
+
+	result = nvme_dev_map(dev);
+	if (result)
+		return result;
+
+	result = nvme_configure_admin_queue(dev);
+	if (result)
+		goto unmap;
+
+	spin_lock(&dev_list_lock);
+	list_add(&dev->node, &dev_list);
+	spin_unlock(&dev_list_lock);
+
+	result = nvme_setup_io_queues(dev);
+	if (result)
+		goto disable;
+
+	return 0;
+
+ disable:
+	spin_lock(&dev_list_lock);
+	list_del_init(&dev->node);
+	spin_unlock(&dev_list_lock);
+ unmap:
+	nvme_dev_unmap(dev);
+	return result;
+}
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int result = -ENOMEM;
@@ -2102,21 +2132,13 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release;
 
-	result = nvme_dev_map(dev);
+	result = nvme_dev_start(dev);
 	if (result)
 		goto release_pools;
 
-	result = nvme_configure_admin_queue(dev);
-	if (result)
-		goto unmap;
-
-	spin_lock(&dev_list_lock);
-	list_add(&dev->node, &dev_list);
-	spin_unlock(&dev_list_lock);
-
 	result = nvme_dev_add(dev);
 	if (result)
-		goto delete;
+		goto shutdown;
 
 	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
 	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
@@ -2132,15 +2154,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
  remove:
 	nvme_dev_remove(dev);
- delete:
-	spin_lock(&dev_list_lock);
-	list_del(&dev->node);
-	spin_unlock(&dev_list_lock);
-
-	nvme_free_queues(dev);
- unmap:
-	nvme_dev_unmap(dev);
+ shutdown:
+	nvme_dev_shutdown(dev);
  release_pools:
+	nvme_free_queues(dev);
 	nvme_release_prp_pools(dev);
  release:
 	nvme_release_instance(dev);
-- 
1.7.0.4
