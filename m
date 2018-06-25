From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Jun 2018 20:58:17 +0300
Subject: [PATCH 4.18-rc] nvme-rdma: fix possible double free of controller
 async event buffer
Message-ID: <20180625175817.6739-1-sagi@grimberg.me>

If reconnect/reset failed where the controller async event buffer
was freed, we might end up freeing it again as we call
nvme_rdma_destroy_admin_queue again in the remove path. Given that
the sequence is guaranteed to serialize by .ctrl_stop, we simply
set ctrl->async_event_sqe.data to NULL and don't free it in future
visits.

Reported-by: Max Gurtovoy <maxg at mellanox.com>
Tested-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9544625c0b7d..518c5b09038c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -732,8 +732,11 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
 		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
 	}
-	nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-		sizeof(struct nvme_command), DMA_TO_DEVICE);
+	if (ctrl->async_event_sqe.data) {
+		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
+				sizeof(struct nvme_command), DMA_TO_DEVICE);
+		ctrl->async_event_sqe.data = NULL;
+	}
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 }
 
-- 
2.14.1
