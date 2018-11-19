From: israelr@mellanox.com (Israel Rukshin)
Date: Mon, 19 Nov 2018 10:58:51 +0000
Subject: [PATCH 1/2] nvmet-rdma: Add unlikely for response allocated check
Message-ID: <1542625132-21714-1-git-send-email-israelr@mellanox.com>

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 3f7971d3..932242e 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -196,7 +196,7 @@ static inline bool nvmet_rdma_need_data_out(struct nvmet_rdma_rsp *rsp)
 {
 	unsigned long flags;
 
-	if (rsp->allocated) {
+	if (unlikely(rsp->allocated)) {
 		kfree(rsp);
 		return;
 	}
-- 
1.8.3.1
