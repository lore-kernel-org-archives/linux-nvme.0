From: israelr@mellanox.com (Israel Rukshin)
Date: Wed, 11 Apr 2018 16:07:04 +0000
Subject: [PATCH 2/2 v3] nvme-rdma: Fix command completion race at error
 recovery
In-Reply-To: <1523462824-25643-1-git-send-email-israelr@mellanox.com>
References: <1523462824-25643-1-git-send-email-israelr@mellanox.com>
Message-ID: <1523462824-25643-3-git-send-email-israelr@mellanox.com>

The race is between completing the request at error recovery work
and rdma completions.
If we cancel the request before getting the good rdma completion
we get a NULL deref of the request MR at nvme_rdma_process_nvme_rsp().

When Canceling the request we return its mr to the mr pool (set mr to NULL)
and also unmap its data.
Canceling the requests while the rdma queues are active is not safe.
Because rdma queues are active and we get good rdma completions
that can use the mr pointer which may be NULL.
Completing the request too soon may lead also to performing DMA to/from
user buffers which might have been already unmapped.

The commit fixes the race by draining the QP before
starting the abort commands mechanism.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c1abfc8..56fccac 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -734,7 +734,6 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
 		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
@@ -817,7 +816,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
-	nvme_rdma_stop_io_queues(ctrl);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
@@ -947,6 +945,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	return;
 
 destroy_admin:
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_rdma_destroy_admin_queue(ctrl, false);
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
@@ -963,12 +962,14 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, false);
 	}
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl, false);
@@ -1725,6 +1726,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, shutdown);
@@ -1736,6 +1738,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
@@ -2001,6 +2004,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	return &ctrl->ctrl;
 
 out_remove_admin_queue:
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_rdma_destroy_admin_queue(ctrl, true);
 out_kfree_queues:
 	kfree(ctrl->queues);
-- 
1.8.3.1
