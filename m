From: keith.busch@intel.com (Keith Busch)
Date: Fri, 13 Jul 2018 14:56:07 -0600
Subject: [PATCHv4 2/4] nvme: Start controller in own work queue
In-Reply-To: <20180713205609.19701-1-keith.busch@intel.com>
References: <20180713205609.19701-1-keith.busch@intel.com>
Message-ID: <20180713205609.19701-3-keith.busch@intel.com>

This moves the controller start from the reset_work to its own work.
This is preparing for the possibility of running IO when starting the
controller, which we shouldn't do from the reset_work since we need that
context to handle timeouts.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 12 +++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eeb97dbef7ff..6fed8a454843 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3418,6 +3418,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_keep_alive(ctrl);
+	flush_work(&ctrl->start_work);
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
 	cancel_work_sync(&ctrl->fw_act_work);
@@ -3426,8 +3427,11 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
 
-void nvme_start_ctrl(struct nvme_ctrl *ctrl)
+void nvme_start_work(struct work_struct *work)
 {
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, start_work);
+
 	if (ctrl->kato)
 		nvme_start_keep_alive(ctrl);
 
@@ -3438,6 +3442,11 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 		nvme_start_queues(ctrl);
 	}
 }
+
+void nvme_start_ctrl(struct nvme_ctrl *ctrl)
+{
+	queue_work(nvme_wq, &ctrl->start_work);
+}
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
@@ -3485,6 +3494,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
+	INIT_WORK(&ctrl->start_work, nvme_start_work);
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 51cf44ad86fd..1dd26a9a1fdc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -190,6 +190,7 @@ struct nvme_ctrl {
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
+	struct work_struct start_work;
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
-- 
2.14.3
