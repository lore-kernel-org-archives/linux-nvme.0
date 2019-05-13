From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 13 May 2019 10:46:05 -0700
Subject: [PATCH V2] nvme-core: trace all async notice events
Message-ID: <20190513174605.9017-1-chaitanya.kulkarni@wdc.com>

This patch removes the tracing of the NVMe Async events out of the
switch so that it can trace all the events including the ones which
are not handled in the nvme_handle_aen_notice(). The events which
are not handled in the nvme_handle_aen_notice() such as 
NVME_AER_NOTICE_DISC_CHANGED corresponding event identifier needs
to be added in the drivers/nvme/host/trace.h so that it can stringify
the AER .

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Changes since V1:-

1. Move trace_nvme_async_event() outside of switch (hch at lst.de)
2. Change the subject line from. 
   "nvme-core: trace discovery log change AEN" ->
    "nvme-core: trace all async notice events".
3. Add missing notice disc changes identifier in the trace.h.
---
 drivers/nvme/host/core.c  | 5 ++---
 drivers/nvme/host/trace.h | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eebaeadaa800..f22925b5eeca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3604,19 +3604,18 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
 	u32 aer_notice_type = (result & 0xff00) >> 8;
 
+	trace_nvme_async_event(ctrl, aer_notice_type);
+
 	switch (aer_notice_type) {
 	case NVME_AER_NOTICE_NS_CHANGED:
-		trace_nvme_async_event(ctrl, aer_notice_type);
 		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
-		trace_nvme_async_event(ctrl, aer_notice_type);
 		queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
 #ifdef CONFIG_NVME_MULTIPATH
 	case NVME_AER_NOTICE_ANA:
-		trace_nvme_async_event(ctrl, aer_notice_type);
 		if (!ctrl->ana_log_buf)
 			break;
 		queue_work(nvme_wq, &ctrl->ana_work);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 97d3c77365b8..e71502d141ed 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -167,6 +167,7 @@ TRACE_EVENT(nvme_async_event,
 		aer_name(NVME_AER_NOTICE_NS_CHANGED),
 		aer_name(NVME_AER_NOTICE_ANA),
 		aer_name(NVME_AER_NOTICE_FW_ACT_STARTING),
+		aer_name(NVME_AER_NOTICE_DISC_CHANGED),
 		aer_name(NVME_AER_ERROR),
 		aer_name(NVME_AER_SMART),
 		aer_name(NVME_AER_CSS),
-- 
2.17.0
