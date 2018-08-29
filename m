From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 28 Aug 2018 21:37:20 -0700
Subject: [PATCH] nvme-core: add async event trace helper
Message-ID: <20180829043720.8545-1-chaitanya.kulkarni@wdc.com>

This patch adds a new event for nvme async event notification.
We print the async event in the decoded format when we recognize the
event otherwise we just dump the result.

This tracing event is needed to observe/log the different NVMe
Asynchronous Event from different types of controllers NVMe PCIe or
NVMeOF.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c  |  5 +++++
 drivers/nvme/host/trace.h | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd8ec1dd9219..92ec8f946ec7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3413,14 +3413,17 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
 	switch ((result & 0xff00) >> 8) {
 	case NVME_AER_NOTICE_NS_CHANGED:
+		trace_nvme_async_event(ctrl, NVME_AER_NOTICE_NS_CHANGED);
 		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
+		trace_nvme_async_event(ctrl, NVME_AER_NOTICE_FW_ACT_STARTING);
 		queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
 #ifdef CONFIG_NVME_MULTIPATH
 	case NVME_AER_NOTICE_ANA:
+		trace_nvme_async_event(ctrl, NVME_AER_NOTICE_ANA);
 		if (!ctrl->ana_log_buf)
 			break;
 		queue_work(nvme_wq, &ctrl->ana_work);
@@ -3447,9 +3450,11 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
+		trace_nvme_async_event(ctrl, result & 0x7);
 		ctrl->aen_result = result;
 		break;
 	default:
+		trace_nvme_async_event(ctrl, result);
 		break;
 	}
 	queue_work(nvme_wq, &ctrl->async_event_work);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index a490790d6691..4db3b71db801 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -156,6 +156,22 @@ TRACE_EVENT(nvme_complete_rq,
 
 );
 
+TRACE_EVENT(nvme_async_event,
+		TP_PROTO(struct nvme_ctrl *ctrl, u32 result),
+		TP_ARGS(ctrl, result),
+		TP_STRUCT__entry(
+			__field(int, ctrl_id)
+			__field(u32, result)
+			),
+		TP_fast_assign(
+			__entry->ctrl_id = ctrl->instance;
+			__entry->result = result;
+			),
+		TP_printk("nvme%d: NVME_AEN=%#08x",
+			__entry->ctrl_id, __entry->result)
+
+	   );
+
 #endif /* _TRACE_NVME_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.17.0
