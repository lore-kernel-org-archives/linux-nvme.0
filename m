From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 14:59:56 -0400
Subject: [PATCH 05/20] nvmet: add NVMe I/O command handlers for file
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-6-chaitanya.kulkarni@wdc.com>

This patch implements the target side NVMe IO command
support for the file backed namespaces.

For NVMe read and write command we use asynchronous direct I/O.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/io-cmd.c | 146 +++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/target/nvmet.h  |   1 +
 2 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 28bbdff4a88b..7791a63e38ab 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -14,8 +14,11 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/blkdev.h>
 #include <linux/module.h>
+#include <linux/uio.h>
 #include "nvmet.h"
 
+#define NR_BVEC(req)	(req->data_len / PAGE_SIZE)
+
 static void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
@@ -89,6 +92,69 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
 }
 
+static void nvmet_file_io_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct nvmet_req *req = container_of(iocb, struct nvmet_req, iocb);
+
+	kfree(req->bvec);
+	req->bvec = NULL;
+	nvmet_req_complete(req, ret != req->data_len ?
+			NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+}
+
+static void nvmet_execute_rw_file(struct nvmet_req *req)
+{
+	struct iov_iter iter;
+	struct sg_mapping_iter miter;
+	loff_t pos;
+	ssize_t len = 0, ret;
+	int ki_flags = IOCB_DIRECT;
+	int bv_cnt = 0, rw = READ;
+
+	if (req->cmd->rw.opcode == nvme_cmd_write) {
+		rw = WRITE;
+		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
+			ki_flags |= IOCB_DSYNC;
+	}
+
+	req->bvec = kmalloc_array(NR_BVEC(req), sizeof(struct bio_vec),
+			GFP_KERNEL);
+	if (!req->bvec)
+		goto out;
+
+	sg_miter_start(&miter, req->sg, req->sg_cnt, SG_MITER_FROM_SG);
+	while (sg_miter_next(&miter)) {
+		req->bvec[bv_cnt].bv_page = miter.page;
+		req->bvec[bv_cnt].bv_offset = miter.__offset;
+		req->bvec[bv_cnt].bv_len = miter.length;
+		len += req->bvec[bv_cnt].bv_len;
+		bv_cnt++;
+	}
+	sg_miter_stop(&miter);
+	if (len != req->data_len)
+		goto free;
+
+	iov_iter_bvec(&iter, ITER_BVEC | rw, req->bvec, bv_cnt, len);
+	pos = le64_to_cpu(req->cmd->rw.slba) * (1 << (req->ns->blksize_shift));
+	req->iocb.ki_pos = pos;
+	req->iocb.ki_filp = req->ns->filp;
+	req->iocb.ki_flags = ki_flags;
+	req->iocb.ki_complete = nvmet_file_io_complete;
+
+	if (rw == WRITE)
+		ret = call_write_iter(req->ns->filp, &req->iocb, &iter);
+	else
+		ret = call_read_iter(req->ns->filp, &req->iocb, &iter);
+
+	if (ret != -EIOCBQUEUED)
+		nvmet_file_io_complete(&req->iocb, ret, 0);
+	return;
+free:
+	kfree(req->bvec);
+out:
+	nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
+}
+
 static void nvmet_execute_flush(struct nvmet_req *req)
 {
 	struct bio *bio = &req->inline_bio;
@@ -102,6 +168,13 @@ static void nvmet_execute_flush(struct nvmet_req *req)
 	submit_bio(bio);
 }
 
+static void nvmet_execute_flush_file(struct nvmet_req *req)
+{
+	int ret = vfs_fsync(req->ns->filp, 1);
+
+	nvmet_req_complete(req, ret);
+}
+
 static u16 nvmet_discard_range(struct nvmet_ns *ns,
 		struct nvme_dsm_range *range, struct bio **bio)
 {
@@ -163,6 +236,43 @@ static void nvmet_execute_dsm(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_execute_discard_file(struct nvmet_req *req)
+{
+	struct nvme_dsm_range range;
+	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
+	loff_t offset;
+	loff_t len;
+	int i, ret;
+
+	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
+		if (nvmet_copy_from_sgl(req, i * sizeof(range), &range,
+					sizeof(range)))
+			break;
+		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
+		len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
+		ret = vfs_fallocate(req->ns->filp, mode, offset, len);
+		if (ret)
+			break;
+	}
+
+	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+}
+
+static void nvmet_execute_dsm_file(struct nvmet_req *req)
+{
+	switch (le32_to_cpu(req->cmd->dsm.attributes)) {
+	case NVME_DSMGMT_AD:
+		nvmet_execute_discard_file(req);
+		return;
+	case NVME_DSMGMT_IDR:
+	case NVME_DSMGMT_IDW:
+	default:
+		/* Not supported yet */
+		nvmet_req_complete(req, 0);
+		return;
+	}
+}
+
 static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 {
 	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
@@ -189,6 +299,22 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_execute_write_zeroes_file(struct nvmet_req *req)
+{
+	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
+	loff_t offset;
+	loff_t len;
+	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
+	int ret;
+
+	offset = le64_to_cpu(write_zeroes->slba) << req->ns->blksize_shift;
+	len = (((sector_t)le32_to_cpu(write_zeroes->length) + 1) <<
+			req->ns->blksize_shift);
+
+	ret = vfs_fallocate(req->ns->filp, mode, offset, len);
+	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+}
+
 u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -207,20 +333,32 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
-		req->execute = nvmet_execute_rw;
+		if (req->ns->filp)
+			req->execute = nvmet_execute_rw_file;
+		else
+			req->execute = nvmet_execute_rw;
 		req->data_len = nvmet_rw_len(req);
 		return 0;
 	case nvme_cmd_flush:
-		req->execute = nvmet_execute_flush;
+		if (req->ns->filp)
+			req->execute = nvmet_execute_flush_file;
+		else
+			req->execute = nvmet_execute_flush;
 		req->data_len = 0;
 		return 0;
 	case nvme_cmd_dsm:
-		req->execute = nvmet_execute_dsm;
+		if (req->ns->filp)
+			req->execute = nvmet_execute_dsm_file;
+		else
+			req->execute = nvmet_execute_dsm;
 		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
 			sizeof(struct nvme_dsm_range);
 		return 0;
 	case nvme_cmd_write_zeroes:
-		req->execute = nvmet_execute_write_zeroes;
+		if (req->ns->filp)
+			req->execute = nvmet_execute_write_zeroes_file;
+		else
+			req->execute = nvmet_execute_write_zeroes;
 		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index acc61ca97198..21825b4a222a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -27,6 +27,7 @@
 #include <linux/rcupdate.h>
 #include <linux/blkdev.h>
 #include <linux/fs.h>
+#include <linux/falloc.h>
 
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
-- 
2.14.1
