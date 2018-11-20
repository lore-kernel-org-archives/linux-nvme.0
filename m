From: psajeepa@purestorage.com (Prabhath Sajeepa)
Date: Tue, 20 Nov 2018 13:11:13 -0700
Subject: [PATCH] drivers/nvme/host/rdma.c: Fix double freeing of async event
 data
Message-ID: <1542744673-28129-1-git-send-email-psajeepa@purestorage.com>

Some error paths in configuration of admin queue free data buffer
associated with async request SQE without resetting the data buffer
pointer to NULL, This buffer is also freed up again if the controller
is shutdown or reset.
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d181caf..b61ae21 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -823,6 +823,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 out_free_async_qe:
 	nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
 		sizeof(struct nvme_command), DMA_TO_DEVICE);
+	ctrl->async_event_sqe.data = NULL;
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
-- 
2.7.4
