From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 2 Sep 2016 09:01:27 -0700
Subject: [PATCH v5 4/6] nvme-rdma: destroy nvme queue rdma resources on
 connect failure
In-Reply-To: <cover.1472833420.git.swise@opengridcomputing.com>
References: <cover.1472833420.git.swise@opengridcomputing.com>
Message-ID: <7f9c2b9ac54d158d825dae89b48abdc5ed85043a.1472833420.git.swise@opengridcomputing.com>

After address resolution, the nvme_rdma_queue rdma resources are
allocated.  If rdma route resolution or the connect fails, or the
controller reconnect times out and gives up, then the rdma resources
need to be freed.  Otherwise, rdma resources are leaked.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimbrg.me>
Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 15b0c1d..a9d43f0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -82,6 +82,7 @@ struct nvme_rdma_request {
 
 enum nvme_rdma_queue_flags {
 	NVME_RDMA_Q_CONNECTED = (1 << 0),
+	NVME_RDMA_IB_QUEUE_ALLOCATED = (1 << 1),
 };
 
 struct nvme_rdma_queue {
@@ -480,9 +481,14 @@ out_err:
 
 static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 {
-	struct nvme_rdma_device *dev = queue->device;
-	struct ib_device *ibdev = dev->dev;
+	struct nvme_rdma_device *dev;
+	struct ib_device *ibdev;
 
+	if (!test_and_clear_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags))
+		return;
+
+	dev = queue->device;
+	ibdev = dev->dev;
 	rdma_destroy_qp(queue->cm_id);
 	ib_free_cq(queue->ib_cq);
 
@@ -533,6 +539,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue,
 		ret = -ENOMEM;
 		goto out_destroy_qp;
 	}
+	set_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags);
 
 	return 0;
 
@@ -590,6 +597,7 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 	return 0;
 
 out_destroy_cm_id:
+	nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
 	return ret;
 }
@@ -652,7 +660,7 @@ static int nvme_rdma_init_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return 0;
 
 out_free_queues:
-	for (; i >= 1; i--)
+	for (i--; i >= 1; i--)
 		nvme_rdma_stop_and_free_queue(&ctrl->queues[i]);
 
 	return ret;
-- 
2.7.0
