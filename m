From: keith.busch@intel.com (Keith Busch)
Date: Fri,  2 Oct 2015 10:37:28 -0600
Subject: [PATCH 1/2] NVMe: Namespace removal simplifications
Message-ID: <1443803849-7268-1-git-send-email-keith.busch@intel.com>

This liberates namespace removal from the device, allowing gendisk
references to be closed independent of the nvme controller reference
count.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b02ae3d..904b54f 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1943,6 +1943,7 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 #define nvme_compat_ioctl	NULL
 #endif
 
+static void nvme_free_dev(struct kref *kref);
 static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
@@ -1951,6 +1952,7 @@ static void nvme_free_ns(struct kref *kref)
 	ns->disk->private_data = NULL;
 	spin_unlock(&dev_list_lock);
 
+	kref_put(&ns->dev->kref, nvme_free_dev);
 	put_disk(ns->disk);
 	kfree(ns);
 }
@@ -1966,22 +1968,14 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 		ret = -ENXIO;
 	else if (!kref_get_unless_zero(&ns->kref))
 		ret = -ENXIO;
-	else if (!kref_get_unless_zero(&ns->dev->kref)) {
-		kref_put(&ns->kref, nvme_free_ns);
-		ret = -ENXIO;
-	}
 	spin_unlock(&dev_list_lock);
 
 	return ret;
 }
 
-static void nvme_free_dev(struct kref *kref);
 static void nvme_release(struct gendisk *disk, fmode_t mode)
 {
 	struct nvme_ns *ns = disk->private_data;
-	struct nvme_dev *dev = ns->dev;
-
-	kref_put(&dev->kref, nvme_free_dev);
 	kref_put(&ns->kref, nvme_free_ns);
 }
 
@@ -2179,6 +2173,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	if (nvme_revalidate_disk(ns->disk))
 		goto out_free_disk;
 
+	kref_get(&dev->kref);
 	add_disk(ns->disk);
 	if (ns->ms) {
 		struct block_device *bd = bdget_disk(ns->disk, 0);
@@ -2374,12 +2369,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	return result;
 }
 
-static void nvme_free_namespace(struct nvme_ns *ns)
-{
-	list_del(&ns->list);
-	kref_put(&ns->kref, nvme_free_ns);
-}
-
 static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
@@ -2421,7 +2410,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (kill || !blk_queue_dying(ns->queue)) {
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
-        }
+	}
+	list_del_init(&ns->list);
+	kref_put(&ns->kref, nvme_free_ns);
 }
 
 static void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn)
@@ -2432,18 +2423,14 @@ static void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn)
 	for (i = 1; i <= nn; i++) {
 		ns = nvme_find_ns(dev, i);
 		if (ns) {
-			if (revalidate_disk(ns->disk)) {
+			if (revalidate_disk(ns->disk))
 				nvme_ns_remove(ns);
-				nvme_free_namespace(ns);
-			}
 		} else
 			nvme_alloc_ns(dev, i);
 	}
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		if (ns->ns_id > nn) {
+		if (ns->ns_id > nn)
 			nvme_ns_remove(ns);
-			nvme_free_namespace(ns);
-		}
 	}
 	list_sort(NULL, &dev->namespaces, ns_cmp);
 }
@@ -2833,9 +2820,9 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 static void nvme_dev_remove(struct nvme_dev *dev)
 {
-	struct nvme_ns *ns;
+	struct nvme_ns *ns, *next;
 
-	list_for_each_entry(ns, &dev->namespaces, list)
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list)
 		nvme_ns_remove(ns);
 }
 
@@ -2891,21 +2878,12 @@ static void nvme_release_instance(struct nvme_dev *dev)
 	spin_unlock(&dev_list_lock);
 }
 
-static void nvme_free_namespaces(struct nvme_dev *dev)
-{
-	struct nvme_ns *ns, *next;
-
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list)
-		nvme_free_namespace(ns);
-}
-
 static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 
 	put_device(dev->dev);
 	put_device(dev->device);
-	nvme_free_namespaces(dev);
 	nvme_release_instance(dev);
 	if (dev->tagset.tags)
 		blk_mq_free_tag_set(&dev->tagset);
-- 
1.7.10.4
