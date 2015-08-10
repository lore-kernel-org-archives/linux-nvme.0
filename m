From: keith.busch@intel.com (Keith Busch)
Date: Mon, 10 Aug 2015 15:20:41 -0600
Subject: [RESEND PATCH 2/2] NVMe: Add nvme subsystem reset IOCTL
In-Reply-To: <1439241641-3444-1-git-send-email-keith.busch@intel.com>
References: <1439241641-3444-1-git-send-email-keith.busch@intel.com>
Message-ID: <1439241641-3444-2-git-send-email-keith.busch@intel.com>

From: Jon Derrick <jonathan.derrick@intel.com>

Controllers can perform optional subsystem resets as introduced in NVMe
1.1. This patch adds an IOCTL to trigger the subsystem reset by writing
"NVMe" to the NSSR register.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
Acked-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   11 +++++++++++
 include/linux/nvme.h      |    2 +-
 include/uapi/linux/nvme.h |    1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 4e19c8a..613c1bc 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1862,6 +1862,15 @@ static int nvme_user_cmd(struct nvme_dev *dev, struct nvme_ns *ns,
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
@@ -2829,6 +2838,8 @@ static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	case NVME_IOCTL_RESET:
 		dev_warn(dev->dev, "resetting controller\n");
 		return nvme_reset(dev);
+	case NVME_IOCTL_SUBSYS_RESET:
+		return nvme_subsys_reset(dev);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index a566b41..4d08354 100644
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
index 732b32e..8864194 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -584,5 +584,6 @@ struct nvme_passthru_cmd {
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
 #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
 #define NVME_IOCTL_RESET	_IO('N', 0x44)
+#define NVME_IOCTL_SUBSYS_RESET	_IO('N', 0x45)
 
 #endif /* _UAPI_LINUX_NVME_H */
-- 
1.7.10.4
