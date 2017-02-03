From: scott.bauer@intel.com (Scott Bauer)
Date: Fri,  3 Feb 2017 12:50:32 -0700
Subject: [PATCH v6 3/3] nvme: Add Support for Opal: Unlock from S3 & Opal
 Allocation/Ioctls
In-Reply-To: <1486151432-3431-1-git-send-email-scott.bauer@intel.com>
References: <1486151432-3431-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1486151432-3431-4-git-send-email-scott.bauer@intel.com>

This patch implements the necessary logic to unlock an Opal
enabled device coming back from an S3.

The patch also implements the SED/Opal allocation necessary to support
the opal ioctls.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 drivers/nvme/host/core.c | 25 +++++++++++++++++++++++++
 drivers/nvme/host/nvme.h | 14 ++++++++++++++
 drivers/nvme/host/pci.c  |  7 +++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f7a602c..efe8ec3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -798,6 +798,8 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		if (ns->ndev)
 			return nvme_nvm_ioctl(ns, cmd, arg);
 #endif
+		if (is_sed_ioctl(cmd))
+			return sed_ioctl(&ns->ctrl->opal_dev, cmd, arg);
 		return -ENOTTY;
 	}
 }
@@ -1065,6 +1067,29 @@ static const struct pr_ops nvme_pr_ops = {
 	.pr_clear	= nvme_pr_clear,
 };
 
+#ifdef CONFIG_BLK_SED_OPAL
+int nvme_sec_submit(struct opal_dev *dev, u16 spsp, u8 secp,
+		    void *buffer, size_t len, bool send)
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
+EXPORT_SYMBOL_GPL(nvme_sec_submit);
+#endif /* CONFIG_BLK_SED_OPAL */
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 61b8170..569cba1 100644
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
@@ -267,6 +270,17 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
+#ifdef CONFIG_BLK_SED_OPAL
+int nvme_sec_submit(struct opal_dev *dev, u16 spsp, u8 secp,
+		    void *buffer, size_t len, bool send);
+#else
+static inline int nvme_sec_submit(struct opal_dev *dev, u16 spsp, u8 secp,
+				  void *buffer, size_t len, bool send)
+{
+	return 0;
+}
+#endif /* CONFIG_BLK_DEV_SED_OPAL */
+
 #define NVME_NR_AERS	1
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 032237c..e25d632 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -43,6 +43,7 @@
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/unaligned.h>
+#include <linux/sed-opal.h>
 
 #include "nvme.h"
 
@@ -1754,6 +1755,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
+	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
 
 	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
@@ -1786,6 +1788,11 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	init_opal_dev(&dev->ctrl.opal_dev, &nvme_sec_submit);
+
+	if (was_suspend)
+		opal_unlock_from_suspend(&dev->ctrl.opal_dev);
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
-- 
2.7.4
