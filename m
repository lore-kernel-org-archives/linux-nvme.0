From: a.dawn@samsung.com (Arnav Dawn)
Date: Tue, 11 Jul 2017 19:18:32 +0530
Subject: [PATCH v5 1/1] nvme: Add support for FW activation without reset
In-Reply-To: <1499780675-9869-1-git-send-email-a.dawn@samsung.com>
References: <1499780675-9869-1-git-send-email-a.dawn@samsung.com>
 <CGME20170711134755epcas1p1d699b8c70dab6fcde72ea92d03f76079@epcas1p1.samsung.com>
Message-ID: <1499780912-10253-1-git-send-email-a.dawn@samsung.com>

This patch adds support for handling Fw activation without reset
On completion of FW-activation-starting AER, all queues are
paused till CSTS.PP is cleared or timed out (exceeds max time for
fw activtion MTFA). If device fails to clear CSTS.PP within MTFA,
driver issues reset controller

Signed-off-by: Arnav Dawn <a.dawn at samsung.com>
---
 drivers/nvme/host/core.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 include/linux/nvme.h     |  9 ++++++
 3 files changed, 88 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb96f4a..b685021 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2523,6 +2523,78 @@ static void nvme_async_event_work(struct work_struct *work)
 	spin_unlock_irq(&ctrl->lock);
 }
 
+
+static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
+{
+
+	u32 csts;
+
+	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
+		return false;
+
+	if (csts == ~0)
+		return false;
+
+	return ((ctrl->ctrl_config & NVME_CC_ENABLE)
+			&& (csts & NVME_CSTS_PP));
+}
+
+static __le32 nvme_get_log_dw10(u8 lid, int size)
+{
+	return cpu_to_le32((((size / 4) - 1) << 16) | lid);
+}
+
+static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
+{
+	struct nvme_command c = { };
+	struct nvme_fw_slot_info_log *log;
+
+	log = kmalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return;
+
+	c.common.opcode = nvme_admin_get_log_page;
+	c.common.nsid = cpu_to_le32(0xFFFFFFFF);
+	c.common.cdw10[0] = nvme_get_log_dw10(NVME_LOG_FW_SLOT, sizeof(*log));
+
+	if (!nvme_submit_sync_cmd(ctrl->admin_q, &c, log, sizeof(*log)))
+		dev_warn(ctrl->device,
+				"Get FW SLOT INFO log error\n");
+	kfree(log);
+}
+
+static void nvme_fw_act_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(work,
+				struct nvme_ctrl, fw_act_work);
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
+	nvme_get_fw_slot_info(ctrl);
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res)
 {
@@ -2549,6 +2621,9 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		dev_info(ctrl->device, "rescanning\n");
 		nvme_queue_scan(ctrl);
 		break;
+	case NVME_AER_NOTICE_FW_ACT_STARTING:
+		schedule_work(&ctrl->fw_act_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -2596,6 +2671,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
+	cancel_work_sync(&ctrl->fw_act_work);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
 
@@ -2659,6 +2735,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
+	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 
 	ret = nvme_set_instance(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8f2a168..b40b9af 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -142,6 +142,7 @@ struct nvme_ctrl {
 	u16 cntlid;
 
 	u32 ctrl_config;
+	u16 mtfa;
 	u32 queue_count;
 
 	u64 cap;
@@ -167,6 +168,7 @@ struct nvme_ctrl {
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
+	struct work_struct fw_act_work;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6b8ee9e..220fa58 100644
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
@@ -386,6 +394,7 @@ enum {
 
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
+	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
 };
 
 struct nvme_lba_range_type {
-- 
1.9.1
