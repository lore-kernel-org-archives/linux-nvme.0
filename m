From: zhangweiping@didichuxing.com (weiping zhang)
Date: Fri, 30 Jun 2017 01:26:24 +0800
Subject: [PATCH] nvme: add wrapper for nvme ctrl register r/w
Message-ID: <20170629172624.GA17319@localhost.didichuxing.com>

Simplify nvme ctrl register r/w code.

Signed-off-by: weiping zhang <zhangweiping at didichuxing.com>
---
 drivers/nvme/host/core.c | 14 +++++++-------
 drivers/nvme/host/nvme.h | 22 ++++++++++++++++++++--
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 903d581..f73fe65 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1205,7 +1205,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
 	int ret;
 
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
+	while ((ret = nvme_ctrl_reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
 		if (csts == ~0)
 			return -ENODEV;
 		if ((csts & NVME_CSTS_RDY) == bit)
@@ -1238,7 +1238,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config &= ~NVME_CC_ENABLE;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = nvme_ctrl_reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
 
@@ -1274,7 +1274,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = nvme_ctrl_reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
 	return nvme_wait_ready(ctrl, cap, true);
@@ -1290,11 +1290,11 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = nvme_ctrl_reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
 
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
+	while ((ret = nvme_ctrl_reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
 		if ((csts & NVME_CSTS_SHST_MASK) == NVME_CSTS_SHST_CMPLT)
 			break;
 
@@ -1541,13 +1541,13 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	u32 max_hw_sectors;
 	u8 prev_apsta;
 
-	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
+	ret = nvme_ctrl_reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
 	if (ret) {
 		dev_err(ctrl->device, "Reading VS failed (%d)\n", ret);
 		return ret;
 	}
 
-	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &cap);
+	ret = nvme_ctrl_reg_read64(ctrl, NVME_REG_CAP, &cap);
 	if (ret) {
 		dev_err(ctrl->device, "Reading CAP failed (%d)\n", ret);
 		return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9d6a070..c6b6ced 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -222,11 +222,29 @@ struct nvme_ctrl_ops {
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 };
 
+static inline int nvme_ctrl_reg_read32(struct nvme_ctrl *ctrl, u32 off,
+			u32 *val)
+{
+	return ctrl->ops->reg_read32(ctrl, off, val);
+}
+
+static inline int nvme_ctrl_reg_write32(struct nvme_ctrl *ctrl, u32 off,
+			u32 val)
+{
+	return ctrl->ops->reg_write32(ctrl, off, val);
+}
+
+static inline int nvme_ctrl_reg_read64(struct nvme_ctrl *ctrl, u32 off,
+			u64 *val)
+{
+	return ctrl->ops->reg_read64(ctrl, off, val);
+}
+
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
 {
 	u32 val = 0;
 
-	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &val))
+	if (nvme_ctrl_reg_read32(ctrl, NVME_REG_CSTS, &val))
 		return false;
 	return val & NVME_CSTS_RDY;
 }
@@ -235,7 +253,7 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
 	if (!ctrl->subsystem)
 		return -ENOTTY;
-	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
+	return nvme_ctrl_reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
 }
 
 static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
-- 
2.9.4
