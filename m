From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 29 Aug 2018 15:19:22 -0700
Subject: [PATCH V2] nvme-core: add async event trace helper
Message-ID: <20180829221922.23539-1-chaitanya.kulkarni@wdc.com>

This patch adds a new event for nvme async event notification.
We print the async event in the decoded format when we recognize
the event otherwise we just dump the result.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Changes since V1:-
1. __stringify() all the known NVME_AER* status codes.

---
 drivers/nvme/host/core.c  | 24 ++++++++++++++++++++++++
 drivers/nvme/host/trace.h | 22 ++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd8ec1dd9219..80b5b0451e95 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3411,16 +3411,24 @@ static void nvme_fw_act_work(struct work_struct *work)
 
 static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
+	const char *str;
+
 	switch ((result & 0xff00) >> 8) {
 	case NVME_AER_NOTICE_NS_CHANGED:
+		str = __stringify(NVME_AER_NOTICE_NS_CHANGED);
+		trace_nvme_async_event(ctrl, (result & 0xff00) >> 8, str);
 		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
+		str = __stringify(NVME_AER_NOTICE_FW_ACT_STARTING);
+		trace_nvme_async_event(ctrl, (result & 0xff00) >> 8, str);
 		queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
 #ifdef CONFIG_NVME_MULTIPATH
 	case NVME_AER_NOTICE_ANA:
+		str = __stringify(NVME_AER_NOTICE_ANA)
+		trace_nvme_async_event(ctrl, (result & 0xff00) >> 8, str);
 		if (!ctrl->ana_log_buf)
 			break;
 		queue_work(nvme_wq, &ctrl->ana_work);
@@ -3434,6 +3442,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res)
 {
+	const char *str;
 	u32 result = le32_to_cpu(res->u32);
 
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
@@ -3444,12 +3453,27 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		nvme_handle_aen_notice(ctrl, result);
 		break;
 	case NVME_AER_ERROR:
+		str = __stringify(NVME_AER_ERROR);
+		trace_nvme_async_event(ctrl, result & 0x7, str);
+		ctrl->aen_result = result;
+		break;
 	case NVME_AER_SMART:
+		str = __stringify(NVME_AER_SMART);
+		trace_nvme_async_event(ctrl, result & 0x7, str);
+		ctrl->aen_result = result;
+		break;
 	case NVME_AER_CSS:
+		str = __stringify(NVME_AER_CSS);
+		trace_nvme_async_event(ctrl, result & 0x7, str);
+		ctrl->aen_result = result;
+		break;
 	case NVME_AER_VS:
+		str = __stringify(NVME_AER_VS);
+		trace_nvme_async_event(ctrl, result & 0x7, str);
 		ctrl->aen_result = result;
 		break;
 	default:
+		trace_nvme_async_event(ctrl, result, "unknown");
 		break;
 	}
 	queue_work(nvme_wq, &ctrl->async_event_work);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index a490790d6691..a8c502cb0281 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -156,6 +156,28 @@ TRACE_EVENT(nvme_complete_rq,
 
 );
 
+TRACE_EVENT(nvme_async_event,
+		TP_PROTO(struct nvme_ctrl *ctrl,
+			u32 result,
+			const char *result_str),
+		TP_ARGS(ctrl,
+			result,
+			result_str),
+		TP_STRUCT__entry(
+			__field(int, ctrl_id)
+			__field(u32, result)
+			__field(const char *, result_str)
+			),
+		TP_fast_assign(
+			__entry->ctrl_id = ctrl->instance;
+			__entry->result = result;
+			__entry->result_str = result_str;
+			),
+		TP_printk("nvme%d: NVME_AEN=%#08x [%s]",
+			__entry->ctrl_id, __entry->result, __entry->result_str)
+
+	   );
+
 #endif /* _TRACE_NVME_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.17.0
