From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 12 Sep 2018 05:51:23 +0000
Subject: [PATCH V2] nvme-core: add async event trace helper
In-Reply-To: <20180911071952.GA8988@infradead.org>
References: <20180829221922.23539-1-chaitanya.kulkarni@wdc.com>,
 <20180911071952.GA8988@infradead.org>
Message-ID: <BYAPR04MB4502ED2C1C2691C07DF7485D861B0@BYAPR04MB4502.namprd04.prod.outlook.com>

What do you think of the following implementation?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ef6748f4ff47..d6adb3b50926 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3413,14 +3413,17 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
        switch ((result & 0xff00) >> 8) {
        case NVME_AER_NOTICE_NS_CHANGED:
+               trace_nvme_async_event(ctrl, (result & 0xff00) >> 8);
                set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
                nvme_queue_scan(ctrl);
                break;
        case NVME_AER_NOTICE_FW_ACT_STARTING:
+               trace_nvme_async_event(ctrl, (result & 0xff00) >> 8);
                queue_work(nvme_wq, &ctrl->fw_act_work);
                break;
 #ifdef CONFIG_NVME_MULTIPATH
        case NVME_AER_NOTICE_ANA:
+               trace_nvme_async_event(ctrl, (result & 0xff00) >> 8);
                if (!ctrl->ana_log_buf)
                        break;
                queue_work(nvme_wq, &ctrl->ana_work);
@@ -3447,6 +3450,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
        case NVME_AER_SMART:
        case NVME_AER_CSS:
        case NVME_AER_VS:
+               trace_nvme_async_event(ctrl, result & 0x7);
                ctrl->aen_result = result;
                break;
        default:
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index a490790d6691..9c07fea357b8 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -156,6 +156,36 @@ TRACE_EVENT(nvme_complete_rq,
 
 );
 
+#define aer_name(aer) { aer, #aer }
+
+TRACE_EVENT(nvme_async_event,
+               TP_PROTO(struct nvme_ctrl *ctrl,
+                       u32 result),
+               TP_ARGS(ctrl,
+                       result),
+               TP_STRUCT__entry(
+                       __field(int, ctrl_id)
+                       __field(u32, result)
+                       ),
+               TP_fast_assign(
+                       __entry->ctrl_id = ctrl->instance;
+                       __entry->result = result;
+                       ),
+               TP_printk("nvme%d: NVME_AEN=%#08x [%s]",
+                       __entry->ctrl_id, __entry->result,
+                       __print_symbolic(__entry->result,
+                       aer_name(NVME_AER_NOTICE_NS_CHANGED),
+#ifdef CONFIG_NVME_MULTIPATH
+                       aer_name(NVME_AER_NOTICE_ANA)
+#endif
+                       aer_name(NVME_AER_NOTICE_FW_ACT_STARTING),
+                       aer_name(NVME_AER_ERROR),
+                       aer_name(NVME_AER_SMART),
+                       aer_name(NVME_AER_CSS),
+                       aer_name(NVME_AER_VS))
+)
+          );
+
 #endif /* _TRACE_NVME_H */
 
 #undef TRACE_INCLUDE_PATH


Regards,
Chaitanya


From: Christoph Hellwig <hch@infradead.org>
Sent: Tuesday, September 11, 2018 12:19 AM
To: Chaitanya Kulkarni
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH V2] nvme-core: add async event trace helper
? 
 
On Wed, Aug 29, 2018@03:19:22PM -0700, Chaitanya Kulkarni wrote:
> This patch adds a new event for nvme async event notification.
> We print the async event in the decoded format when we recognize
> the event otherwise we just dump the result.

I don't like the reason_str handling.? The normal way to do this
would be to but the binary reason (i.e. what we switch on) into
the trace buffer, and then use __print_symbolic in the TP_printk
statement.
    
