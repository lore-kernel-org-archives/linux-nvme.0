From: sashal@kernel.org (Sasha Levin)
Date: Wed, 12 Dec 2018 23:28:36 -0500
Subject: [PATCH AUTOSEL 4.19 71/73] nvmet-rdma: fix response use after free
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
Message-ID: <20181213042838.75160-71-sashal@kernel.org>

From: Israel Rukshin <israelr@mellanox.com>

[ Upstream commit d7dcdf9d4e15189ecfda24cc87339a3425448d5c ]

nvmet_rdma_release_rsp() may free the response before using it at error
flow.

Fixes: 8407879 ("nvmet-rdma: fix possible bogus dereference under heavy load")
Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/target/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index bfc4da660bb4..e57f3902beb3 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -529,6 +529,7 @@ static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_rsp *rsp =
 		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, send_cqe);
+	struct nvmet_rdma_queue *queue = cq->cq_context;
 
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
2.19.1
