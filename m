From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon,  6 Nov 2017 16:18:51 +0200
Subject: [PATCH 1/1] nvme-rdma: Fix nvme_rdma_create_queue_ib error flow
Message-ID: <1509977931-18160-1-git-send-email-maxg@mellanox.com>

QP object is created using rdma_cm api, therefore the destruction
should use the same api for symmetry.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0ebb539..957d626 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -493,7 +493,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return 0;
 
 out_destroy_qp:
-	ib_destroy_qp(queue->qp);
+	rdma_destroy_qp(queue->cm_id);
 out_destroy_ib_cq:
 	ib_free_cq(queue->ib_cq);
 out_put_dev:
-- 
1.8.3.1
