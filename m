From: maxg@mellanox.com (Max Gurtovoy)
Date: Sat,  4 Nov 2017 16:16:27 +0200
Subject: [PATCH v2 1/1] nvme-rdma: Introduce nvme_rdma_destroy_qp
Message-ID: <1509804987-656-1-git-send-email-maxg@mellanox.com>

QP object is created using rdma_cm api, therefore the destruction
should use the same api for symmetry.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---

Changes from v1:
 - rebase against nvme-4.15

---
 drivers/nvme/host/rdma.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 03644ec..ae3e4d6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -266,6 +266,12 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 	return ret;
 }
 
+static void nvme_rdma_destroy_qp(struct nvme_rdma_queue *queue)
+{
+	rdma_destroy_qp(queue->cm_id);
+	queue->qp = NULL;
+}
+
 static int nvme_rdma_reinit_request(void *data, struct request *rq)
 {
 	struct nvme_rdma_ctrl *ctrl = data;
@@ -439,7 +445,7 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
 
-	rdma_destroy_qp(queue->cm_id);
+	nvme_rdma_destroy_qp(queue);
 	ib_free_cq(queue->ib_cq);
 
 	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
@@ -493,7 +499,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return 0;
 
 out_destroy_qp:
-	ib_destroy_qp(queue->qp);
+	nvme_rdma_destroy_qp(queue);
 out_destroy_ib_cq:
 	ib_free_cq(queue->ib_cq);
 out_put_dev:
-- 
1.7.1
