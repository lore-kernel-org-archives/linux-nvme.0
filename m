From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 19 Dec 2016 12:35:48 -0700
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED Allocation
 code.
In-Reply-To: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1482176149-2257-5-git-send-email-scott.bauer@intel.com>

This patch implements the necessary logic to unlock a SED
enabled device coming back from an S3.

The patch also implements the necessary logic to allocate the
appropriate opal_dev structures to support the OPAL protocol.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
---
 drivers/nvme/host/core.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  8 +++++-
 drivers/nvme/host/pci.c  | 10 +++++++-
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b40cfb0..f9731ce 100644
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
@@ -762,6 +764,48 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return status;
 }
 
+static int nvme_sec_submit(struct nvme_ctrl *ctrl, u16 spsp, u8 secp,
+			   void *buffer, size_t len, u8 opcode)
+{
+	struct nvme_command cmd = { 0 };
+	struct nvme_ns *ns = NULL;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	if (!list_empty(&ctrl->namespaces))
+		ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
+
+	mutex_unlock(&ctrl->namespaces_mutex);
+	if (!ns)
+		return -ENODEV;
+
+	cmd.common.opcode = opcode;
+	cmd.common.nsid = ns->ns_id;
+	cmd.common.cdw10[0] = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
+	cmd.common.cdw10[1] = cpu_to_le32(len);
+
+	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
+				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0);
+}
+
+static int nvme_sec_send(void *ctrl_data, u16 spsp, u8 secp,
+			 void *buf, size_t len)
+{
+	return nvme_sec_submit(ctrl_data, spsp, secp, buf, len,
+			       nvme_admin_security_send);
+}
+
+static int nvme_sec_recv(void *ctrl_data, u16 spsp, u8 secp,
+			 void *buf, size_t len)
+{
+	return nvme_sec_submit(ctrl_data, spsp, secp, buf, len,
+			       nvme_admin_security_recv);
+}
+
+static const struct sec_ops nvme_sec_ops = {
+	.sec_send = nvme_sec_send,
+	.sec_recv = nvme_sec_recv,
+};
+
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
@@ -1051,6 +1095,28 @@ static const struct pr_ops nvme_pr_ops = {
 	.pr_clear	= nvme_pr_clear,
 };
 
+int nvme_opal_initialize(struct nvme_ctrl *ctrl)
+{
+	/* Opal dev has already been allocated for this controller */
+	if (ctrl->sed_ctx.dev)
+		return 0;
+
+	ctrl->sed_ctx.dev = alloc_opal_dev(ctrl->admin_q);
+	if (!ctrl->sed_ctx.dev)
+		return -ENOMEM;
+	ctrl->sed_ctx.ops = &nvme_sec_ops;
+	ctrl->sed_ctx.sec_data = ctrl;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_opal_initialize);
+
+void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl)
+{
+	if (opal_unlock_from_suspend(&ctrl->sed_ctx))
+		pr_warn("Failed to unlock one or more locking ranges!\n");
+}
+EXPORT_SYMBOL_GPL(nvme_unlock_from_suspend);
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
@@ -1312,6 +1378,7 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 		if (!kref_get_unless_zero(&ctrl->kref))
 			break;
 		file->private_data = ctrl;
+		file->f_sedctx = &ctrl->sed_ctx;
 		ret = 0;
 		break;
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bd53214..851830b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -19,6 +19,7 @@
 #include <linux/kref.h>
 #include <linux/blk-mq.h>
 #include <linux/lightnvm.h>
+#include <linux/sed.h>
 
 enum {
 	/*
@@ -151,6 +152,8 @@ struct nvme_ctrl {
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 
+	struct sed_context sed_ctx;
+
 	/* Fabrics only */
 	u16 sqsize;
 	u32 ioccsz;
@@ -256,7 +259,8 @@ static inline int nvme_error_status(u16 status)
 
 static inline bool nvme_req_needs_retry(struct request *req, u16 status)
 {
-	return !(status & NVME_SC_DNR || blk_noretry_request(req)) &&
+	return !(status & NVME_SC_DNR || status & NVME_SC_ACCESS_DENIED ||
+		 blk_noretry_request(req)) &&
 		(jiffies - req->start_time) < req->timeout &&
 		req->retries < nvme_max_retries;
 }
@@ -275,6 +279,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
+void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl);
+int nvme_opal_initialize(struct nvme_ctrl *ctrl);
 
 #define NVME_NR_AERS	1
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2fd7dc2..d298c15 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -43,6 +43,7 @@
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/unaligned.h>
+#include <linux/sed-opal.h>
 
 #include "nvme.h"
 
@@ -1765,7 +1766,7 @@ static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
 	int result = -ENODEV;
-
+	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
 		goto out;
 
@@ -1796,6 +1797,13 @@ static void nvme_reset_work(struct work_struct *work)
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
