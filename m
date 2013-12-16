From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 16 Dec 2013 17:19:51 -0500
Subject: [PATCHv2] NVMe: compat SG_IO ioctl
In-Reply-To: <1382555254-23087-1-git-send-email-keith.busch@intel.com>
References: <1382555254-23087-1-git-send-email-keith.busch@intel.com>
Message-ID: <20131216221951.GL6900@linux.intel.com>

On Wed, Oct 23, 2013@01:07:34PM -0600, Keith Busch wrote:
> For 32-bit versions of sg3-utils running on a 64-bit system. This is
> mostly a copy from the relevent portions of fs/compat_ioctl.c, with
> slight modifications for going through block_device_operations.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> v1->v2:
> 
> Added the copying the status back into the 32-bit user structure at the
> end. I missed this when copying from the original implmenetation.

Thanks to Fengguang's automated tester, I ended up fixing the
!CONFIG_COMPAT case like this:

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 3f5d67a..b59a93a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1696,6 +1696,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 	}
 }
 
+#ifdef CONFIG_COMPAT
 static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 					unsigned int cmd, unsigned long arg)
 {
@@ -1707,6 +1708,9 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	}
 	return nvme_ioctl(bdev, mode, cmd, arg);
 }
+#else
+#define nvme_compat_ioctl	NULL
+#endif
 
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index be04c50..4a0ceb6 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -47,7 +47,6 @@
 #include <linux/types.h>
 #include <scsi/sg.h>
 #include <scsi/scsi.h>
-#include <asm/compat.h>
 
 
 static int sg_version_num = 30534;	/* 2 digits for each component */
@@ -3040,6 +3039,7 @@ int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr)
 	return retcode;
 }
 
+#ifdef CONFIG_COMPAT
 typedef struct sg_io_hdr32 {
 	compat_int_t interface_id;	/* [i] 'S' for SCSI generic (required) */
 	compat_int_t dxfer_direction;	/* [i] data transfer direction  */
@@ -3183,6 +3183,7 @@ int nvme_sg_io32(struct nvme_ns *ns, unsigned long arg)
 
 	return err;
 }
+#endif
 
 int nvme_sg_get_version_num(int __user *ip)
 {
