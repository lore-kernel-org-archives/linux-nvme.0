From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 27 Apr 2017 20:04:14 -0700
Subject: [PATCH v2] nvmet core: skip flags checks on fabric commands
Message-ID: <20170428030414.27185-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

The core layer validates nvme command flags (w0 byte 1) values before
decoding opcodes. On fabric commands the flags field is reserved.
Current validations require NVME_CMD_SGL_METABUF or NVME_CMD_SGL_METASEG
to be set. If host sets flags to 0 as reserved field, command fails.

Exclude fabric commands from flags checks.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/core.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cf90713..6861ae2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -475,6 +475,20 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 }
 EXPORT_SYMBOL_GPL(nvmet_sq_init);
 
+static u16 nvmet_req_validate_flags(u8 flags)
+{
+	/* no support for fused commands yet */
+	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND)))
+		return (NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+
+	/* either variant of SGLs is fine, as we don't support metadata */
+	if (unlikely((flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METABUF &&
+		     (flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METASEG))
+		return (NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+
+	return 0;
+}
+
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, struct nvmet_fabrics_ops *ops)
 {
@@ -488,17 +502,11 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->sg_cnt = 0;
 	req->rsp->status = 0;
 
-	/* no support for fused commands yet */
-	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		goto fail;
-	}
-
-	/* either variant of SGLs is fine, as we don't support metadata */
-	if (unlikely((flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METABUF &&
-		     (flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METASEG)) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		goto fail;
+	/* validate flags except on fabric commands, where field is rsvd */
+	if (req->cmd->common.opcode != nvme_fabrics_command) {
+		status = nvmet_req_validate_flags(flags);
+		if (status)
+			goto fail;
 	}
 
 	if (unlikely(!req->sq->ctrl))
-- 
2.9.3
