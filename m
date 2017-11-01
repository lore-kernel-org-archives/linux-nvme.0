From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed,  1 Nov 2017 14:51:46 +0200
Subject: [PATCH 1/1] nvme-rdma: Introduce nvme_rdma_destroy_qp
Message-ID: <1509540706-26130-1-git-send-email-maxg@mellanox.com>

QP object is created using rdma_cm api, therefore the destruction
should use the same api for symmetry.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 87bac27..d955cbc 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -267,6 +267,12 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
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
 
 	dev = queue->device;
 	ibdev = dev->dev;
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
