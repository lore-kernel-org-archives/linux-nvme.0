From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 18:00:37 +0100
Subject: [PATCH 2/8] nvme: move enable/disable/shutdown_ctrl to common code
In-Reply-To: <1446915643-21175-1-git-send-email-hch@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
Message-ID: <1446915643-21175-3-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 87 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 +++
 drivers/nvme/host/pci.c  | 94 +++++-------------------------------------------
 3 files changed, 100 insertions(+), 85 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a63a71a..c061a6a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -14,6 +14,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/hdreg.h>
 #include <linux/kernel.h>
@@ -32,6 +33,10 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 
+static unsigned char shutdown_timeout = 5;
+module_param(shutdown_timeout, byte, 0644);
+MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
@@ -351,6 +356,88 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int count)
 	return min(result & 0xffff, result >> 16) + 1;
 }
 
+static int nvme_update_ctrl_config(struct nvme_ctrl *ctrl, u64 cap,
+		bool enabled)
+{
+	unsigned long timeout =
+		((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+	u32 bit = enabled ? NVME_CSTS_RDY : 0, csts;
+	int error;
+
+	error = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	if (error)
+		return error;
+
+	while (!(error = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))) {
+		if ((csts & NVME_CSTS_RDY) == bit)
+			break;
+
+		msleep(100);
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		if (time_after(jiffies, timeout)) {
+			dev_err(ctrl->dev,
+				"Controller not ready; aborting %s\n", enabled ?
+						"initialisation" : "reset");
+			return -ENODEV;
+		}
+	}
+
+	return error;
+}
+
+/*
+ * If the device has been passed off to us in an enabled state, just clear
+ * the enabled bit.  The spec says we should set the 'shutdown notification
+ * bits', but doing so may cause the device to complete commands to the
+ * admin queue ... and we don't know what memory that might be pointing at!
+ */
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
+{
+	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
+	ctrl->ctrl_config &= ~NVME_CC_ENABLE;
+
+	return nvme_update_ctrl_config(ctrl, cap, false);
+}
+
+int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
+{
+	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
+	ctrl->ctrl_config |= NVME_CC_ENABLE;
+
+	return nvme_update_ctrl_config(ctrl, cap, true);
+}
+
+int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
+{
+	unsigned long timeout = (shutdown_timeout * HZ) + jiffies;
+	u32 csts;
+	int error;
+
+	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
+	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
+
+	error = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	if (error)
+		return error;
+
+	while (!(error = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))) {
+		if ((csts & NVME_CSTS_SHST_MASK) != NVME_CSTS_SHST_CMPLT)
+			break;
+
+		msleep(100);
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		if (time_after(jiffies, timeout)) {
+			dev_err(ctrl->dev,
+				"Device shutdown incomplete; abort shutdown\n");
+			return -ENODEV;
+		}
+	}
+
+	return error;
+}
+
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
 	struct nvme_user_io io;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1692fda..426cafc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -52,6 +52,7 @@ struct nvme_ctrl {
 	char serial[20];
 	char model[40];
 	char firmware_rev[8];
+	u32 ctrl_config;
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u32 page_size;
@@ -228,6 +229,9 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 			dma_addr_t dma_addr, u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int count);
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
+int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
+int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
 
 extern spinlock_t dev_list_lock;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 89d2442..d50a2b7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -48,7 +48,6 @@
 #define NVME_NR_AEN_COMMANDS	1
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
-#define SHUTDOWN_TIMEOUT	(shutdown_timeout * HZ)
 
 unsigned char admin_timeout = 60;
 module_param(admin_timeout, byte, 0644);
@@ -58,10 +57,6 @@ unsigned char nvme_io_timeout = 30;
 module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 
-static unsigned char shutdown_timeout = 5;
-module_param(shutdown_timeout, byte, 0644);
-MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
-
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -105,7 +100,6 @@ struct nvme_dev {
 	unsigned max_qid;
 	int q_depth;
 	u32 db_stride;
-	u32 ctrl_config;
 	struct msix_entry *entry;
 	void __iomem *bar;
 	struct work_struct reset_work;
@@ -1192,77 +1186,6 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	return result;
 }
 
-static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
-{
-	unsigned long timeout;
-	u32 bit = enabled ? NVME_CSTS_RDY : 0;
-
-	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
-
-	while ((readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_RDY) != bit) {
-		msleep(100);
-		if (fatal_signal_pending(current))
-			return -EINTR;
-		if (time_after(jiffies, timeout)) {
-			dev_err(dev->dev,
-				"Device not ready; aborting %s\n", enabled ?
-						"initialisation" : "reset");
-			return -ENODEV;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * If the device has been passed off to us in an enabled state, just clear
- * the enabled bit.  The spec says we should set the 'shutdown notification
- * bits', but doing so may cause the device to complete commands to the
- * admin queue ... and we don't know what memory that might be pointing at!
- */
-static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
-{
-	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	dev->ctrl_config &= ~NVME_CC_ENABLE;
-	writel(dev->ctrl_config, dev->bar + NVME_REG_CC);
-
-	return nvme_wait_ready(dev, cap, false);
-}
-
-static int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
-{
-	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	dev->ctrl_config |= NVME_CC_ENABLE;
-	writel(dev->ctrl_config, dev->bar + NVME_REG_CC);
-
-	return nvme_wait_ready(dev, cap, true);
-}
-
-static int nvme_shutdown_ctrl(struct nvme_dev *dev)
-{
-	unsigned long timeout;
-
-	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	dev->ctrl_config |= NVME_CC_SHN_NORMAL;
-
-	writel(dev->ctrl_config, dev->bar + NVME_REG_CC);
-
-	timeout = SHUTDOWN_TIMEOUT + jiffies;
-	while ((readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_SHST_MASK) !=
-							NVME_CSTS_SHST_CMPLT) {
-		msleep(100);
-		if (fatal_signal_pending(current))
-			return -EINTR;
-		if (time_after(jiffies, timeout)) {
-			dev_err(dev->dev,
-				"Device shutdown incomplete; abort shutdown\n");
-			return -ENODEV;
-		}
-	}
-
-	return 0;
-}
-
 static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_complete_rq,
@@ -1353,7 +1276,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	    (readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_NSSRO))
 		writel(NVME_CSTS_NSSRO, dev->bar + NVME_REG_CSTS);
 
-	result = nvme_disable_ctrl(dev, cap);
+	result = nvme_disable_ctrl(&dev->ctrl, cap);
 	if (result < 0)
 		return result;
 
@@ -1369,16 +1292,16 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 
 	dev->page_size = 1 << page_shift;
 
-	dev->ctrl_config = NVME_CC_CSS_NVM;
-	dev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
-	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
-	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
+	dev->ctrl.ctrl_config = NVME_CC_CSS_NVM;
+	dev->ctrl.ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
+	dev->ctrl.ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
+	dev->ctrl.ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 
 	writel(aqa, dev->bar + NVME_REG_AQA);
 	writeq(nvmeq->sq_dma_addr, dev->bar + NVME_REG_ASQ);
 	writeq(nvmeq->cq_dma_addr, dev->bar + NVME_REG_ACQ);
 
-	result = nvme_enable_ctrl(dev, cap);
+	result = nvme_enable_ctrl(&dev->ctrl, cap);
 	if (result)
 		goto free_nvmeq;
 
@@ -1764,7 +1687,8 @@ static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev *dev)
 			 * queues than admin tags.
 			 */
 			set_current_state(TASK_RUNNING);
-			nvme_disable_ctrl(dev, readq(dev->bar + NVME_REG_CAP));
+			nvme_disable_ctrl(&dev->ctrl,
+				readq(dev->bar + NVME_REG_CAP));
 			nvme_clear_queue(dev->queues[0]);
 			flush_kthread_worker(dq->worker);
 			nvme_disable_queue(dev, 0);
@@ -1977,7 +1901,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 		}
 	} else {
 		nvme_disable_io_queues(dev);
-		nvme_shutdown_ctrl(dev);
+		nvme_shutdown_ctrl(&dev->ctrl);
 		nvme_disable_queue(dev, 0);
 	}
 	nvme_dev_unmap(dev);
-- 
1.9.1
