From: keith.busch@intel.com (Keith Busch)
Date: Wed,  2 Apr 2014 15:45:37 -0600
Subject: [PATCH] NVMe: Add getgeo to block ops
Message-ID: <1396475137-19091-1-git-send-email-keith.busch@intel.com>

Some programs require HDIO_GETGEO work, which requires we implement
getgeo.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
For example, fdisk -l doesn't automatically list the nvme drivers
without this. There are other programs that require this as well.

We have to pick some values for this. I just copied the ones used by
default from virtio-blk... Are these okay?

 drivers/block/nvme-core.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 625259d..a113e10 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/genhd.h>
+#include <linux/hdreg.h>
 #include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -1708,12 +1709,22 @@ static void nvme_release(struct gendisk *disk, fmode_t mode)
 	kref_put(&dev->kref, nvme_free_dev);
 }
 
+static int nvme_getgeo(struct block_device *bd, struct hd_geometry *geo)
+{
+	/* some standard values */
+	geo->heads = 1 << 6;
+	geo->sectors = 1 << 5;
+	geo->cylinders = get_capacity(bd->bd_disk) >> 11;
+	return 0;
+}
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
 	.compat_ioctl	= nvme_compat_ioctl,
 	.open		= nvme_open,
 	.release	= nvme_release,
+	.getgeo		= nvme_getgeo,
 };
 
 static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
-- 
1.7.10.4
