From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 29 Mar 2018 10:07:18 -0600
Subject: [PATCH 1/4] nvmet: Introduce helper functions to allocate and free
 request SGLs
In-Reply-To: <20180329160721.4691-1-logang@deltatee.com>
References: <20180329160721.4691-1-logang@deltatee.com>
Message-ID: <20180329160721.4691-2-logang@deltatee.com>

Add helpers to allocate and free the SGL in a struct nvmet_req:

int nvmet_req_alloc_sgl(struct nvmet_req *req, struct nvmet_sq *sq)
void nvmet_req_free_sgl(struct nvmet_req *req)

This will be expanded in a future patch to implement peer-to-peer
memory and should be common with all target drivers. The presently
unused sq argument in the alloc function will be necessary to
decide whether to use peer-to-peer memory and obtain the correct
provider to allocate the memory.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/core.c  | 16 ++++++++++++++++
 drivers/nvme/target/nvmet.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a78029e4e5f4..3770fb812657 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -575,6 +575,22 @@ void nvmet_req_execute(struct nvmet_req *req)
 }
 EXPORT_SYMBOL_GPL(nvmet_req_execute);
 
+int nvmet_req_alloc_sgl(struct nvmet_req *req, struct nvmet_sq *sq)
+{
+	req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
+	if (!req->sg)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgl);
+
+void nvmet_req_free_sgl(struct nvmet_req *req)
+{
+	sgl_free(req->sg);
+}
+EXPORT_SYMBOL_GPL(nvmet_req_free_sgl);
+
 static inline bool nvmet_cc_en(u32 cc)
 {
 	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 417f6c0331cc..6f74cb2b7e37 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -271,6 +271,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 void nvmet_req_uninit(struct nvmet_req *req);
 void nvmet_req_execute(struct nvmet_req *req);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
+int nvmet_req_alloc_sgl(struct nvmet_req *req, struct nvmet_sq *sq);
+void nvmet_req_free_sgl(struct nvmet_req *req);
 
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
-- 
2.11.0
