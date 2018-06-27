From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 27 Jun 2018 14:58:02 +0300
Subject: [PATCH 1/1] nvmet-rdma: add unlikely check in the fast path
Message-ID: <1530100682-24139-1-git-send-email-maxg@mellanox.com>

ib_post_send operation should succeed unless something unusual
happened to the ib device.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 88d9f82..ac4fdab 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -501,7 +501,7 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
 		rsp->send_sge.addr, rsp->send_sge.length,
 		DMA_TO_DEVICE);
 
-	if (ib_post_send(cm_id->qp, first_wr, &bad_wr)) {
+	if (unlikely(ib_post_send(cm_id->qp, first_wr, &bad_wr))) {
 		pr_err("sending cmd response failed\n");
 		nvmet_rdma_release_rsp(rsp);
 	}
-- 
1.8.3.1
