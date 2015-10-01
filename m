From: keith.busch@intel.com (Keith Busch)
Date: Thu,  1 Oct 2015 17:14:10 -0600
Subject: [PATCH 1/2] NVMe: Reference count open namespaces
In-Reply-To: <1443741251-13274-1-git-send-email-keith.busch@intel.com>
References: <1443741251-13274-1-git-send-email-keith.busch@intel.com>
Message-ID: <1443741251-13274-2-git-send-email-keith.busch@intel.com>

Dynamic namespace attachment means the namespace may be removed at any
time, so the namespace reference count can not be tied to the device
reference count. This fixes a NULL dereference if an opened namespace
is detached from a controller.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   29 ++++++++++++++++++++---------
 include/linux/nvme.h      |    1 +
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 6f04771..b02ae3d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1943,6 +1943,18 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 #define nvme_compat_ioctl	NULL
 #endif
 
+static void nvme_free_ns(struct kref *kref)
+{
+	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
+
+	spin_lock(&dev_list_lock);
+	ns->disk->private_data = NULL;
+	spin_unlock(&dev_list_lock);
+
+	put_disk(ns->disk);
+	kfree(ns);
+}
+
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
 	int ret = 0;
@@ -1952,21 +1964,25 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 	ns = bdev->bd_disk->private_data;
 	if (!ns)
 		ret = -ENXIO;
-	else if (!kref_get_unless_zero(&ns->dev->kref))
+	else if (!kref_get_unless_zero(&ns->kref))
 		ret = -ENXIO;
+	else if (!kref_get_unless_zero(&ns->dev->kref)) {
+		kref_put(&ns->kref, nvme_free_ns);
+		ret = -ENXIO;
+	}
 	spin_unlock(&dev_list_lock);
 
 	return ret;
 }
 
 static void nvme_free_dev(struct kref *kref);
-
 static void nvme_release(struct gendisk *disk, fmode_t mode)
 {
 	struct nvme_ns *ns = disk->private_data;
 	struct nvme_dev *dev = ns->dev;
 
 	kref_put(&dev->kref, nvme_free_dev);
+	kref_put(&ns->kref, nvme_free_ns);
 }
 
 static int nvme_getgeo(struct block_device *bd, struct hd_geometry *geo)
@@ -2126,6 +2142,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	if (!disk)
 		goto out_free_queue;
 
+	kref_init(&ns->kref);
 	ns->ns_id = nsid;
 	ns->disk = disk;
 	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
@@ -2360,13 +2377,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 static void nvme_free_namespace(struct nvme_ns *ns)
 {
 	list_del(&ns->list);
-
-	spin_lock(&dev_list_lock);
-	ns->disk->private_data = NULL;
-	spin_unlock(&dev_list_lock);
-
-	put_disk(ns->disk);
-	kfree(ns);
+	kref_put(&ns->kref, nvme_free_ns);
 }
 
 static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b5812c3..992b9c1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -135,6 +135,7 @@ struct nvme_ns {
 	struct nvme_dev *dev;
 	struct request_queue *queue;
 	struct gendisk *disk;
+	struct kref kref;
 
 	unsigned ns_id;
 	int lba_shift;
-- 
1.7.10.4
