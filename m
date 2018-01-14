From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 18:34:22 +0200
Subject: [PATCH] nvmet: release a ns reference in nvmet_req_uninit if needed
Message-ID: <20180114163422.20140-1-sagi@grimberg.me>

nvmet_req_init looked up a namespace and took a reference on it (unless it
failed prior to that). If the request is uninitialized (in error cases) we
need to remove that reference in case it was taken, otherwise we leak
namespace reference when calling nvme_req_uninit.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1e0554d14886..4b9615f25128 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -521,6 +521,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->sg_cnt = 0;
 	req->transfer_len = 0;
 	req->rsp->status = 0;
+	req->ns = NULL;
 
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
@@ -569,6 +570,8 @@ EXPORT_SYMBOL_GPL(nvmet_req_init);
 void nvmet_req_uninit(struct nvmet_req *req)
 {
 	percpu_ref_put(&req->sq->ref);
+	if (req->ns)
+		nvmet_put_namespace(req->ns);
 }
 EXPORT_SYMBOL_GPL(nvmet_req_uninit);
 
-- 
2.14.1
