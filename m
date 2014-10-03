From: keith.busch@intel.com (Keith Busch)
Date: Fri,  3 Oct 2014 11:15:47 -0600
Subject: [PATCH] NVMe: Do not open disks that are being deleted
Message-ID: <1412356547-18764-1-git-send-email-keith.busch@intel.com>

It is possible the block layer will request to open a block device after
the driver deleted it. Subsequent releases will cause a double free,
or the disk's private_data is pointing to freed memory. This patch
protects the driver's freed disks from being opened and accessed: the
nvme namespaces are freed only when the device's refcount is 0, so at
that moment there were no active openers and no more should be allowed,
and it is safe to clear the disk's private_data that is about to be freed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reported-by: Henry Chow <henry.chow at oracle.com>
---
 drivers/block/nvme-core.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 6c077cd..a5ea19d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1812,11 +1812,18 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
-	struct nvme_ns *ns = bdev->bd_disk->private_data;
-	struct nvme_dev *dev = ns->dev;
+	int ret = 0;
+	struct nvme_ns *ns;
 
-	kref_get(&dev->kref);
-	return 0;
+	spin_lock(&dev_list_lock);
+	ns = bdev->bd_disk->private_data;
+	if (!ns)
+		ret = -ENXIO;
+	else if (!kref_get_unless_zero(&ns->dev->kref))
+		ret = -ENXIO;
+	spin_unlock(&dev_list_lock);
+
+	return ret;
 }
 
 static void nvme_free_dev(struct kref *kref);
@@ -2659,6 +2666,11 @@ static void nvme_free_namespaces(struct nvme_dev *dev)
 
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
 		list_del(&ns->list);
+
+		spin_lock(&dev_list_lock);
+		ns->disk->private_data = NULL;
+		spin_unlock(&dev_list_lock);
+
 		put_disk(ns->disk);
 		kfree(ns);
 	}
-- 
1.7.10.4
