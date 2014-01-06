From: keith.busch@intel.com (Keith Busch)
Date: Mon,  6 Jan 2014 12:04:11 -0700
Subject: [PATCHv2 1/2] NVMe: Namespace use after free on surprise removal
In-Reply-To: <1389035052-30007-1-git-send-email-keith.busch@intel.com>
References: <1389035052-30007-1-git-send-email-keith.busch@intel.com>
Message-ID: <1389035052-30007-2-git-send-email-keith.busch@intel.com>

An nvme block device may have open references when the device is
removed. New commands may be attempted on the removed device, so we need
to ref count the opens and not free the namespaces and nvme_dev until
all references are closed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b59a93a..30d157f 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1712,10 +1712,31 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 #define nvme_compat_ioctl	NULL
 #endif
 
+static int nvme_open(struct block_device *bdev, fmode_t mode)
+{
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	struct nvme_dev *dev = ns->dev;
+
+	kref_get(&dev->kref);
+	return 0;
+}
+
+static void nvme_free_dev(struct kref *kref);
+
+static void nvme_release(struct gendisk *disk, fmode_t mode)
+{
+	struct nvme_ns *ns = disk->private_data;
+	struct nvme_dev *dev = ns->dev;
+
+	kref_put(&dev->kref, nvme_free_dev);
+}
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
 	.compat_ioctl	= nvme_compat_ioctl,
+	.open		= nvme_open,
+	.release	= nvme_release,
 };
 
 static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
@@ -2281,13 +2302,10 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 static void nvme_dev_remove(struct nvme_dev *dev)
 {
-	struct nvme_ns *ns, *next;
+	struct nvme_ns *ns;
 
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		list_del(&ns->list);
+	list_for_each_entry(ns, &dev->namespaces, list)
 		del_gendisk(ns->disk);
-		nvme_ns_free(ns);
-	}
 }
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
@@ -2343,9 +2361,21 @@ static void nvme_release_instance(struct nvme_dev *dev)
 	spin_unlock(&dev_list_lock);
 }
 
+static void nvme_free_namespaces(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns, *next;
+
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
+		list_del(&ns->list);
+		nvme_ns_free(ns);
+	}
+}
+
 static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
+
+	nvme_free_namespaces(dev);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2518,6 +2548,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release_pools;
 	}
 
+	kref_init(&dev->kref);
 	result = nvme_dev_add(dev);
 	if (result)
 		goto shutdown;
@@ -2533,11 +2564,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto remove;
 
 	dev->initialized = 1;
-	kref_init(&dev->kref);
 	return 0;
 
  remove:
 	nvme_dev_remove(dev);
+	nvme_free_namespaces(dev); 
  shutdown:
 	nvme_dev_shutdown(dev);
  release_pools:
-- 
1.7.10.4
