From: a.dawn@samsung.com (Arnav Dawn)
Date: Fri, 07 Jul 2017 17:12:47 +0530
Subject: [PATCH v4 1/1] nvme: Add support for FW activation without reset
In-Reply-To: <1499427704-15785-1-git-send-email-a.dawn@samsung.com>
References: <1499427704-15785-1-git-send-email-a.dawn@samsung.com>
 <CGME20170707114212epcas5p20d9752501fcfb6a06c460c25a593b0e6@epcas5p2.samsung.com>
Message-ID: <1499427767-15891-1-git-send-email-a.dawn@samsung.com>

This patch adds support for handling Fw activation without reset
On completion of FW-activation-starting AER, all queues are
paused till CSTS.PP is cleared or timed out (exceeds max time for
fw activtion MTFA). If device fails to clear CSTS.PP within MTFA,
driver issues reset controller

Signed-off-by: Arnav Dawn <a.dawn at samsung.com>
---
 drivers/nvme/host/core.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h | 21 +++++++++++++++
 include/linux/nvme.h     | 10 +++++++
 3 files changed, 100 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d70df1d..b31c1a7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1809,6 +1809,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	nvme_set_queue_limits(ctrl, ctrl->admin_q);
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
+	ctrl->mtfa = le16_to_cpu(id->mtfa);
 
 	ctrl->npss = id->npss;
 	ctrl->apsta = id->apsta;
@@ -2523,6 +2524,64 @@ static void nvme_async_event_work(struct work_struct *work)
 	spin_unlock_irq(&ctrl->lock);
 }
 
+static int nvme_get_fw_slot_info(struct nvme_ctrl *dev,
+				struct nvme_fw_slot_info_log *log)
+{
+	struct nvme_command c = { };
+
+	c.common.opcode = nvme_admin_get_log_page;
+	c.common.nsid = cpu_to_le32(0xFFFFFFFF);
+	c.common.cdw10[0] = cpu_to_le32(
+		(((sizeof(struct nvme_fw_slot_info_log) / 4) - 1) << 16)
+		| NVME_LOG_FW_SLOT);
+
+	if (!log)
+		return -ENOMEM;
+
+	return nvme_submit_sync_cmd(dev->admin_q, &c, log,
+			sizeof(struct nvme_fw_slot_info_log));
+}
+
+static void nvme_fw_act_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+				struct nvme_ctrl, fw_act_work);
+	struct nvme_fw_slot_info_log *log;
+	unsigned long fw_act_timeout;
+
+	if (ctrl->mtfa)
+		fw_act_timeout = jiffies +
+				msecs_to_jiffies(ctrl->mtfa * 100);
+	else
+		fw_act_timeout = jiffies +
+				msecs_to_jiffies(admin_timeout * 1000);
+
+	nvme_stop_queues(ctrl);
+	while (nvme_ctrl_pp_status(ctrl)) {
+		if (time_after(jiffies, fw_act_timeout)) {
+			dev_warn(ctrl->device,
+				"Fw activation timeout, reset controller\n");
+			nvme_reset_ctrl(ctrl);
+			break;
+		}
+		msleep(100);
+	}
+
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return;
+
+	nvme_start_queues(ctrl);
+	/* read FW slot informationi to clear the AER*/
+	log = kmalloc(sizeof(struct nvme_fw_slot_info_log), GFP_KERNEL);
+	if (!log)
+		return;
+
+	if (nvme_get_fw_slot_info(ctrl, log))
+		dev_warn(ctrl->device,
+				"Get FW SLOT INFO log error\n");
+	kfree(log);
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res)
 {
@@ -2549,6 +2608,14 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		dev_info(ctrl->device, "rescanning\n");
 		nvme_queue_scan(ctrl);
 		break;
+	case NVME_AER_NOTICE_FW_ACT_STARTING:
+		schedule_delayed_work(&ctrl->fw_act_work,
+					msecs_to_jiffies(100));
+		break;
+	case NVME_AER_ERR_FW_IMG_LOAD:
+		dev_warn(ctrl->device, "FW image load error\n");
+		cancel_delayed_work(&ctrl->fw_act_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -2595,6 +2662,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
+	cancel_delayed_work_sync(&ctrl->fw_act_work);
 	nvme_remove_namespaces(ctrl);
 
 	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
@@ -2642,6 +2710,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
+	INIT_DELAYED_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 
 	ret = nvme_set_instance(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d70ff0f..580a660 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -142,6 +142,7 @@ struct nvme_ctrl {
 	u16 cntlid;
 
 	u32 ctrl_config;
+	u16 mtfa;
 
 	u32 page_size;
 	u32 max_hw_sectors;
@@ -165,6 +166,7 @@ struct nvme_ctrl {
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
+	struct delayed_work fw_act_work;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
@@ -238,6 +240,25 @@ static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
 	return val & NVME_CSTS_RDY;
 }
 
+static inline bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
+{
+
+	u32 csts;
+
+	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
+		return false;
+
+	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
+				&ctrl->ctrl_config))
+		return false;
+
+	if (csts == ~0)
+		return false;
+
+	return  ((ctrl->ctrl_config & NVME_CC_ENABLE)
+			&& (csts & NVME_CSTS_PP));
+}
+
 static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
 	if (!ctrl->subsystem)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6b8ee9e..5ad58f6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -146,6 +146,7 @@ enum {
 	NVME_CSTS_RDY		= 1 << 0,
 	NVME_CSTS_CFS		= 1 << 1,
 	NVME_CSTS_NSSRO		= 1 << 4,
+	NVME_CSTS_PP		= 1 << 5,
 	NVME_CSTS_SHST_NORMAL	= 0 << 2,
 	NVME_CSTS_SHST_OCCUR	= 1 << 2,
 	NVME_CSTS_SHST_CMPLT	= 2 << 2,
@@ -376,6 +377,13 @@ struct nvme_smart_log {
 	__u8			rsvd216[296];
 };
 
+struct nvme_fw_slot_info_log {
+	__u8			afi;
+	__u8			rsvd1[7];
+	__le64			frs[7];
+	__u8			rsvd64[448];
+};
+
 enum {
 	NVME_SMART_CRIT_SPARE		= 1 << 0,
 	NVME_SMART_CRIT_TEMPERATURE	= 1 << 1,
@@ -386,6 +394,8 @@ enum {
 
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
+	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
+	NVME_AER_ERR_FW_IMG_LOAD	= 0x0500,
 };
 
 struct nvme_lba_range_type {
-- 
1.9.1
