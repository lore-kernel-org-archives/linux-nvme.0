From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  4 Jul 2018 12:40:20 +0300
Subject: [PATCH for-4.19 fold 2/2] nvme-rdma: centralize admin/io queue
 teardown sequence
In-Reply-To: <20180704094020.28669-1-sagi@grimberg.me>
References: <20180704094020.28669-1-sagi@grimberg.me>
Message-ID: <20180704094020.28669-2-sagi@grimberg.me>

We follow the same queue teardown sequence in delete, reset and error
recovery. Centralize the logic.  This patch does not change any
functionality.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
** This is the modified a20f15552bc6 ("nvme-rdma: centralize admin/io queue teardown sequence")
 drivers/nvme/host/rdma.c | 66 +++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 357bdcd8169b..24c624cc750d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -868,6 +868,31 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 	return ret;
 }
 
+static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
+		bool remove)
+{
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set, nvme_cancel_request,
+			&ctrl->ctrl);
+	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	nvme_rdma_destroy_admin_queue(ctrl, remove);
+}
+
+static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
+		bool remove)
+{
+	if (ctrl->ctrl.queue_count > 1) {
+		nvme_stop_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
+		blk_mq_tagset_busy_iter(&ctrl->tag_set, nvme_cancel_request,
+				&ctrl->ctrl);
+		if (remove)
+			nvme_start_queues(&ctrl->ctrl);
+		nvme_rdma_destroy_io_queues(ctrl, remove);
+	}
+}
+
 static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -1000,27 +1025,9 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 			struct nvme_rdma_ctrl, err_work);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
-
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
-		nvme_rdma_stop_io_queues(ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
-		nvme_rdma_destroy_io_queues(ctrl, false);
-	}
-
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl, false);
-
-	/*
-	 * queues are not a live anymore, so restart the queues to fail fast
-	 * new IO
-	 */
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_start_queues(&ctrl->ctrl);
+	nvme_rdma_teardown_admin_queue(ctrl, false);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we're in DELETING state */
@@ -1774,27 +1781,12 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
-		nvme_rdma_stop_io_queues(ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
-		if (shutdown)
-			nvme_start_queues(&ctrl->ctrl);
-		nvme_rdma_destroy_io_queues(ctrl, shutdown);
-	}
-
+	nvme_rdma_teardown_io_queues(ctrl, shutdown);
 	if (shutdown)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 	else
 		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
-
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
+	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
 }
 
 static void nvme_rdma_delete_ctrl(struct nvme_ctrl *ctrl)
-- 
2.14.1
