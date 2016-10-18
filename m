From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Oct 2016 12:59:47 -0700
Subject: [PATCH] nvmet-rdma: Fix REJ status code
Message-ID: <10b8f472-ea1b-5449-e24a-f6bbee8a4d54@sandisk.com>

nvmet_sq_init() returns a value <= 0. nvmet_rdma_cm_reject() expects
a second argument that is a NVME_RDMA_CM_* constant. Hence this patch.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
---
 drivers/nvme/target/rdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index f8d2399..35b97a8 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1044,8 +1044,10 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	}
 
 	ret = nvmet_sq_init(&queue->nvme_sq);
-	if (ret)
+	if (ret) {
+		ret = NVME_RDMA_CM_NO_RSC;
 		goto out_free_queue;
+	}
 
 	ret = nvmet_rdma_parse_cm_connect_req(&event->param.conn, queue);
 	if (ret)
@@ -1114,6 +1116,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 out_free_queue:
 	kfree(queue);
 out_reject:
+	pr_debug("rejecting connect request with status code %d\n", ret);
 	nvmet_rdma_cm_reject(cm_id, ret);
 	return NULL;
 }
-- 
2.10.1
