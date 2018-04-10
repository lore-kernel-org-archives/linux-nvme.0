From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 10 Apr 2018 20:18:06 +0300
Subject: [PATCH v1 2/5] nvme: remove association between ctrl and keep-alive
In-Reply-To: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
Message-ID: <1523380689-17151-3-git-send-email-maxg@mellanox.com>

Keep-alive mechanism is an admin queue property and
should be activated/deactivated during admin queue
creation/destruction.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6211066..674e746 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3369,7 +3369,6 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
 	cancel_work_sync(&ctrl->fw_act_work);
@@ -3380,9 +3379,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 
 void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 {
-	if (ctrl->kato)
-		nvme_start_keep_alive(ctrl);
-
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
 		queue_work(nvme_wq, &ctrl->async_event_work);
-- 
1.8.3.1
