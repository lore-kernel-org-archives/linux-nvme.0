From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:35 +0300
Subject: [PATCH 08/12] nvme-rdma: stop queues instead of simply flipping their
 state
In-Reply-To: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
References: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499667759-15965-9-git-send-email-sagi@grimberg.me>

If we move the queues from LIVE state, we might as well stop
them (drain for rdma). Do it after we stop the sw request queues
to prevent a stray request sneaking in .queue_rq after we stop
the queue.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 685ad6acd7cd..346c35d5bf6f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -952,16 +952,15 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
-	int i;
 
 	nvme_stop_ctrl(&ctrl->ctrl);
 
-	for (i = 0; i < ctrl->ctrl.queue_count; i++)
-		clear_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
-
-	if (ctrl->ctrl.queue_count > 1)
+	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
+	}
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 
 	/* We must take care of fastfail/requeue all our inflight requests */
 	if (ctrl->ctrl.queue_count > 1)
-- 
2.7.4
