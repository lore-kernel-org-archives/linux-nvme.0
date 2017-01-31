From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 31 Jan 2017 03:17:23 -0700
Subject: [PATCH v5 3/4] nvme: Add Support for Opal: Unlock from S3 & Opal
 Allocation/Ioctls
In-Reply-To: <1485857844-15130-1-git-send-email-scott.bauer@intel.com>
References: <1485857844-15130-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1485857844-15130-4-git-send-email-scott.bauer@intel.com>

This patch implements the necessary logic to unlock an Opal
enabled device coming back from an S3.

The patch also implements the SED/Opal allocation necessary to support
the opal ioctls.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 drivers/nvme/host/core.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h | 20 ++++++++++++++++++-
 drivers/nvme/host/pci.c  |  8 ++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8a3c3e3..d0ab750 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -28,6 +28,7 @@
 #include <linux/t10-pi.h>
 #include <scsi/sg.h>
 #include <asm/unaligned.h>
+#include <linux/sed-opal.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -784,6 +785,8 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		return nvme_sg_io(ns, (void __user *)arg);
 #endif
 	default:
+		if (is_sed_ioctl(cmd))
+			return sed_ioctl(&ns->ctrl->opal_dev, cmd, arg);
 		return -ENOTTY;
 	}
 }
@@ -1051,6 +1054,53 @@ static const struct pr_ops nvme_pr_ops = {
 	.pr_clear	= nvme_pr_clear,
 };
 
+#ifdef CONFIG_BLK_SED_OPAL
+static int nvme_sec_submit(struct opal_dev *dev, u16 spsp, u8 secp,
+			   void *buffer, size_t len, bool send)
+{
+	struct nvme_command cmd;
+	struct nvme_ctrl *ctrl = NULL;
+
+	memset(&cmd, 0, sizeof(cmd));
+	if (send)
+		cmd.common.opcode = nvme_admin_security_send;
+	else
+		cmd.common.opcode = nvme_admin_security_recv;
+	ctrl = container_of(dev, struct nvme_ctrl, opal_dev);
+	cmd.common.nsid = 0;
+	cmd.common.cdw10[0] = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
+	cmd.common.cdw10[1] = cpu_to_le32(len);
+
+	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
+				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0);
+}
+
+int nvme_opal_initialize(struct nvme_ctrl *ctrl)
+{
+	/* Opal dev has already been initialized for this controller */
+	if (ctrl->opal_dev.initialized)
+		return 0;
+	init_opal_dev(&ctrl->opal_dev, &nvme_sec_submit);
+
+	if (check_opal_support(&ctrl->opal_dev, NULL, NULL) < 0)
+		dev_warn(ctrl->device, "Opal is not supported\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_opal_initialize);
+
+void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl)
+{
+	if (!ctrl->opal_dev.supported)
+		return;
+	if (opal_unlock_from_suspend(&ctrl->opal_dev))
+		dev_warn(ctrl->dev, "Failed to unlock one or more locking ranges!\n");
+
+}
+EXPORT_SYMBOL_GPL(nvme_unlock_from_suspend);
+
+#endif /* CONFIG_BLK_SED_OPAL */
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index aead6d0..f6de604 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -19,6 +19,7 @@
 #include <linux/kref.h>
 #include <linux/blk-mq.h>
 #include <linux/lightnvm.h>
+#include <linux/sed-opal.h>
 
 enum {
 	/*
@@ -125,6 +126,8 @@ struct nvme_ctrl {
 	struct list_head node;
 	struct ida ns_ida;
 
+	struct opal_dev opal_dev;
+
 	char name[12];
 	char serial[20];
 	char model[40];
@@ -247,7 +250,8 @@ static inline int nvme_error_status(u16 status)
 
 static inline bool nvme_req_needs_retry(struct request *req, u16 status)
 {
-	return !(status & NVME_SC_DNR || blk_noretry_request(req)) &&
+	return !(status & NVME_SC_DNR || status & NVME_SC_ACCESS_DENIED ||
+		 blk_noretry_request(req)) &&
 		(jiffies - req->start_time) < req->timeout &&
 		req->retries < nvme_max_retries;
 }
@@ -267,6 +271,20 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
+#ifdef CONFIG_BLK_SED_OPAL
+void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl);
+int nvme_opal_initialize(struct nvme_ctrl *ctrl);
+#else
+static inline void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl)
+{
+	return;
+}
+static inline int nvme_opal_initialize(struct nvme_ctrl *ctrl)
+{
+	return 0;
+}
+#endif /* CONFIG_BLK_DEV_SED_OPAL */
+
 #define NVME_NR_AERS	1
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3faefab..f7cf9eb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1754,6 +1754,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
+	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
 
 	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
@@ -1786,6 +1787,13 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	result = nvme_opal_initialize(&dev->ctrl);
+	if (result)
+		goto out;
+
+	if (was_suspend)
+		nvme_unlock_from_suspend(&dev->ctrl);
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
-- 
2.7.4
