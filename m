From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 May 2018 11:09:54 +0200
Subject: [PATCHv2 01/11] nvme.h: untangle AEN notice definitions
In-Reply-To: <20180522091004.39620-1-hare@suse.de>
References: <20180522091004.39620-1-hare@suse.de>
Message-ID: <20180522091004.39620-2-hare@suse.de>

From: Christoph Hellwig <hch@lst.de>

Stop including the event type in the definitions for the notice type.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 30 ++++++++++++++++++------------
 include/linux/nvme.h     |  8 ++++++--
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79d49f16d991..fd71daa92d6a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3343,6 +3343,21 @@ static void nvme_fw_act_work(struct work_struct *work)
 	nvme_get_fw_slot_info(ctrl);
 }
 
+static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
+{
+	switch ((result & 0xff00) >> 8) {
+	case NVME_AER_NOTICE_NS_CHANGED:
+		dev_info(ctrl->device, "rescanning\n");
+		nvme_queue_scan(ctrl);
+		break;
+	case NVME_AER_NOTICE_FW_ACT_STARTING:
+		queue_work(nvme_wq, &ctrl->fw_act_work);
+		break;
+	default:
+		dev_warn(ctrl->device, "async event result %08x\n", result);
+	}
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res)
 {
@@ -3352,6 +3367,9 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		return;
 
 	switch (result & 0x7) {
+	case NVME_AER_NOTICE:
+		nvme_handle_aen_notice(ctrl, result);
+		break;
 	case NVME_AER_ERROR:
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
@@ -3361,18 +3379,6 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	default:
 		break;
 	}
-
-	switch (result & 0xff07) {
-	case NVME_AER_NOTICE_NS_CHANGED:
-		dev_info(ctrl->device, "rescanning\n");
-		nvme_queue_scan(ctrl);
-		break;
-	case NVME_AER_NOTICE_FW_ACT_STARTING:
-		queue_work(nvme_wq, &ctrl->fw_act_work);
-		break;
-	default:
-		dev_warn(ctrl->device, "async event result %08x\n", result);
-	}
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 4112e2bd747f..c37103a4ad38 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -436,10 +436,14 @@ enum {
 enum {
 	NVME_AER_ERROR			= 0,
 	NVME_AER_SMART			= 1,
+	NVME_AER_NOTICE			= 2,
 	NVME_AER_CSS			= 6,
 	NVME_AER_VS			= 7,
-	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
-	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
+};
+
+enum {
+	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
+	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
 };
 
 struct nvme_lba_range_type {
-- 
2.12.3
