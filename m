From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  4 Dec 2017 10:47:10 +0200
Subject: [PATCH 2/2] nvmet-rdma: lowering log level for chatty debug messages
In-Reply-To: <20171204084710.15828-1-sagi@grimberg.me>
References: <20171204084710.15828-1-sagi@grimberg.me>
Message-ID: <20171204084710.15828-2-sagi@grimberg.me>

Its a bit chatty to report on every deleted queue, so
keeping it dor debug purposes only.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 49912909c298..1d98aa125b6d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -976,7 +976,7 @@ static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
 
 static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 {
-	pr_info("freeing queue %d\n", queue->idx);
+	pr_debug("freeing queue %d\n", queue->idx);
 
 	nvmet_sq_destroy(&queue->nvme_sq);
 
-- 
2.14.1
