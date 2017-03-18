From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 19 Mar 2017 00:42:21 +0200
Subject: [PATCH 3/3] nvme-rdma: Support ctrl_loss_tmo
In-Reply-To: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
References: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
Message-ID: <1489876941-6401-4-git-send-email-sagi@grimberg.me>

Before scheduling a reconnect attempt, check
nr_reconnects against max_reconnects, if not
exhausted (or max_reconnects is not -1), schedule
a reconnect attempts, otherwise schedule ctrl
removal.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 33f18636ea99..71d1e1a6b928 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -711,6 +711,26 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
+static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
+{
+	/* If we are resetting/deleting then do nothing */
+	if (ctrl->ctrl.state != NVME_CTRL_RECONNECTING) {
+		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
+			ctrl->ctrl.state == NVME_CTRL_LIVE);
+		return;
+	}
+
+	if (nvmf_should_reconnect(&ctrl->ctrl)) {
+		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
+			ctrl->ctrl.opts->reconnect_delay);
+		queue_delayed_work(nvme_rdma_wq, &ctrl->reconnect_work,
+				ctrl->ctrl.opts->reconnect_delay * HZ);
+	} else {
+		dev_info(ctrl->ctrl.device, "Removing controller...\n");
+		queue_work(nvme_rdma_wq, &ctrl->delete_work);
+	}
+}
+
 static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
@@ -718,6 +738,8 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	bool changed;
 	int ret;
 
+	++ctrl->ctrl.opts->nr_reconnects;
+
 	if (ctrl->queue_count > 1) {
 		nvme_rdma_free_io_queues(ctrl);
 
@@ -762,6 +784,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
+	ctrl->ctrl.opts->nr_reconnects = 0;
 
 	if (ctrl->queue_count > 1) {
 		nvme_start_queues(&ctrl->ctrl);
@@ -776,13 +799,9 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 stop_admin_q:
 	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
 requeue:
-	/* Make sure we are not resetting/deleting */
-	if (ctrl->ctrl.state == NVME_CTRL_RECONNECTING) {
-		dev_info(ctrl->ctrl.device,
-			"Failed reconnect attempt, requeueing...\n");
-		queue_delayed_work(nvme_rdma_wq, &ctrl->reconnect_work,
-				ctrl->ctrl.opts->reconnect_delay * HZ);
-	}
+	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
+			ctrl->ctrl.opts->nr_reconnects);
+	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
@@ -809,11 +828,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
 
-	dev_info(ctrl->ctrl.device, "reconnecting in %d seconds\n",
-		ctrl->ctrl.opts->reconnect_delay);
-
-	queue_delayed_work(nvme_rdma_wq, &ctrl->reconnect_work,
-				ctrl->ctrl.opts->reconnect_delay * HZ);
+	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
@@ -2011,7 +2026,7 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
 	.name		= "rdma",
 	.required_opts	= NVMF_OPT_TRADDR,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
-			  NVMF_OPT_HOST_TRADDR,
+			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
 	.create_ctrl	= nvme_rdma_create_ctrl,
 };
 
-- 
2.7.4
