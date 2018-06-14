From: israelr@mellanox.com (Israel Rukshin)
Date: Thu, 14 Jun 2018 12:37:44 +0000
Subject: [PATCH] nvme: Fix error flow at nvme_rdma_configure_admin_queue()
Message-ID: <1528979864-3109-1-git-send-email-israelr@mellanox.com>

On error calling to nvme_rdma_free_queue() with admin queue
frees the QE before it was allocated.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7b3f084..8786779 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -536,6 +536,15 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 		goto out_destroy_cm_id;
 	}
 
+	if (idx == 0) {
+		ret = nvme_rdma_alloc_qe(queue->device->dev,
+					 &ctrl->async_event_sqe,
+					 sizeof(struct nvme_command),
+					 DMA_TO_DEVICE);
+		if (ret)
+			goto out_destroy_cm_id;
+	}
+
 	set_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags);
 
 	return 0;
@@ -795,12 +804,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error)
 		goto out_stop_queue;
 
-	error = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
-			&ctrl->async_event_sqe, sizeof(struct nvme_command),
-			DMA_TO_DEVICE);
-	if (error)
-		goto out_stop_queue;
-
 	return 0;
 
 out_stop_queue:
-- 
1.8.3.1
