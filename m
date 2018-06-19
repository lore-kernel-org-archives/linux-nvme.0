From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 19 Jun 2018 15:34:14 +0300
Subject: [PATCH 6/7] nvme-rdma: centralize controller setup sequence
In-Reply-To: <20180619123415.25077-1-sagi@grimberg.me>
References: <20180619123415.25077-1-sagi@grimberg.me>
Message-ID: <20180619123415.25077-7-sagi@grimberg.me>

Centralize controller sequence to a single routine that
correctly cleans up after failures instead of having multiple
apperances in several flows (create, reset, reconnect).

One thing that we also gain here are the sanity/boundary checks also
when connecting back to a dynamic controller.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 137 ++++++++++++++++++++---------------------------
 1 file changed, 58 insertions(+), 79 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9dc1c37b5f65..33add5501ed6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -909,21 +909,47 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 	}
 }
 
-static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
+static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_rdma_ctrl, reconnect_work);
 	bool changed;
 	int ret;
 
-	++ctrl->ctrl.nr_reconnects;
-
-	ret = nvme_rdma_configure_admin_queue(ctrl, false);
+	ret = nvme_rdma_configure_admin_queue(ctrl, new);
 	if (ret)
-		goto requeue;
+		return ret;
+
+	/* sanity check icdoff */
+	if (ctrl->ctrl.icdoff) {
+		dev_err(ctrl->ctrl.device, "icdoff is not supported!\n");
+		ret = -EINVAL;
+		goto destroy_admin;
+	}
+
+	/* sanity check keyed sgls */
+	if (!(ctrl->ctrl.sgls & (1 << 2))) {
+		dev_err(ctrl->ctrl.device,
+			"Mandatory keyed sgls are not supported!\n");
+		ret = -EINVAL;
+		goto destroy_admin;
+	}
+
+	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize + 1) {
+		/* warn if sqsize is lower than queue_size */
+		dev_warn(ctrl->ctrl.device,
+			"queue_size %zu > ctrl sqsize %u, clamping down\n",
+			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
+	}
+
+	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
+		/* warn if maxcmd is lower than queue_size */
+		dev_warn(ctrl->ctrl.device,
+			"sqsize %u > ctrl maxcmd %u, clamping down\n",
+			ctrl->ctrl.sqsize + 1, ctrl->ctrl.maxcmd);
+		ctrl->ctrl.sqsize = ctrl->ctrl.maxcmd - 1;
+	}
 
 	if (ctrl->ctrl.queue_count > 1) {
-		ret = nvme_rdma_configure_io_queues(ctrl, false);
+		ret = nvme_rdma_configure_io_queues(ctrl, new);
 		if (ret)
 			goto destroy_admin;
 	}
@@ -932,11 +958,32 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	if (!changed) {
 		/* state change failure is ok if we're in DELETING state */
 		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
-		return;
+		ret = -EINVAL;
+		goto destroy_io;
 	}
 
 	nvme_start_ctrl(&ctrl->ctrl);
 
+	return 0;
+destroy_io:
+	if (ctrl->ctrl.queue_count > 1)
+		nvme_rdma_destroy_io_queues(ctrl, new);
+destroy_admin:
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_destroy_admin_queue(ctrl, new);
+	return ret;
+}
+
+static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
+{
+	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_rdma_ctrl, reconnect_work);
+
+	++ctrl->ctrl.nr_reconnects;
+
+	if (nvme_rdma_setup_ctrl(ctrl, false))
+		goto requeue;
+
 	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attempts)\n",
 			ctrl->ctrl.nr_reconnects);
 
@@ -944,9 +991,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 
 	return;
 
-destroy_admin:
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	nvme_rdma_destroy_admin_queue(ctrl, false);
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
 			ctrl->ctrl.nr_reconnects);
@@ -1765,8 +1809,6 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl =
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
-	int ret;
-	bool changed;
 
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
@@ -1777,25 +1819,9 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	ret = nvme_rdma_configure_admin_queue(ctrl, false);
-	if (ret)
+	if (nvme_rdma_setup_ctrl(ctrl, false))
 		goto out_fail;
 
-	if (ctrl->ctrl.queue_count > 1) {
-		ret = nvme_rdma_configure_io_queues(ctrl, false);
-		if (ret)
-			goto out_fail;
-	}
-
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	if (!changed) {
-		/* state change failure is ok if we're in DELETING state */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
-		return;
-	}
-
-	nvme_start_ctrl(&ctrl->ctrl);
-
 	return;
 
 out_fail:
@@ -1958,52 +1984,10 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
 	WARN_ON_ONCE(!changed);
 
-	ret = nvme_rdma_configure_admin_queue(ctrl, true);
+	ret = nvme_rdma_setup_ctrl(ctrl, true);
 	if (ret)
 		goto out_uninit_ctrl;
 
-	/* sanity check icdoff */
-	if (ctrl->ctrl.icdoff) {
-		dev_err(ctrl->ctrl.device, "icdoff is not supported!\n");
-		ret = -EINVAL;
-		goto out_remove_admin_queue;
-	}
-
-	/* sanity check keyed sgls */
-	if (!(ctrl->ctrl.sgls & (1 << 2))) {
-		dev_err(ctrl->ctrl.device,
-			"Mandatory keyed sgls are not supported!\n");
-		ret = -EINVAL;
-		goto out_remove_admin_queue;
-	}
-
-	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
-		/*
-		 * warn if sqsize is lower than queue_size actual calmping
-		 * will be by using sqsize for the tagset allocation later.
-		 */
-		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-			opts->queue_size, ctrl->ctrl.sqsize + 1);
-	}
-
-	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
-		/* warn if maxcmd is lower than sqsize+1 */
-		dev_warn(ctrl->ctrl.device,
-			"sqsize %u > ctrl maxcmd %u, clamping down\n",
-			ctrl->ctrl.sqsize + 1, ctrl->ctrl.maxcmd);
-		ctrl->ctrl.sqsize = ctrl->ctrl.maxcmd - 1;
-	}
-
-	if (opts->nr_io_queues) {
-		ret = nvme_rdma_configure_io_queues(ctrl, true);
-		if (ret)
-			goto out_remove_admin_queue;
-	}
-
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
-
 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
 		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
 
@@ -2013,13 +1997,8 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-	nvme_start_ctrl(&ctrl->ctrl);
-
 	return &ctrl->ctrl;
 
-out_remove_admin_queue:
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	nvme_rdma_destroy_admin_queue(ctrl, true);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	nvme_put_ctrl(&ctrl->ctrl);
-- 
2.14.1
