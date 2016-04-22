From: rafael.antognolli@intel.com (Rafael Antognolli)
Date: Fri, 22 Apr 2016 16:12:12 -0700
Subject: [PATCH 2/2] NVMe: Add ioctls to save and unlock an Opal locking range.
In-Reply-To: <1461366732-31779-1-git-send-email-rafael.antognolli@intel.com>
References: <1461366732-31779-1-git-send-email-rafael.antognolli@intel.com>
Message-ID: <1461366732-31779-3-git-send-email-rafael.antognolli@intel.com>

Two ioctls are added to the NVMe namespace: NVME_IOCTL_SAVE_OPAL_KEY and
NVME_IOCTL_UNLOCK_OPAL. These ioctls map directly to the respective
nvme_opal_register() and nvme_opal_unlock() functions.

Additionally, nvme_opal_unlock() is called upon nvme_revalidate_disk, so it
will try to unlock a locking range (if a password for it is saved) during PM
resume.

Signed-off-by: Rafael Antognolli <rafael.antognolli at intel.com>
---
 drivers/nvme/host/core.c        | 9 +++++++++
 include/uapi/linux/nvme_ioctl.h | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 643f457..1f4b78c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -30,6 +30,7 @@
 #include <asm/unaligned.h>
 
 #include "nvme.h"
+#include "opal.h"
 
 #define NVME_MINORS		(1U << MINORBITS)
 
@@ -517,6 +518,10 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	case SG_IO:
 		return nvme_sg_io(ns, (void __user *)arg);
 #endif
+	case NVME_IOCTL_SAVE_OPAL_KEY:
+		return nvme_opal_register(ns, (void __user *)arg);
+	case NVME_IOCTL_UNLOCK_OPAL:
+		return nvme_opal_unlock(ns);
 	default:
 		return -ENOTTY;
 	}
@@ -675,6 +680,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
 	blk_mq_unfreeze_queue(disk->queue);
+	nvme_opal_unlock(ns);
 
 	kfree(id);
 	return 0;
@@ -1596,6 +1602,8 @@ int __init nvme_core_init(void)
 		goto unregister_chrdev;
 	}
 
+	nvme_opal_init();
+
 	return 0;
 
  unregister_chrdev:
@@ -1607,6 +1615,7 @@ int __init nvme_core_init(void)
 
 void nvme_core_exit(void)
 {
+	nvme_opal_exit();
 	unregister_blkdev(nvme_major, "nvme");
 	class_destroy(nvme_class);
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index c4b2a3f..8f8ab02 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -53,6 +53,11 @@ struct nvme_passthru_cmd {
 	__u32	result;
 };
 
+struct nvme_opal_key {
+	__u8	locking_range;
+	__u8	key[256];
+};
+
 #define nvme_admin_cmd nvme_passthru_cmd
 
 #define NVME_IOCTL_ID		_IO('N', 0x40)
@@ -61,5 +66,7 @@ struct nvme_passthru_cmd {
 #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
 #define NVME_IOCTL_RESET	_IO('N', 0x44)
 #define NVME_IOCTL_SUBSYS_RESET	_IO('N', 0x45)
+#define NVME_IOCTL_SAVE_OPAL_KEY _IOW('N', 0X46, struct nvme_opal_key)
+#define NVME_IOCTL_UNLOCK_OPAL  _IO('N', 0X47)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
1.9.1
