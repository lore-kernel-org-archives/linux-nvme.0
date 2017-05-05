From: a.dawn@samsung.com (Arnav dawn)
Date: Fri, 05 May 2017 17:11:55 +0530
Subject: [PATCH] nvme: Add support for FW activation without reset
References: <CGME20170505114235epcas1p37200fbb3f181c1c840ab3c46b95691f1@epcas1p3.samsung.com>
Message-ID: <3c020871fbee817c9a905cb69df7ade4f978c581.1493971901.git.a.dawn@samsung.com>

This patch adds support for AER handling to activate firmware
without controller reset.

Signed-off-by: Arnav Kumar Dawn <a.dawn at samsung.com>
---
 drivers/nvme/host/core.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  3 +++
 include/linux/nvme.h     |  3 +++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906..db7969d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1590,7 +1590,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	nvme_set_queue_limits(ctrl, ctrl->admin_q);
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
-
+	ctrl->mtfa = le16_to_cpu(id->mtfa);
 	ctrl->npss = id->npss;
 	prev_apsta = ctrl->apsta;
 	if (ctrl->quirks & NVME_QUIRK_NO_APST) {
@@ -2260,6 +2260,36 @@ static void nvme_async_event_work(struct work_struct *work)
 	spin_unlock_irq(&ctrl->lock);
 }
 
+static void nvme_fw_act_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, fw_act_work);
+	u32 csts, ret;
+
+	while (1) {
+		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts);
+		if (ret)
+			return;
+
+		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
+					&ctrl->ctrl_config);
+		if (ret)
+			return;
+
+		if ((ctrl->ctrl_config & NVME_CC_ENABLE)
+				&& !(csts & NVME_CSTS_PP)) {
+			ctrl->lfu_timeout = 0;
+			return;
+		}
+		if (time_after(jiffies, ctrl->lfu_timeout)) {
+			dev_warn(ctrl->device,
+				"Fw activation timeout, reset controller\n");
+			return;
+		}
+		msleep(100);
+	}
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res)
 {
@@ -2286,6 +2316,33 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		dev_info(ctrl->device, "rescanning\n");
 		nvme_queue_scan(ctrl);
 		break;
+	case NVME_AER_NOTICE_FW_ACT_STARTING:
+	{
+		u32 csts, ret;
+
+		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts);
+		if (ret)
+			return;
+
+		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
+					&ctrl->ctrl_config);
+		if (ret)
+			return;
+
+		if ((ctrl->ctrl_config & NVME_CC_ENABLE)
+				&& (csts & NVME_CSTS_PP)) {
+			ctrl->lfu_timeout =
+				jiffies + msecs_to_jiffies(ctrl->mtfa * 100);
+			schedule_work(&ctrl->fw_act_work);
+
+		}
+		break;
+	}
+	case NVME_AER_ERR_FW_IMG_LOAD:
+		dev_warn(ctrl->device, "FW image load error\n");
+		cancel_work_sync(&ctrl->fw_act_work);
+		ctrl->lfu_timeout = 0;
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -2332,6 +2389,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
+	flush_work(&ctrl->fw_act_work);
 	nvme_remove_namespaces(ctrl);
 
 	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
@@ -2379,6 +2437,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
+	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 
 	ret = nvme_set_instance(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 29c708c..abb7120 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -141,6 +141,8 @@ struct nvme_ctrl {
 	u16 cntlid;
 
 	u32 ctrl_config;
+	u16 mtfa;
+	unsigned long lfu_timeout;
 
 	u32 page_size;
 	u32 max_hw_sectors;
@@ -162,6 +164,7 @@ struct nvme_ctrl {
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
+	struct work_struct fw_act_work;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b625bac..1066b64 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -144,6 +144,7 @@ enum {
 	NVME_CSTS_RDY		= 1 << 0,
 	NVME_CSTS_CFS		= 1 << 1,
 	NVME_CSTS_NSSRO		= 1 << 4,
+	NVME_CSTS_PP		= 1 << 5,
 	NVME_CSTS_SHST_NORMAL	= 0 << 2,
 	NVME_CSTS_SHST_OCCUR	= 1 << 2,
 	NVME_CSTS_SHST_CMPLT	= 2 << 2,
@@ -347,6 +348,8 @@ enum {
 
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
+	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
+	NVME_AER_ERR_FW_IMG_LOAD	= 0x0500,
 };
 
 struct nvme_lba_range_type {
-- 
1.9.1
