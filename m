From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 22 Nov 2017 19:01:20 +0200
Subject: [PATCH v3 1/1] nvme-rdma: Fix memory leak during queue allocation
Message-ID: <1511370080-23326-1-git-send-email-maxg@mellanox.com>

In case nvme_rdma_wait_for_cm timeout expires before we get
an established or rejected event (rdma_connect succeeded) from
rdma_cm, we end up with leaking the ib transport resources for
dedicated queue. This scenario can easily reproduced using traffic
test during port toggling.
Also, in order to protect from parallel ib queue destruction, that
may be invoked from different context's, introduce new flag that
stands for transport readiness. While we're here, protect also against
a situation that we can receive rdma_cm events during ib queue destruction.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---

Changes from v1:
 - added new queue flag bit NVME_RDMA_Q_TR_READY to avoid parallel destruction
 - guarantee that cm_id destroyed before ib queue resources (from Sagi)
 - rebase over nvme-4.15

Changes from v2:
 - remove redundant code (from Sagi)

---
 drivers/nvme/host/rdma.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2c59710..98c9e0d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -73,6 +73,7 @@ struct nvme_rdma_request {
 enum nvme_rdma_queue_flags {
 	NVME_RDMA_Q_ALLOCATED		= 0,
 	NVME_RDMA_Q_LIVE		= 1,
+	NVME_RDMA_Q_TR_READY		= 2,
 };
 
 struct nvme_rdma_queue {
@@ -428,10 +429,16 @@ static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
 
 static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 {
-	struct nvme_rdma_device *dev = queue->device;
-	struct ib_device *ibdev = dev->dev;
+	struct nvme_rdma_device *dev;
+	struct ib_device *ibdev;
 
-	rdma_destroy_qp(queue->cm_id);
+	if (!test_and_clear_bit(NVME_RDMA_Q_TR_READY, &queue->flags))
+		return;
+
+	dev = queue->device;
+	ibdev = dev->dev;
+
+	ib_destroy_qp(queue->qp);
 	ib_free_cq(queue->ib_cq);
 
 	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
@@ -482,6 +489,8 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 		goto out_destroy_qp;
 	}
 
+	set_bit(NVME_RDMA_Q_TR_READY, &queue->flags);
+
 	return 0;
 
 out_destroy_qp:
@@ -546,6 +555,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 
 out_destroy_cm_id:
 	rdma_destroy_id(queue->cm_id);
+	nvme_rdma_destroy_queue_ib(queue);
 	return ret;
 }
 
-- 
1.8.3.1
