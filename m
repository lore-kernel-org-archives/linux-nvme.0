From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun,  9 Dec 2018 21:50:04 -0800
Subject: [PATCH 05/12] nvmet: add error log support in the core
In-Reply-To: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181210055011.3146-6-chaitanya.kulkarni@wdc.com>

This patch adds the support to maintain error log page for the
nvmet-core.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4fe70fc322b4..5f0b281945e4 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -51,22 +51,28 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off, const void *buf,
 		size_t len)
 {
-	if (sg_pcopy_from_buffer(req->sg, req->sg_cnt, buf, len, off) != len)
+	if (sg_pcopy_from_buffer(req->sg, req->sg_cnt, buf, len, off) != len) {
+		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+	}
 	return 0;
 }
 
 u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf, size_t len)
 {
-	if (sg_pcopy_to_buffer(req->sg, req->sg_cnt, buf, len, off) != len)
+	if (sg_pcopy_to_buffer(req->sg, req->sg_cnt, buf, len, off) != len) {
+		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+	}
 	return 0;
 }
 
 u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
 {
-	if (sg_zero_buffer(req->sg, req->sg_cnt, len, off) != len)
+	if (sg_zero_buffer(req->sg, req->sg_cnt, len, off) != len) {
+		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+	}
 	return 0;
 }
 
@@ -768,14 +774,20 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 		return ret;
 
 	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
-	if (unlikely(!req->ns))
+	if (unlikely(!req->ns)) {
+		req->error_loc = offsetof(struct nvme_common_command, nsid);
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+	}
 	ret = nvmet_check_ana_state(req->port, req->ns);
-	if (unlikely(ret))
+	if (unlikely(ret)) {
+		req->error_loc = offsetof(struct nvme_common_command, nsid);
 		return ret;
+	}
 	ret = nvmet_io_cmd_check_access(req);
-	if (unlikely(ret))
+	if (unlikely(ret)) {
+		req->error_loc = offsetof(struct nvme_common_command, nsid);
 		return ret;
+	}
 
 	if (req->ns->file)
 		return nvmet_file_parse_io_cmd(req);
@@ -803,6 +815,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
+		req->error_loc = offsetof(struct nvme_common_command, flags);
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto fail;
 	}
@@ -813,6 +826,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	 * byte aligned.
 	 */
 	if (unlikely((flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METABUF)) {
+		req->error_loc = offsetof(struct nvme_common_command, flags);
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto fail;
 	}
@@ -858,9 +872,10 @@ EXPORT_SYMBOL_GPL(nvmet_req_uninit);
 
 void nvmet_req_execute(struct nvmet_req *req)
 {
-	if (unlikely(req->data_len != req->transfer_len))
+	if (unlikely(req->data_len != req->transfer_len)) {
+		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
-	else
+	} else
 		req->execute(req);
 }
 EXPORT_SYMBOL_GPL(nvmet_req_execute);
-- 
2.17.0
