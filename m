From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 Aug 2016 13:51:16 +0300
Subject: [PATCH] nvme-rdma: start async event handler after reconnecting to a
 controller
Message-ID: <1470307876-18451-1-git-send-email-sagi@grimberg.me>

When we reset or reconnect to a controller, we are cancelling the
async event handler so we can safely re-establish resources, but we
need to remember to start it again when we successfully reconnect.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6378dc94aeaf..f2cf433f628d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -745,6 +745,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	if (ctrl->queue_count > 1) {
 		nvme_start_queues(&ctrl->ctrl);
 		nvme_queue_scan(&ctrl->ctrl);
+		nvme_queue_async_events(&ctrl->ctrl);
 	}
 
 	dev_info(ctrl->ctrl.device, "Successfully reconnected\n");
@@ -1747,6 +1748,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	if (ctrl->queue_count > 1) {
 		nvme_start_queues(&ctrl->ctrl);
 		nvme_queue_scan(&ctrl->ctrl);
+		nvme_queue_async_events(&ctrl->ctrl);
 	}
 
 	return;
-- 
1.9.1
