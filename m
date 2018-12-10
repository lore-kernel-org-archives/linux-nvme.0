From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun,  9 Dec 2018 21:50:06 -0800
Subject: [PATCH 07/12] nvmet: add error log support for file backend
In-Reply-To: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181210055011.3146-8-chaitanya.kulkarni@wdc.com>

This patch adds support for the file backend to populate the
error log entries. Here we map the errno to the NVMe status codes.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c        | 42 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c | 35 +++++++++++++++-----------
 drivers/nvme/target/nvmet.h       |  2 ++
 3 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5f0b281945e4..dee691f6e3b3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -45,6 +45,48 @@ u32 nvmet_ana_group_enabled[NVMET_MAX_ANAGRPS + 1];
 u64 nvmet_ana_chgcnt;
 DECLARE_RWSEM(nvmet_ana_sem);
 
+inline u16 errno_to_nvme_status(struct nvmet_req *req, int errno)
+{
+	u16 status;
+
+	switch (errno) {
+	case -ENOSPC:
+		req->error_loc = offsetof(struct nvme_rw_command, length);
+		status = NVME_SC_CAP_EXCEEDED | NVME_SC_DNR;
+		break;
+	case -EREMOTEIO:
+		req->error_loc = offsetof(struct nvme_rw_command, slba);
+		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		break;
+	case -EOPNOTSUPP:
+		req->error_loc = offsetof(struct nvme_common_command, opcode);
+		switch (req->cmd->common.opcode) {
+		case nvme_cmd_dsm:
+		case nvme_cmd_write_zeroes:
+			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_SC_DNR;
+			break;
+		default:
+			status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		}
+		break;
+	case -ENODATA:
+		req->error_loc = offsetof(struct nvme_rw_command, nsid);
+		status = NVME_SC_ACCESS_DENIED;
+		break;
+	case -EILSEQ:
+		req->error_loc = offsetof(struct nvme_rw_command, nsid);
+		status = NVME_SC_INVALID_PI;
+		break;
+	case -EIO:
+		/* FALLTHRU */
+	default:
+		req->error_loc = offsetof(struct nvme_common_command, opcode);
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+	}
+
+	return status;
+}
+
 static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		const char *subsysnqn);
 
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 12eaa8ddc248..517522305e5c 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -112,6 +112,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
 {
 	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
+	u16 status = NVME_SC_SUCCESS;
 
 	if (req->f.bvec != req->inline_bvec) {
 		if (likely(req->f.mpool_alloc == false))
@@ -120,8 +121,9 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
 			mempool_free(req->f.bvec, req->ns->bvec_pool);
 	}
 
-	nvmet_req_complete(req, ret != req->data_len ?
-			NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+	if (unlikely(ret != req->data_len))
+		status = errno_to_nvme_status(req, ret);
+	nvmet_req_complete(req, status);
 }
 
 static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
@@ -140,7 +142,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 
 	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
 	if (unlikely(pos + req->data_len > req->ns->size)) {
-		nvmet_req_complete(req, NVME_SC_LBA_RANGE | NVME_SC_DNR);
+		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
 		return true;
 	}
 
@@ -254,9 +256,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 u16 nvmet_file_flush(struct nvmet_req *req)
 {
-	if (vfs_fsync(req->ns->file, 1) < 0)
-		return NVME_SC_INTERNAL | NVME_SC_DNR;
-	return 0;
+	return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
 }
 
 static void nvmet_file_flush_work(struct work_struct *w)
@@ -277,30 +277,34 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
 	struct nvme_dsm_range range;
 	loff_t offset, len;
-	u16 ret;
+	u16 status = 0;
+	int ret;
 	int i;
 
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
-		ret = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
+		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
 					sizeof(range));
-		if (ret)
+		if (status)
 			break;
 
 		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
 		len = le32_to_cpu(range.nlb);
 		len <<= req->ns->blksize_shift;
 		if (offset + len > req->ns->size) {
-			ret = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+			req->error_slba = le64_to_cpu(range.slba);
+			status = errno_to_nvme_status(req, -ENOSPC);
 			break;
 		}
 
-		if (vfs_fallocate(req->ns->file, mode, offset, len)) {
-			ret = NVME_SC_INTERNAL | NVME_SC_DNR;
+		ret = vfs_fallocate(req->ns->file, mode, offset, len);
+		if (ret) {
+			req->error_slba = le64_to_cpu(range.slba);
+			status = errno_to_nvme_status(req, ret);
 			break;
 		}
 	}
 
-	nvmet_req_complete(req, ret);
+	nvmet_req_complete(req, status);
 }
 
 static void nvmet_file_dsm_work(struct work_struct *w)
@@ -340,12 +344,12 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 			req->ns->blksize_shift);
 
 	if (unlikely(offset + len > req->ns->size)) {
-		nvmet_req_complete(req, NVME_SC_LBA_RANGE | NVME_SC_DNR);
+		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
 		return;
 	}
 
 	ret = vfs_fallocate(req->ns->file, mode, offset, len);
-	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);
 }
 
 static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
@@ -380,6 +384,7 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	default:
 		pr_err("unhandled cmd for file ns %d on qid %d\n",
 				cmd->common.opcode, req->sq->qid);
+		req->error_loc = offsetof(struct nvme_common_command, opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 662def80ff23..03f91cd3c24d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -494,4 +494,6 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
 			req->ns->blksize_shift;
 }
+
+u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
 #endif /* _NVMET_H */
-- 
2.17.0
