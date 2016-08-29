From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 29 Aug 2016 14:28:08 -0700
Subject: [PATCH WIP/RFC v3 4/6] nvme-rdma: destroy nvme queue rdma resources
 on connect failure
In-Reply-To: <cover.1472574410.git.swise@opengridcomputing.com>
References: <cover.1472574410.git.swise@opengridcomputing.com>
Message-ID: <6edabe2a9a4efba12b14102d10920eb3ae2c8087.1472574410.git.swise@opengridcomputing.com>

After address resolution, the nvme_rdma_queue rdma resources are
allocated.  If rdma route resolution or the connect fails, or the
controller reconnect times out and gives up, then the rdma resources
need to be freed.  Otherwise, rdma resources are leaked.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimbrg.me>
Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8d22b95..c2f6cc6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -87,6 +87,7 @@ struct nvme_rdma_request {
 
 enum nvme_rdma_queue_flags {
 	NVME_RDMA_Q_CONNECTED = (1 << 0),
+	NVME_RDMA_IB_QUEUE_ALLOCATED = (1 << 1),
 };
 
 struct nvme_rdma_queue {
@@ -488,6 +489,8 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
 
+	if (!test_and_clear_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags))
+		return;
 	rdma_destroy_qp(queue->cm_id);
 	ib_free_cq(queue->ib_cq);
 
@@ -538,6 +541,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue,
 		ret = -ENOMEM;
 		goto out_destroy_qp;
 	}
+	set_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags);
 
 	return 0;
 
@@ -595,6 +599,8 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 	return 0;
 
 out_destroy_cm_id:
+	if (test_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &ctrl->queues[0].flags))
+		nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
 	return ret;
 }
-- 
2.7.0
