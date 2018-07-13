From: keith.busch@intel.com (Keith Busch)
Date: Fri, 13 Jul 2018 14:56:08 -0600
Subject: [PATCHv4 3/4] nvme: Introduce frozen controller state
In-Reply-To: <20180713205609.19701-1-keith.busch@intel.com>
References: <20180713205609.19701-1-keith.busch@intel.com>
Message-ID: <20180713205609.19701-4-keith.busch@intel.com>

This patch creates a new controller state that transport specific drivers
can set their controller to prior to starting the controller to have the
start_work handle frozen request queues and update the hardware contexts.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 21 ++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6fed8a454843..7ce339c3fcc4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -288,11 +288,21 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
+	case NVME_CTRL_FROZEN:
+		switch (old_state) {
+		case NVME_CTRL_CONNECTING:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
+		case NVME_CTRL_FROZEN:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -304,6 +314,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_ADMIN_ONLY:
+		case NVME_CTRL_FROZEN:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -3435,16 +3446,24 @@ void nvme_start_work(struct work_struct *work)
 	if (ctrl->kato)
 		nvme_start_keep_alive(ctrl);
 
+	if (ctrl->state == NVME_CTRL_FROZEN) {
+		nvme_wait_freeze(ctrl);
+		blk_mq_update_nr_hw_queues(ctrl->tagset, ctrl->queue_count - 1);
+		nvme_unfreeze(ctrl);
+		if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+			return;
+	}
+
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
 		nvme_enable_aen(ctrl);
 		queue_work(nvme_wq, &ctrl->async_event_work);
-		nvme_start_queues(ctrl);
 	}
 }
 
 void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 {
+	nvme_start_queues(ctrl);
 	queue_work(nvme_wq, &ctrl->start_work);
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1dd26a9a1fdc..ca981e5eb6b3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -134,6 +134,7 @@ enum nvme_ctrl_state {
 	NVME_CTRL_CONNECTING,
 	NVME_CTRL_DELETING,
 	NVME_CTRL_DEAD,
+	NVME_CTRL_FROZEN,
 };
 
 struct nvme_ctrl {
-- 
2.14.3
