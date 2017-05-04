From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 May 2017 13:33:06 +0300
Subject: [PATCH 02/11] nvme-rdma: get rid of unused ctrl lock
In-Reply-To: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
Message-ID: <1493893995-27063-3-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 29cf88ac3f61..1cd7a21f63f4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -103,9 +103,6 @@ struct nvme_rdma_queue {
 };
 
 struct nvme_rdma_ctrl {
-	/* read and written in the hot path */
-	spinlock_t		lock;
-
 	/* read only in the hot path */
 	struct nvme_rdma_queue	*queues;
 	u32			queue_count;
@@ -1896,7 +1893,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->delete_work, nvme_rdma_del_ctrl_work);
 	INIT_WORK(&ctrl->reset_work, nvme_rdma_reset_ctrl_work);
-	spin_lock_init(&ctrl->lock);
 
 	ctrl->queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
-- 
2.7.4
