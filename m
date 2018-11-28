From: psajeepa@purestorage.com (Prabhath Sajeepa)
Date: Wed, 28 Nov 2018 11:11:29 -0700
Subject: [PATCH] nvme-rdma: Fix double freeing of async event data
Message-ID: <1543428689-13382-1-git-send-email-psajeepa@purestorage.com>

Some error paths in configuration of admin queue free data buffer
associated with async request SQE without resetting the data buffer
pointer to NULL, This buffer is also freed up again if the controller
is shutdown or reset.

Signed-off-by: Prabhath Sajeepa <psajeepa at purestorage.com>
---
 drivers/nvme/host/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d181caf..ab6ec72 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -184,6 +184,7 @@ static int nvme_rdma_alloc_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
 	qe->dma = ib_dma_map_single(ibdev, qe->data, capsule_size, dir);
 	if (ib_dma_mapping_error(ibdev, qe->dma)) {
 		kfree(qe->data);
+		qe->data = NULL;
 		return -ENOMEM;
 	}
 
@@ -823,6 +824,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 out_free_async_qe:
 	nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
 		sizeof(struct nvme_command), DMA_TO_DEVICE);
+	ctrl->async_event_sqe.data = NULL;
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
-- 
2.7.4
