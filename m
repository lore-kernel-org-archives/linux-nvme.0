From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 May 2017 13:33:11 +0300
Subject: [PATCH 07/11] nvme-rdma: Get rid of CONNECTED state
In-Reply-To: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
Message-ID: <1493893995-27063-8-git-send-email-sagi@grimberg.me>

We only care about if the queue is LIVE for request submission,
so no need for CONNECTED.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7df52896f321..9ce56520bb1a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -80,9 +80,8 @@ struct nvme_rdma_request {
 };
 
 enum nvme_rdma_queue_flags {
-	NVME_RDMA_Q_CONNECTED		= 0,
+	NVME_RDMA_Q_LIVE		= 0,
 	NVME_RDMA_Q_DELETING		= 1,
-	NVME_RDMA_Q_LIVE		= 2,
 };
 
 struct nvme_rdma_queue {
@@ -580,7 +579,6 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 	}
 
 	clear_bit(NVME_RDMA_Q_DELETING, &queue->flags);
-	set_bit(NVME_RDMA_Q_CONNECTED, &queue->flags);
 
 	return 0;
 
@@ -803,10 +801,8 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 
-	for (i = 0; i < ctrl->queue_count; i++) {
-		clear_bit(NVME_RDMA_Q_CONNECTED, &ctrl->queues[i].flags);
+	for (i = 0; i < ctrl->queue_count; i++)
 		clear_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
-	}
 
 	if (ctrl->queue_count > 1)
 		nvme_stop_queues(&ctrl->ctrl);
@@ -1634,7 +1630,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
 		nvme_rdma_free_io_queues(ctrl);
 	}
 
-	if (test_bit(NVME_RDMA_Q_CONNECTED, &ctrl->queues[0].flags))
+	if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags))
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
 	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
-- 
2.7.4
