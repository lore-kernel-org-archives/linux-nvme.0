From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  2 Jul 2017 20:45:14 +0300
Subject: [PATCH 1/4] nvme-rdma: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
Message-ID: <1499017517-18719-1-git-send-email-sagi@grimberg.me>

unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
quiescing/unquiescing respects the submission path rcu grace.
Also make sure to kick the requeue list when appropriate.

Reported-by: Max Gurtovoy <maxg at mellanox.com>
Tested-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e3996db22738..094873a4ee38 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -785,7 +785,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	if (ctrl->ctrl.queue_count > 1)
 		nvme_stop_queues(&ctrl->ctrl);
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 
 	/* We must take care of fastfail/requeue all our inflight requests */
 	if (ctrl->ctrl.queue_count > 1)
@@ -798,7 +798,8 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	 * queues are not a live anymore, so restart the queues to fail fast
 	 * new IO
 	 */
-	blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
+	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	blk_mq_kick_requeue_list(ctrl->ctrl.admin_q);
 	nvme_start_queues(&ctrl->ctrl);
 
 	nvme_rdma_reconnect_or_remove(ctrl);
@@ -1651,7 +1652,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
 	if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags))
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl);
-- 
2.7.4
