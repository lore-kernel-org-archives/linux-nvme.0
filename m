From: keith.busch@intel.com (Keith Busch)
Date: Fri,  7 Jul 2017 12:23:00 -0400
Subject: [PATCH 6/7] nvme: Unexport starting async event work
In-Reply-To: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
Message-ID: <1499444581-28268-7-git-send-email-keith.busch@intel.com>

Async event work is for core use only and should not be called directly
from drivers.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 3 +--
 drivers/nvme/host/nvme.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bfd0045..783db84 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2535,11 +2535,10 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 
-void nvme_queue_async_events(struct nvme_ctrl *ctrl)
+static void nvme_queue_async_events(struct nvme_ctrl *ctrl)
 {
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
-EXPORT_SYMBOL_GPL(nvme_queue_async_events);
 
 static DEFINE_IDA(nvme_instance_ida);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index edca92d..b65c22f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -292,7 +292,6 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
-void nvme_queue_async_events(struct nvme_ctrl *ctrl);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
-- 
2.5.5
