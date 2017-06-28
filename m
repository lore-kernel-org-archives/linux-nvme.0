From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 28 Jun 2017 13:05:38 +0300
Subject: [PATCH 3/3] nvmet-rdma: remove redundant empty device add callout
In-Reply-To: <1498644338-19719-1-git-send-email-sagi@grimberg.me>
References: <1498644338-19719-1-git-send-email-sagi@grimberg.me>
Message-ID: <1498644338-19719-4-git-send-email-sagi@grimberg.me>

Now that its not needed, we can simply not assign it.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/rdma.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 56a4cba690b5..76d2bb793afe 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1510,10 +1510,6 @@ static struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
 };
 
-static void nvmet_rdma_add_one(struct ib_device *ib_device)
-{
-}
-
 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 {
 	struct nvmet_rdma_queue *queue;
@@ -1534,7 +1530,6 @@ static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data
 
 static struct ib_client nvmet_rdma_ib_client = {
 	.name   = "nvmet_rdma",
-	.add = nvmet_rdma_add_one,
 	.remove = nvmet_rdma_remove_one
 };
 
-- 
2.7.4
