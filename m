From: israelr@mellanox.com (Israel Rukshin)
Date: Mon,  3 Dec 2018 15:50:04 +0000
Subject: [PATCH 1/2] nvmet-rdma: Fix response use after free
Message-ID: <1543852205-776-1-git-send-email-israelr@mellanox.com>

nvmet_rdma_release_rsp() may free the response before using it at error flow.

Fixes: 8407879 ("nvmet-rdma: fix possible bogus dereference under heavy load")
Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 3f7971d3..732806a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -529,6 +529,7 @@ static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_rsp *rsp =
 		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, send_cqe);
+	struct nvmet_rdma_queue *queue = rsp->queue;
 
 	nvmet_rdma_release_rsp(rsp);
 
@@ -536,7 +537,7 @@ static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
 		     wc->status != IB_WC_WR_FLUSH_ERR)) {
 		pr_err("SEND for CQE 0x%p failed with status %s (%d).\n",
 			wc->wr_cqe, ib_wc_status_msg(wc->status), wc->status);
-		nvmet_rdma_error_comp(rsp->queue);
+		nvmet_rdma_error_comp(queue);
 	}
 }
 
-- 
1.8.3.1
