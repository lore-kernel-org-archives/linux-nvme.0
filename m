From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Oct 2017 16:19:23 -0600
Subject: [PATCHv2 4/5] nvme: Unexport starting async event work
In-Reply-To: <20171020221924.30659-1-keith.busch@intel.com>
References: <20171020221924.30659-1-keith.busch@intel.com>
Message-ID: <20171020221924.30659-5-keith.busch@intel.com>

Async event work is for core use only and should not be called directly
from drivers.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 8 +-------
 drivers/nvme/host/nvme.h | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7fb55b6e26c3..74724329f430 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2670,12 +2670,6 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 
-void nvme_queue_async_events(struct nvme_ctrl *ctrl)
-{
-	queue_work(nvme_wq, &ctrl->async_event_work);
-}
-EXPORT_SYMBOL_GPL(nvme_queue_async_events);
-
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_keep_alive(ctrl);
@@ -2692,7 +2686,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
-		nvme_queue_async_events(ctrl);
+		queue_work(nvme_wq, &ctrl->async_event_work);
 		nvme_start_queues(ctrl);
 	}
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2f1e52131430..4cd4e8f4db19 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -301,7 +301,6 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
-void nvme_queue_async_events(struct nvme_ctrl *ctrl);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
-- 
2.13.6
