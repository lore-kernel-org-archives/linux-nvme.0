From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 18:21:48 +0300
Subject: [PATCH rfc 14/30] nvme-rdma: stop queues instead of simply flipping
 their state
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497799324-19598-15-git-send-email-sagi@grimberg.me>

If we move the queues from LIVE state, we might as well stop
them (drain for rdma). Do it after we stop the sw request queues
to prevent a stray request sneaking in .queue_rq after we stop
the queue.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d9524389aedd..fbe2ca4f4ba3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -952,16 +952,15 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
-	int i;
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 
-	for (i = 0; i < ctrl->ctrl.queue_count; i++)
-		clear_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
-
-	if (ctrl->ctrl.queue_count > 1)
+	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
+	}
 	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	nvme_rdma_stop_queue(ctrl, 0);
 
 	/* We must take care of fastfail/requeue all our inflight requests */
 	if (ctrl->ctrl.queue_count > 1)
-- 
2.7.4
