From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 26 Aug 2016 06:50:58 -0700
Subject: [PATCH WIP/RFC 4/6] nvme-rdma: destroy nvme queue rdma resources on
 connect failure
In-Reply-To: <cover.1472219585.git.swise@opengridcomputing.com>
References: <cover.1472219585.git.swise@opengridcomputing.com>
Message-ID: <9f6479110ae58e72e78e37855aff3f8edb8a61e9.1472219586.git.swise@opengridcomputing.com>

After address resolution, the nvme_rdma_queue rdma resources are
allocated.  If rdma route resolution or the connect fails, or the
controller reconnect times out and gives up, then the rdma resources
need to be freed.  Otherwise, rdma resources are leaked.

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 00943cd..8be7b6c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -87,6 +87,7 @@ struct nvme_rdma_request {
 
 enum nvme_rdma_queue_flags {
 	NVME_RDMA_Q_CONNECTED = (1 << 0),
+	NVME_RDMA_IB_QUEUE_ALLOCATED = (1 << 1),
 };
 
 struct nvme_rdma_queue {
@@ -488,6 +489,7 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
 
+	clear_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags);
 	rdma_destroy_qp(queue->cm_id);
 	ib_free_cq(queue->ib_cq);
 
@@ -538,6 +540,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue,
 		ret = -ENOMEM;
 		goto out_destroy_qp;
 	}
+	set_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags);
 
 	return 0;
 
@@ -595,6 +598,8 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 	return 0;
 
 out_destroy_cm_id:
+	if (test_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &ctrl->queues[0].flags))
+		nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
 	return ret;
 }
-- 
2.7.0
