From: sashal@kernel.org (Sasha Levin)
Date: Wed,  5 Dec 2018 04:35:43 -0500
Subject: [PATCH AUTOSEL 4.19 111/123] nvme-rdma: fix double freeing of async
 event data
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Message-ID: <20181205093555.5386-111-sashal@kernel.org>

From: Prabhath Sajeepa <psajeepa@purestorage.com>

[ Upstream commit 6344d02dc8f886b6bbcd922ae1a17e4a41500f2d ]

Some error paths in configuration of admin queue free data buffer
associated with async request SQE without resetting the data buffer
pointer to NULL, This buffer is also freed up again if the controller
is shutdown or reset.

Signed-off-by: Prabhath Sajeepa <psajeepa at purestorage.com>
Reviewed-by: Roland Dreier <roland at purestorage.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index dc042017c293..b6a28de682e8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -184,6 +184,7 @@ static int nvme_rdma_alloc_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
 	qe->dma = ib_dma_map_single(ibdev, qe->data, capsule_size, dir);
 	if (ib_dma_mapping_error(ibdev, qe->dma)) {
 		kfree(qe->data);
+		qe->data = NULL;
 		return -ENOMEM;
 	}
 
@@ -816,6 +817,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 out_free_async_qe:
 	nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
 		sizeof(struct nvme_command), DMA_TO_DEVICE);
+	ctrl->async_event_sqe.data = NULL;
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
-- 
2.17.1
