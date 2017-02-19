From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 19 Feb 2017 20:04:38 +0100
Subject: [PATCH] nvmet-rdma: Fix error handling
Message-ID: <20170219190438.19371-1-christophe.jaillet@wanadoo.fr>

According to the surrounding goto, it is likely that 'out_destroy_sq' was
expected here.

Signed-off-by: Christophe JAILLET <christophe.jaillet at wanadoo.fr>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 60990220bd83..2ae63f7e17ed 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1091,7 +1091,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	queue->idx = ida_simple_get(&nvmet_rdma_queue_ida, 0, 0, GFP_KERNEL);
 	if (queue->idx < 0) {
 		ret = NVME_RDMA_CM_NO_RSC;
-		goto out_free_queue;
+		goto out_destroy_sq;
 	}
 
 	ret = nvmet_rdma_alloc_rsps(queue);
-- 
2.9.3
