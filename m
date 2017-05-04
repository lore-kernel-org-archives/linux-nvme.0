From: vijayi@attalasystems.com (Vijay Immanuel)
Date: Thu, 4 May 2017 15:51:09 -0700
Subject: [PATCH] nvmet: release the sq ref on rdma read errors
In-Reply-To: <5e0ca611-97d8-8884-abc3-c0f3b6172a21@grimberg.me>
References: <CAN9s3O597CB9d2BoPx1gL5a7NnqhxrXYMhE==Q3E8+BoDxRFiQ@mail.gmail.com>
 <01cb01d2c446$20cd83a0$62688ae0$@attalasystems.com>
 <01d601d2c446$b087cb90$119762b0$@attalasystems.com>
 <da2ec86f-3c22-30a0-0e9b-f4c0fdf5eabb@grimberg.me>
 <00d6f8bf-07bd-03ca-3060-fd3def1ef1d7@grimberg.me>
 <20170504085631.GA5584@lst.de>
 <5e0ca611-97d8-8884-abc3-c0f3b6172a21@grimberg.me>
Message-ID: <014901d2c528$ec347430$c49d5c90$@attalasystems.com>

Thanks for the feedback. Here's an updated patch.
----

On rdma read errors, release the sq ref that was taken
when the req was initialized. This avoids a hang in
nvmet_sq_destroy() when the queue is being freed.

Signed-off-by: Vijay Immanuel <vijayi at attalasystems.com>
---
 drivers/nvme/target/core.c  | 6 ++++++
 drivers/nvme/target/nvmet.h | 1 +
 drivers/nvme/target/rdma.c  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 798653b..fcb2906 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -529,6 +529,12 @@ bool nvmet_req_init(struct nvmet_req *req, struct
nvmet_cq *cq,
 }
 EXPORT_SYMBOL_GPL(nvmet_req_init);

+void nvmet_req_uninit(struct nvmet_req *req)
+{
+       percpu_ref_put(&req->sq->ref);
+}
+EXPORT_SYMBOL_GPL(nvmet_req_uninit);
+
 static inline bool nvmet_cc_en(u32 cc)
 {
        return cc & 0x1;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f7ff15f..dae9ed6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -261,6 +261,7 @@ struct nvmet_async_event {

 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
                struct nvmet_sq *sq, struct nvmet_fabrics_ops *ops);
+void nvmet_req_uninit(struct nvmet_req *req);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);

 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ecc4fe8..8fc245d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -567,6 +567,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq,
struct ib_wc *wc)
        rsp->n_rdma = 0;

        if (unlikely(wc->status != IB_WC_SUCCESS)) {
+               nvmet_req_uninit(&rsp->req);
                nvmet_rdma_release_rsp(rsp);
                if (wc->status != IB_WC_WR_FLUSH_ERR) {
                        pr_info("RDMA READ for CQE 0x%p failed with status
%s (%d).\n",
--
1.8.3.1


-----Original Message-----
From: Sagi Grimberg [mailto:sagi@grimberg.me] 
Sent: Thursday, May 4, 2017 3:46 AM
To: Christoph Hellwig <hch at lst.de>; Vijay Immanuel
<vijayi at attalasystems.com>
Cc: linux-nvme at lists.infradead.org; Steve Wise <swise at chelsio.com>
Subject: Re: [PATCH] nvmet: release the sq ref on rdma read errors


>> While it is true that we need to drop the reference on the nvmet_sq, 
>> there is no point in queuing a response message because the rdma qp 
>> is in error state and the response will never make it to the host.
>
> Yeah.
>
>> I think we should explicitly drop the sq reference and release the 
>> rsp and avoid triggering the TX path, and provide a detailed comment 
>> on why we are doing this. Maybe a nicer way to do this, is to 
>> introduce a nvme_req_uninit() that would take care of it in the right 
>> layer (that is nvmet core).
>
> Agreed.

Vijay, care to respin the fix?
