From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 17 Sep 2018 10:47:06 -0700
Subject: [PATCH V3] nvme-core: add async event trace helper
Message-ID: <20180917174706.31744-1-chaitanya.kulkarni@wdc.com>

This patch adds a new event for nvme async event notification.
We print the async event in the decoded format when we recognize
the event otherwise we just dump the result.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Changes since V2:-

1. Use __print_symbolic() to stringify the aer type.
2. Use local variable to calculate the mask and shift once.

Changes since V1:-
1. __stringify() all the known NVME_AER* status codes.

---
 drivers/nvme/host/core.c  | 11 +++++++++--
 drivers/nvme/host/trace.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ef6748f4ff47..0d2eea795907 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3411,16 +3411,21 @@ static void nvme_fw_act_work(struct work_struct *work)
 
 static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
-	switch ((result & 0xff00) >> 8) {
+	int aer_notice_type = (result & 0xff00) >> 8;
+
+	switch (aer_notice_type) {
 	case NVME_AER_NOTICE_NS_CHANGED:
+		trace_nvme_async_event(ctrl, aer_notice_type);
 		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
+		trace_nvme_async_event(ctrl, aer_notice_type);
 		queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
 #ifdef CONFIG_NVME_MULTIPATH
 	case NVME_AER_NOTICE_ANA:
+		trace_nvme_async_event(ctrl, aer_notice_type);
 		if (!ctrl->ana_log_buf)
 			break;
 		queue_work(nvme_wq, &ctrl->ana_work);
@@ -3435,11 +3440,12 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
+	u32 aer_type = result & 0x07;
 
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
 
-	switch (result & 0x7) {
+	switch (aer_type) {
 	case NVME_AER_NOTICE:
 		nvme_handle_aen_notice(ctrl, result);
 		break;
@@ -3447,6 +3453,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
+		trace_nvme_async_event(ctrl, aer_type);
 		ctrl->aen_result = result;
 		break;
 	default:
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index a490790d6691..000e2c5a6df7 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -156,6 +156,34 @@ TRACE_EVENT(nvme_complete_rq,
 
 );
 
+#define aer_name(aer) { aer, #aer }
+
+TRACE_EVENT(nvme_async_event,
+		TP_PROTO(struct nvme_ctrl *ctrl,
+			u32 result),
+		TP_ARGS(ctrl,
+			result),
+		TP_STRUCT__entry(
+			__field(int, ctrl_id)
+			__field(u32, result)
+			),
+		TP_fast_assign(
+			__entry->ctrl_id = ctrl->instance;
+			__entry->result = result;
+			),
+		TP_printk("nvme%d: NVME_AEN=%#08x [%s]",
+			__entry->ctrl_id, __entry->result,
+			__print_symbolic(__entry->result,
+			aer_name(NVME_AER_NOTICE_NS_CHANGED),
+			aer_name(NVME_AER_NOTICE_ANA),
+			aer_name(NVME_AER_NOTICE_FW_ACT_STARTING),
+			aer_name(NVME_AER_ERROR),
+			aer_name(NVME_AER_SMART),
+			aer_name(NVME_AER_CSS),
+			aer_name(NVME_AER_VS))
+)
+	   );
+
 #endif /* _TRACE_NVME_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.17.0
