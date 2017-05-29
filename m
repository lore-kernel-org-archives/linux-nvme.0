From: a.dawn@samsung.com (Arnav Dawn)
Date: Mon, 29 May 2017 19:48:18 +0530
Subject: [PATCH v2 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <1496067391-26143-1-git-send-email-a.dawn@samsung.com>
References: <1496067391-26143-1-git-send-email-a.dawn@samsung.com>
 <CGME20170529141807epcas1p259e2e9b04327285d18f2d62bb6ccbce1@epcas1p2.samsung.com>
Message-ID: <1496067498-26233-1-git-send-email-a.dawn@samsung.com>

This patch adds support for handling FW activation without reset.
On completion of FW-activation-starting AER, all queues are
paused till CSTS.PP is cleared or timed out (exceeds max time for
fw activtion MTFA). If device fails to clear CSTS.PP within MTFA,
driver issues reset controller.

Signed-off-by: Arnav Dawn <a.dawn at samsung.com>
---
 drivers/nvme/host/core.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  3 ++
 include/linux/nvme.h     |  3 ++
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 01d622e..4537346 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1610,7 +1610,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	nvme_set_queue_limits(ctrl, ctrl->admin_q);
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
-
+	ctrl->mtfa = le16_to_cpu(id->mtfa);
 	ctrl->npss = id->npss;
 	prev_apsta = ctrl->apsta;
 	if (ctrl->quirks & NVME_QUIRK_NO_APST) {
@@ -2279,6 +2279,45 @@ static void nvme_async_event_work(struct work_struct *work)
 	spin_unlock_irq(&ctrl->lock);
 }
 
+static void nvme_fw_act_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+				struct nvme_ctrl, fw_act_work);
+	struct nvme_fw_slot_info_log *log;
+	u32 csts;
+
+	nvme_stop_queues(ctrl);
+	while (1) {
+		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
+			break;
+
+		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
+				&ctrl->ctrl_config))
+			break;
+
+		if (csts == ~0 || ((ctrl->ctrl_config & NVME_CC_ENABLE)
+				&& !(csts & NVME_CSTS_PP)))
+			break;
+
+		if (time_after(jiffies, ctrl->fw_act_timeout)) {
+			dev_warn(ctrl->device,
+				"Fw activation timeout, reset controller\n");
+			ctrl->ops->reset_ctrl(ctrl);
+			break;
+		}
+		msleep(100);
+	}
+	nvme_start_queues(ctrl);
+	ctrl->fw_act_timeout = 0;
+	log =  kmalloc(sizeof(struct nvme_fw_slot_info_log), GFP_KERNEL);
+	if (!log)
+		return;
+	if (nvme_get_log_page(ctrl, NVME_LOG_FW_SLOT, log))
+		dev_warn(ctrl->device,
+				"Get FW SLOT INFO log error\n");
+	kfree(log);
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res)
 {
@@ -2305,6 +2344,34 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		dev_info(ctrl->device, "rescanning\n");
 		nvme_queue_scan(ctrl);
 		break;
+	case NVME_AER_NOTICE_FW_ACT_STARTING:
+	{
+		u32 csts;
+
+		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
+			return;
+		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
+					&ctrl->ctrl_config))
+			return;
+
+		if ((ctrl->ctrl_config & NVME_CC_ENABLE)
+					&& (csts & NVME_CSTS_PP)) {
+			if (ctrl->mtfa)
+				ctrl->fw_act_timeout = jiffies +
+					msecs_to_jiffies(ctrl->mtfa * 100);
+			else
+				ctrl->fw_act_timeout = jiffies +
+					msecs_to_jiffies(admin_timeout * 1000);
+
+			schedule_delayed_work(&ctrl->fw_act_work, 0);
+		}
+		break;
+	}
+	case NVME_AER_ERR_FW_IMG_LOAD:
+		dev_warn(ctrl->device, "FW image load error\n");
+		cancel_delayed_work(&ctrl->fw_act_work);
+		ctrl->fw_act_timeout = 0;
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -2351,6 +2418,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
+	cancel_delayed_work(&ctrl->fw_act_work);
 	nvme_remove_namespaces(ctrl);
 
 	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
@@ -2398,6 +2466,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
+	INIT_DELAYED_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 
 	ret = nvme_set_instance(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e78143a..082e4a2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -141,6 +141,8 @@ struct nvme_ctrl {
 	u16 cntlid;
 
 	u32 ctrl_config;
+	u16 mtfa;
+	unsigned long fw_act_timeout;
 
 	u32 page_size;
 	u32 max_hw_sectors;
@@ -162,6 +164,7 @@ struct nvme_ctrl {
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
+	struct delayed_work fw_act_work;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 282fc69..53b7e73 100644
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
@@ -354,6 +355,8 @@ enum {
 
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
+	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
+	NVME_AER_ERR_FW_IMG_LOAD	= 0x0500,
 };
 
 struct nvme_lba_range_type {
-- 
1.9.1
