From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed,  6 Feb 2019 16:13:12 -0800
Subject: [PATCH] nvme-core: Share code between nvme_wait_ready() and
 nvme_shutdown_ctrl()
Message-ID: <20190207001312.13672-1-andrew.smirnov@gmail.com>

Code polling NVME_CSTS_SHST_CMPLT in nvme_shutdown_ctrl() is very
similar to polling loop in nvme_wait_ready(). Move shared polling loop
code into __nvme_wait_ready() and re-implement both
nvme_shutdown_ctrl() and nvme_wait_ready() on top of it to avoid code
repetition.

Signed-off-by: Andrey Smirnov <andrew.smirnov at gmail.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: linux-nvme at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/nvme/host/core.c | 54 ++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b47c59f0cbd8..633fbc21425c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1797,28 +1797,41 @@ const struct block_device_operations nvme_ns_head_ops = {
 };
 #endif /* CONFIG_NVME_MULTIPATH */
 
-static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
+static int __nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 value,
+			     unsigned long timeout)
 {
-	unsigned long timeout =
-		((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
-	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
+	u32 csts;
 	int ret;
 
 	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
 		if (csts == ~0)
 			return -ENODEV;
-		if ((csts & NVME_CSTS_RDY) == bit)
+		if ((csts & mask) == value)
 			break;
 
 		msleep(100);
 		if (fatal_signal_pending(current))
 			return -EINTR;
-		if (time_after(jiffies, timeout)) {
-			dev_err(ctrl->device,
-				"Device not ready; aborting %s\n", enabled ?
-						"initialisation" : "reset");
-			return -ENODEV;
-		}
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+	}
+
+	return ret;
+}
+
+static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
+{
+	unsigned long timeout =
+		((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+	u32 bit = enabled ? NVME_CSTS_RDY : 0;
+	int ret;
+
+	ret = __nvme_wait_ready(ctrl, NVME_CSTS_RDY, bit, timeout);
+	if (ret == -ETIMEDOUT) {
+		dev_err(ctrl->device,
+			"Device not ready; aborting %s\n", enabled ?
+			"initialisation" : "reset");
+		ret = -ENODEV;
 	}
 
 	return ret;
@@ -1883,7 +1896,6 @@ EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 {
 	unsigned long timeout = jiffies + (ctrl->shutdown_timeout * HZ);
-	u32 csts;
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
@@ -1893,18 +1905,12 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
-		if ((csts & NVME_CSTS_SHST_MASK) == NVME_CSTS_SHST_CMPLT)
-			break;
-
-		msleep(100);
-		if (fatal_signal_pending(current))
-			return -EINTR;
-		if (time_after(jiffies, timeout)) {
-			dev_err(ctrl->device,
-				"Device shutdown incomplete; abort shutdown\n");
-			return -ENODEV;
-		}
+	ret = __nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
+				NVME_CSTS_SHST_CMPLT, timeout);
+	if (ret == -ETIMEDOUT) {
+		dev_err(ctrl->device,
+			"Device shutdown incomplete; abort shutdown\n");
+		ret = -ENODEV;
 	}
 
 	return ret;
-- 
2.20.1
