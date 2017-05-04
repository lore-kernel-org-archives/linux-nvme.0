From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 May 2017 13:33:14 +0300
Subject: [PATCH 10/11] nvme: queue ns scanning and async request from nvme_wq
In-Reply-To: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
Message-ID: <1493893995-27063-11-git-send-email-sagi@grimberg.me>

To suppress the warning triggered by nvme_uninit_ctrl:
kernel: [   50.350439] nvme nvme0: rescanning
kernel: [   50.363351] ------------[ cut here]------------
kernel: [   50.363396] WARNING: CPU: 1 PID: 37 at kernel/workqueue.c:2423 check_flush_dependency+0x11f/0x130
kernel: [   50.363409] workqueue: WQ_MEM_RECLAIM
nvme-wq:nvme_del_ctrl_work [nvme_core] is flushing !WQ_MEM_RECLAIM events:nvme_scan_work [nvme_core]

This was triggered with nvme-loop, but can happen with rdma/pci as well afaict.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Note that given that nvme-pci dedicated workq was WQ_MEM_RECLAIM as well
so if we have an available WQ_MEM_RECLAIM workqueue in nvme-core we
would have fixed it sooner.

 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 26698e2c7380..6f720456b73f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2219,7 +2219,7 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
 	 * removal.
 	 */
 	if (ctrl->state == NVME_CTRL_LIVE)
-		schedule_work(&ctrl->scan_work);
+		queue_work(nvme_wq, &ctrl->scan_work);
 }
 EXPORT_SYMBOL_GPL(nvme_queue_scan);
 
@@ -2274,7 +2274,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		/*FALLTHRU*/
 	case NVME_SC_ABORT_REQ:
 		++ctrl->event_limit;
-		schedule_work(&ctrl->async_event_work);
+		queue_work(nvme_wq, &ctrl->async_event_work);
 		break;
 	default:
 		break;
@@ -2297,7 +2297,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 void nvme_queue_async_events(struct nvme_ctrl *ctrl)
 {
 	ctrl->event_limit = NVME_NR_AERS;
-	schedule_work(&ctrl->async_event_work);
+	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 EXPORT_SYMBOL_GPL(nvme_queue_async_events);
 
-- 
2.7.4
