From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 5 Dec 2017 14:38:46 +0800
Subject: [PATCH] nvme-rdma: fix race between error-recovering and scanning
Message-ID: <1512455926-10608-1-git-send-email-guanjunxiong@huawei.com>

A race between the error recovering work and scanning work is
observed. For example, if the target system is going to be tore
down, it will send NVME_NS_CHANGED AER which results in scanning.
The ns->queue is cleaned up in the nvme_ns_remove. At the same time,
the host may enter into error recovering because when encountering
connection error. The request queues of namespaces list is started by
nvme_start_queues and requests is requeued to be processed but the
queue has been cleaned up.

To fix it, this patch introduces a new state indicated the scanning
state. When the controller in the scanning state when encountering
error, the recovering work should wait for the completion signal of
the scanning work.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 drivers/nvme/host/core.c | 20 ++++++++++++++++++--
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/rdma.c | 17 ++++++++++++++++-
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f837d66..f79cda9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -237,6 +237,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_RECONNECTING:
+		case NVME_CTRL_SCANNING:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -263,6 +264,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
+	case NVME_CTRL_SCANNING:
+		switch (old_state) {
+		case NVME_CTRL_LIVE:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
 	case NVME_CTRL_DELETING:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
@@ -2605,6 +2615,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 		[NVME_CTRL_RECONNECTING]= "reconnecting",
 		[NVME_CTRL_DELETING]	= "deleting",
 		[NVME_CTRL_DEAD]	= "dead",
+		[NVME_CTRL_SCANNING]	= "scanning",
 	};
 
 	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
@@ -3070,11 +3081,11 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_id_ctrl *id;
 	unsigned nn;
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_SCANNING))
 		return;
 
 	if (nvme_identify_ctrl(ctrl, &id))
-		return;
+		goto out;
 
 	nn = le32_to_cpu(id->nn);
 	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
@@ -3088,6 +3099,10 @@ static void nvme_scan_work(struct work_struct *work)
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
 	mutex_unlock(&ctrl->namespaces_mutex);
 	kfree(id);
+
+out:
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+	complete(&ctrl->scan_done);
 }
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
@@ -3314,6 +3329,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
+	init_completion(&ctrl->scan_done);
 
 	ret = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ea1aa52..5c61de5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -123,6 +123,7 @@ enum nvme_ctrl_state {
 	NVME_CTRL_RECONNECTING,
 	NVME_CTRL_DELETING,
 	NVME_CTRL_DEAD,
+	NVME_CTRL_SCANNING,
 };
 
 struct nvme_ctrl {
@@ -177,6 +178,7 @@ struct nvme_ctrl {
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
+	struct completion scan_done;
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 37af565..e7f7b0e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -37,6 +37,7 @@
 
 
 #define NVME_RDMA_CONNECT_TIMEOUT_MS	3000		/* 3 second */
+#define NVME_RDMA_WAIT_SCAN_TIMEOUT	3000		/* 3 second */
 
 #define NVME_RDMA_MAX_SEGMENTS		256
 
@@ -979,8 +980,22 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING))
+	unsigned long flags;
+	bool scan;
+
+check_wait:
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING)) {
+		spin_lock_irqsave(&ctrl->ctrl.lock, flags);
+		scan = ctrl->ctrl.state == NVME_CTRL_SCANNING;
+		spin_unlock_irqrestore(&ctrl->ctrl.lock, flags);
+
+		if (scan) {
+			wait_for_completion_interruptible_timeout(&ctrl->ctrl.scan_done,
+			msecs_to_jiffies(NVME_RDMA_WAIT_SCAN_TIMEOUT) + 1);
+			goto check_wait;
+		}
 		return;
+	}
 
 	queue_work(nvme_wq, &ctrl->err_work);
 }
-- 
2.6.4.windows.1
