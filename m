From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 29 Dec 2016 12:26:54 -0700
Subject: [PATCH v4 5/6] nvme: Add Support for Opal: Unlock from S3 & Opal
 Allocation/Ioctls
In-Reply-To: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1483039615-22407-6-git-send-email-scott.bauer@intel.com>

This patch implements the necessary logic to unlock an Opal
enabled device coming back from an S3.

The patch also implements the SED/Opal allocation necessary to support
the opal ioctls.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 drivers/nvme/host/Kconfig |  7 +++++
 drivers/nvme/host/core.c  | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h  |  9 +++++-
 drivers/nvme/host/pci.c   |  4 +++
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 90745a6..f492b00 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -25,6 +25,13 @@ config BLK_DEV_NVME_SCSI
 	  emulation to provide stable device names for mount by id, like
 	  some OpenSuSE and SLES versions.
 
+config BLK_DEV_SED_OPAL
+       bool "Enable support for Opal Enabled NVMe Device"
+       depends on BLK_SED_OPAL
+       default n
+       ---help---
+       This enables support for an Opal enabled NVMe device.
+
 config NVME_FABRICS
 	tristate
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b40cfb0..3a8ea98 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -28,6 +28,8 @@
 #include <linux/t10-pi.h>
 #include <scsi/sg.h>
 #include <asm/unaligned.h>
+#include <linux/sed.h>
+#include <linux/sed-opal.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -762,6 +764,27 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return status;
 }
 
+#ifdef CONFIG_BLK_DEV_SED_OPAL
+static int nvme_sec_submit(struct sed_context *ctx, u16 spsp, u8 secp,
+			   void *buffer, size_t len, bool send)
+{
+	struct nvme_command cmd = { 0 };
+	struct nvme_ns *ns = NULL;
+
+	if (send)
+		cmd.common.opcode = nvme_admin_security_send;
+	else
+		cmd.common.opcode = nvme_admin_security_recv;
+	ns = container_of(ctx, struct nvme_ns, sed_ctx);
+	cmd.common.nsid = cpu_to_le32(ns->ns_id);
+	cmd.common.cdw10[0] = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
+	cmd.common.cdw10[1] = cpu_to_le32(len);
+
+	return __nvme_submit_sync_cmd(ns->ctrl->admin_q, &cmd, NULL, buffer, len,
+				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0);
+}
+#endif
+
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
@@ -784,6 +807,11 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		return nvme_sg_io(ns, (void __user *)arg);
 #endif
 	default:
+#ifdef CONFIG_BLK_DEV_SED_OPAL
+		if (is_sed_ioctl(cmd))
+			return sed_ioctl(&ns->sed_ctx, cmd, arg);
+
+#endif
 		return -ENOTTY;
 	}
 }
@@ -1051,6 +1079,51 @@ static const struct pr_ops nvme_pr_ops = {
 	.pr_clear	= nvme_pr_clear,
 };
 
+static int nvme_opal_initialize(struct nvme_ns *ns)
+{
+
+#ifdef CONFIG_BLK_DEV_SED_OPAL
+	/* Opal dev has already been allocated for this controller */
+	if (ns->sed_ctx.dev)
+		return 0;
+
+	ns->sed_ctx.dev = alloc_opal_dev(ns->ctrl->admin_q);
+	if (!ns->sed_ctx.dev)
+		return -ENOMEM;
+	ns->sed_ctx.send_recv = &nvme_sec_submit;
+
+	/* In the future when we have to determine whether or not we're in
+	 * Multi-LR Mult-NS mode or Single-LR Multi-NS mode we'll
+	 * pass pointers into is_opal_supported
+	 */
+	if (is_opal_supported(&ns->sed_ctx, NULL, NULL) != 1) {
+		dev_warn(ns->ctrl->device, "Opal is not supported\n");
+		kfree(ns->sed_ctx.dev);
+		ns->sed_ctx.dev = NULL;
+	}
+	return 0;
+#else
+	return 0;
+#endif
+}
+
+
+void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl)
+{
+#ifdef CONFIG_BLK_DEV_SED_OPAL
+	struct nvme_ns *ns, *next;
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
+		if (!ns->sed_ctx.supported)
+			continue;
+		if (opal_unlock_from_suspend(&ns->sed_ctx))
+			dev_warn(ctrl->dev, "Failed to unlock one or more locking ranges!\n");
+	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+#endif
+}
+EXPORT_SYMBOL_GPL(nvme_unlock_from_suspend);
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
@@ -1673,6 +1746,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		goto out_free_id;
 	}
 
+	if (nvme_opal_initialize(ns)) {
+		dev_warn(ctrl->dev, "%s Couldn't allocate an Opal structure!\n",
+			 __func__);
+		goto out_free_id;
+	}
 	disk = alloc_disk_node(0, node);
 	if (!disk)
 		goto out_free_id;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bd53214..1f18c53 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -19,6 +19,7 @@
 #include <linux/kref.h>
 #include <linux/blk-mq.h>
 #include <linux/lightnvm.h>
+#include <linux/sed.h>
 
 enum {
 	/*
@@ -188,6 +189,10 @@ struct nvme_ns {
 
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
+
+#ifdef CONFIG_BLK_SED_OPAL
+	struct sed_context sed_ctx;
+#endif
 };
 
 struct nvme_ctrl_ops {
@@ -256,7 +261,8 @@ static inline int nvme_error_status(u16 status)
 
 static inline bool nvme_req_needs_retry(struct request *req, u16 status)
 {
-	return !(status & NVME_SC_DNR || blk_noretry_request(req)) &&
+	return !(status & NVME_SC_DNR || status & NVME_SC_ACCESS_DENIED ||
+		 blk_noretry_request(req)) &&
 		(jiffies - req->start_time) < req->timeout &&
 		req->retries < nvme_max_retries;
 }
@@ -275,6 +281,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
+void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl);
 
 #define NVME_NR_AERS	1
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3d21a15..dbf7818 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1764,6 +1764,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
+	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
 
 	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
@@ -1796,6 +1797,9 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	if (was_suspend)
+		nvme_unlock_from_suspend(&dev->ctrl);
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
-- 
2.7.4
