From: roysh@mellanox.com (Roy Shterman)
Date: Mon,  8 Aug 2016 14:00:19 +0300
Subject: [RFC 2/2] nvmet-rdma: Matching rdma WC to rdma queue according to WC
 QP
In-Reply-To: <1470654019-717-1-git-send-email-roysh@mellanox.com>
References: <1470654019-717-1-git-send-email-roysh@mellanox.com>
Message-ID: <1470654019-717-2-git-send-email-roysh@mellanox.com>

Today when assiging rdma_nvme_queue to rdma work complition we use
cq_context which is passed as queue pointer when creating the CQ.
In case we will want to aggregate few QP to one CQ this method will
not work, hence it will be better if we will use QP context instead.

Signed-off-by: Roy Shterman <roysh at mellanox.com>
---
 drivers/nvme/target/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e06d504..164b1a2 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -547,7 +547,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_rsp *rsp =
 		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, read_cqe);
-	struct nvmet_rdma_queue *queue = cq->cq_context;
+	struct nvmet_rdma_queue *queue = wc->qp->qp_context;
 
 	WARN_ON(rsp->n_rdma <= 0);
 	atomic_add(rsp->n_rdma, &queue->sq_wr_avail);
@@ -726,7 +726,7 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_cmd *cmd =
 		container_of(wc->wr_cqe, struct nvmet_rdma_cmd, cqe);
-	struct nvmet_rdma_queue *queue = cq->cq_context;
+	struct nvmet_rdma_queue *queue = wc->qp->qp_context;
 	struct nvmet_rdma_rsp *rsp;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
-- 
1.8.3.1
