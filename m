From: vijayi@attalasystems.com (Vijay Immanuel)
Date: Wed, 3 May 2017 12:51:42 -0700
Subject: [PATCH] nvmet: release the sq ref on rdma read errors
In-Reply-To: <01cb01d2c446$20cd83a0$62688ae0$@attalasystems.com>
References: <CAN9s3O597CB9d2BoPx1gL5a7NnqhxrXYMhE==Q3E8+BoDxRFiQ@mail.gmail.com>
 <01cb01d2c446$20cd83a0$62688ae0$@attalasystems.com>
Message-ID: <01d601d2c446$b087cb90$119762b0$@attalasystems.com>

On rdma read errors, complete the req and release the sq ref that
was taken when the req was initialized. This avoids a hang in
nvmet_sq_destroy() when the queue is being freed.

Signed-off-by: Vijay Immanuel <vijayi at attalasystems.com>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ecc4fe8..cf98f0b 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -567,7 +567,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
        rsp->n_rdma = 0;

        if (unlikely(wc->status != IB_WC_SUCCESS)) {
-               nvmet_rdma_release_rsp(rsp);
+               nvmet_req_complete(&rsp->req, NVME_SC_DATA_XFER_ERROR);
                if (wc->status != IB_WC_WR_FLUSH_ERR) {
                        pr_info("RDMA READ for CQE 0x%p failed with status %s (%d).\n",
                                wc->wr_cqe, ib_wc_status_msg(wc->status), wc->status);
--
1.8.3.1
