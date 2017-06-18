From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 18:22:04 +0300
Subject: [PATCH rfc 30/30] nvme: Add queue freeze/unfreeze handling on
 controller resets
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497799324-19598-31-git-send-email-sagi@grimberg.me>

Just copy what we have in nvme-pci. It's a generic flow anyway.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f4800b8e47a0..959b6c39f22c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2901,15 +2901,40 @@ EXPORT_SYMBOL_GPL(nvme_configure_admin_queue);
 
 static void nvme_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
+	bool dead = true;
+
 	nvme_stop_keep_alive(ctrl);
 	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
 
 	if (ctrl->max_queues > 1) {
+		u32 csts;
+
+		if (!ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) {
+			nvme_start_freeze(ctrl);
+			dead = !!((csts & NVME_CSTS_CFS) ||
+				!(csts & NVME_CSTS_RDY));
+		}
+
+		/*
+		 * Give the controller a chance to complete all entered requests
+		 * if doing a safe shutdown.
+		 */
+		if (!dead && shutdown)
+			nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT);
+
 		nvme_stop_queues(ctrl);
 		blk_mq_tagset_busy_iter(ctrl->tagset,
 					nvme_cancel_request, ctrl);
 		nvme_destroy_io_queues(ctrl, shutdown);
+
+		/*
+		 * The driver will not be starting up queues again if shutting
+		 * down so must flush all entered requests to their failed
+		 * completion to avoid deadlocking blk-mq hot-cpu notifier.
+		 */
+		if (shutdown)
+			nvme_start_queues(ctrl);
 	}
 
 	if (shutdown)
@@ -2991,6 +3016,8 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 	if (ctrl->queue_count > 1) {
 		nvme_start_queues(ctrl);
+		nvme_wait_freeze(ctrl);
+		nvme_unfreeze(ctrl);
 		nvme_queue_scan(ctrl);
 		nvme_queue_async_events(ctrl);
 	}
-- 
2.7.4
