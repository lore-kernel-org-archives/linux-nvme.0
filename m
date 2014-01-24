From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 Jan 2014 16:50:48 -0700
Subject: [PATCH 1/7] NVMe: Namespace use after free on surprise removal
In-Reply-To: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
References: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
Message-ID: <1390607454-23273-2-git-send-email-keith.busch@intel.com>

An nvme block device may have open references when the device is
removed. New commands may still be sent on the removed device, so we
need to ref count the opens, return errors for to new commands, and not
free the namespace and nvme_dev until all references are closed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   55 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b59a93a..7163a2f 100644
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
@@ -1844,13 +1865,6 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	return NULL;
 }
 
-static void nvme_ns_free(struct nvme_ns *ns)
-{
-	put_disk(ns->disk);
-	blk_cleanup_queue(ns->queue);
-	kfree(ns);
-}
-
 static int set_queue_count(struct nvme_dev *dev, int count)
 {
 	int status;
@@ -2281,12 +2295,13 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 static void nvme_dev_remove(struct nvme_dev *dev)
 {
-	struct nvme_ns *ns, *next;
+	struct nvme_ns *ns;
 
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		list_del(&ns->list);
-		del_gendisk(ns->disk);
-		nvme_ns_free(ns);
+	list_for_each_entry(ns, &dev->namespaces, list) {
+		if (ns->disk->flags & GENHD_FL_UP)
+			del_gendisk(ns->disk);
+		if (!blk_queue_dying(ns->queue))
+			blk_cleanup_queue(ns->queue);
 	}
 }
 
@@ -2343,9 +2358,22 @@ static void nvme_release_instance(struct nvme_dev *dev)
 	spin_unlock(&dev_list_lock);
 }
 
+static void nvme_free_namespaces(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns, *next;
+
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
+		list_del(&ns->list);
+		put_disk(ns->disk);
+		kfree(ns);
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
@@ -2518,6 +2546,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release_pools;
 	}
 
+	kref_init(&dev->kref);
 	result = nvme_dev_add(dev);
 	if (result)
 		goto shutdown;
@@ -2533,11 +2562,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
