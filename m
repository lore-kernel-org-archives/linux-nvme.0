From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 29 May 2015 15:58:25 -0600
Subject: [PATCH] NVMe: Added IOCTL to initiate subsystem resets
Message-ID: <1432936705-30232-1-git-send-email-jonathan.derrick@intel.com>

Controllers can perform optional subsystem resets as introduced in NVMe
1.1. This patch adds an IOCTL to trigger the subsystem reset by writing
"NVMe" to the NSSR register.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
This patch is contigent on the subsystem reset detection patch:
http://lists.infradead.org/pipermail/linux-nvme/2015-May/001779.html
 drivers/block/nvme-core.c | 11 +++++++++++
 include/linux/nvme.h      |  2 +-
 include/uapi/linux/nvme.h |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 0cf18c2..039e1ea 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1846,6 +1846,15 @@ static int nvme_user_cmd(struct nvme_dev *dev, struct nvme_ns *ns,
 	return status;
 }
 
+static int nvme_subsys_reset(struct nvme_dev *dev)
+{
+	if (!dev->subsystem)
+		return -ENOTTY;
+
+	writel(0x4E564D65, &dev->bar->nssr); /* "NVMe" */
+	return 0;
+}
+
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 							unsigned long arg)
 {
@@ -1861,6 +1870,8 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 		return nvme_user_cmd(ns->dev, ns, (void __user *)arg);
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, (void __user *)arg);
+	case NVME_IOCTL_SUBSYS_RESET:
+		return nvme_subsys_reset(ns->dev);
 	case SG_GET_VERSION_NUM:
 		return nvme_sg_get_version_num((void __user *)arg);
 	case SG_IO:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 977b0b3..35f0ece 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -28,7 +28,7 @@ struct nvme_bar {
 	__u32			cc;	/* Controller Configuration */
 	__u32			rsvd1;	/* Reserved */
 	__u32			csts;	/* Controller Status */
-	__u32			rsvd2;	/* Reserved */
+	__u32			nssr;	/* Subsystem Reset */
 	__u32			aqa;	/* Admin Queue Attributes */
 	__u64			asq;	/* Admin SQ Base Address */
 	__u64			acq;	/* Admin CQ Base Address */
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index aef9a81..7d2907d 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -579,5 +579,6 @@ struct nvme_passthru_cmd {
 #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
 #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
+#define NVME_IOCTL_SUBSYS_RESET	_IO('N', 0x44)
 
 #endif /* _UAPI_LINUX_NVME_H */
-- 
2.1.4
