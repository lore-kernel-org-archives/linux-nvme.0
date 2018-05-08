From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue,  8 May 2018 01:38:29 -0400
Subject: [PATCH V3] nvmet: add simple file backed ns support
Message-ID: <20180508053829.406-1-chaitanya.kulkarni@wdc.com>

This patch adds simple file backed namespace support for
NVMeOF target.

In current implementation NVMeOF supports block
device backed namespaces on the target side.
With this implementation regular file(s) can be used to
initialize the namespace(s) via target side configfs
interface.

For admin smart log command on the target side, we only use
block device backed namespaces to compute target
side smart log.

We isolate the code for each ns handle type
(file/block device) and add wrapper routines to manipulate
the respective ns handle types.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Changed since V2:-
1. Adjust this patch for 4.17.0-rc4.

Changes since V1:-
1. Replace filp to file, filp_close to fput, call_[read|write]_iter()
   to [read|write]_iter().
2. Add code for the offloading flush operation for file-backed ns.
3. Aggregate the patches for O_DIRECT implementation.
4. Use inline bvec for smaller I/Os for file-backed ns.
5. Use file_inode() instead of open coding.
6. Get rid of bvec calculation macro and use DIV_ROUND_UP
   for the number of bvec calculation.
7. Avoid multiplication on the IO code patch.
8. Remove the req->bvec = NULL in IO completion callback.
9. Remove the sg mapping iterator and use simple for_each_sg_page()
   to iterate the pages.
---
 drivers/nvme/target/admin-cmd.c |   9 +++
 drivers/nvme/target/core.c      |  97 ++++++++++++++++++++-----
 drivers/nvme/target/io-cmd.c    | 155 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/target/nvmet.h     |   6 ++
 4 files changed, 246 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5e0e9fc..7ae37b3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -45,6 +45,10 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		return NVME_SC_INVALID_NS;
 	}
 
+	/* for file backed ns just return */
+	if (!ns->bdev)
+		goto out;
+
 	host_reads = part_stat_read(ns->bdev->bd_part, ios[READ]);
 	data_units_read = part_stat_read(ns->bdev->bd_part, sectors[READ]);
 	host_writes = part_stat_read(ns->bdev->bd_part, ios[WRITE]);
@@ -54,6 +58,8 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
 	put_unaligned_le64(host_writes, &slog->host_writes[0]);
 	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
+
+out:
 	nvmet_put_namespace(ns);
 
 	return NVME_SC_SUCCESS;
@@ -71,6 +77,9 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
+		/* for file backed ns just return */
+		if (!ns->bdev)
+			continue;
 		host_reads += part_stat_read(ns->bdev->bd_part, ios[READ]);
 		data_units_read +=
 			part_stat_read(ns->bdev->bd_part, sectors[READ]);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95424f..8d87356 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -271,6 +271,78 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
 	percpu_ref_put(&ns->ref);
 }
 
+static int nvmet_ns_enable_blk(struct nvmet_ns *ns)
+{
+	int blk_flags = FMODE_READ | FMODE_WRITE;
+
+	ns->bdev = blkdev_get_by_path(ns->device_path, blk_flags, NULL);
+	if (IS_ERR(ns->bdev)) {
+		pr_err("failed to open block device %s: (%ld)\n",
+				ns->device_path, PTR_ERR(ns->bdev));
+		ns->bdev = NULL;
+		return -1;
+	}
+	ns->size = i_size_read(ns->bdev->bd_inode);
+	ns->blksize_shift =
+		blksize_bits(bdev_logical_block_size(ns->bdev));
+
+	return 0;
+}
+
+static int nvmet_ns_enable_file(struct nvmet_ns *ns)
+{
+	int ret;
+	int flags = O_RDWR | O_LARGEFILE | O_DIRECT;
+	struct kstat stat;
+
+	ns->file = filp_open(ns->device_path, flags, 0);
+	if (!ns->file || IS_ERR(ns->file)) {
+		pr_err("failed to open file %s: (%ld)\n",
+				ns->device_path, PTR_ERR(ns->bdev));
+		ns->file = NULL;
+		return -1;
+	}
+
+	ret = vfs_getattr(&ns->file->f_path,
+			&stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		goto err;
+
+	ns->size = stat.size;
+	ns->blksize_shift = file_inode(ns->file)->i_blkbits;
+
+	return ret;
+err:
+	fput(ns->file);
+	ns->size = ns->blksize_shift = 0;
+	ns->file = NULL;
+
+	return ret;
+}
+
+static int nvmet_ns_dev_enable(struct nvmet_ns *ns)
+{
+	int ret = 0;
+
+	ret = nvmet_ns_enable_blk(ns);
+	if (ret)
+		ret = nvmet_ns_enable_file(ns);
+
+	return ret;
+}
+
+static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
+{
+	if (ns->bdev) {
+		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
+		ns->bdev = NULL;
+	} else if (ns->file) {
+		fput(ns->file);
+		ns->file = NULL;
+	} else
+		pr_err("invalid ns handle\n");
+}
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
@@ -281,23 +353,14 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
-	ns->bdev = blkdev_get_by_path(ns->device_path, FMODE_READ | FMODE_WRITE,
-			NULL);
-	if (IS_ERR(ns->bdev)) {
-		pr_err("failed to open block device %s: (%ld)\n",
-		       ns->device_path, PTR_ERR(ns->bdev));
-		ret = PTR_ERR(ns->bdev);
-		ns->bdev = NULL;
+	ret = nvmet_ns_dev_enable(ns);
+	if (ret)
 		goto out_unlock;
-	}
-
-	ns->size = i_size_read(ns->bdev->bd_inode);
-	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
 
 	ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace,
 				0, GFP_KERNEL);
 	if (ret)
-		goto out_blkdev_put;
+		goto out_dev_put;
 
 	if (ns->nsid > subsys->max_nsid)
 		subsys->max_nsid = ns->nsid;
@@ -328,9 +391,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
-out_blkdev_put:
-	blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
-	ns->bdev = NULL;
+out_dev_put:
+	nvmet_ns_dev_disable(ns);
 	goto out_unlock;
 }
 
@@ -366,8 +428,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
 
-	if (ns->bdev)
-		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
+	nvmet_ns_dev_disable(ns);
 out_unlock:
 	mutex_unlock(&subsys->lock);
 }
@@ -513,6 +574,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->transfer_len = 0;
 	req->rsp->status = 0;
 	req->ns = NULL;
+	req->bvec = NULL;
+	memset(&req->iocb, 0, sizeof(req->iocb));
 
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index cd23441..37d419d 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/blkdev.h>
 #include <linux/module.h>
+#include <linux/uio.h>
 #include "nvmet.h"
 
 static void nvmet_bio_done(struct bio *bio)
@@ -89,6 +90,69 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
 }
 
+static void nvmet_file_io_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct nvmet_req *req = container_of(iocb, struct nvmet_req, iocb);
+
+	if (req->bvec != req->inline_bvec)
+		kfree(req->bvec);
+
+	nvmet_req_complete(req, ret != req->data_len ?
+			NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+}
+
+static void nvmet_execute_rw_file(struct nvmet_req *req)
+{
+	loff_t pos;
+	ssize_t len = 0, ret;
+	int bv_cnt = 0;
+	struct iov_iter iter;
+	struct sg_page_iter sg_pg_iter;
+	int rw = req->cmd->rw.opcode == nvme_cmd_write ? WRITE : READ;
+	u32 nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
+
+	req->bvec = req->inline_bvec;
+	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC) {
+		req->bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
+				GFP_KERNEL);
+		if (!req->bvec)
+			goto out;
+	}
+
+	for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
+		req->bvec[bv_cnt].bv_page = sg_page_iter_page(&sg_pg_iter);
+		req->bvec[bv_cnt].bv_offset = sg_pg_iter.sg->offset;
+		req->bvec[bv_cnt].bv_len = PAGE_SIZE - sg_pg_iter.sg->offset;
+		len += req->bvec[bv_cnt].bv_len;
+		bv_cnt++;
+	}
+
+	if (len != req->data_len)
+		goto free;
+
+	iov_iter_bvec(&iter, ITER_BVEC | rw, req->bvec, bv_cnt, len);
+	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
+	req->iocb.ki_pos = pos;
+	req->iocb.ki_filp = req->ns->file;
+	req->iocb.ki_flags = IOCB_DIRECT;
+	req->iocb.ki_complete = nvmet_file_io_complete;
+
+	if (req->cmd->rw.opcode == nvme_cmd_write) {
+		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
+			req->iocb.ki_flags |= IOCB_DSYNC;
+		ret = req->ns->file->f_op->write_iter(&req->iocb, &iter);
+	} else
+		ret = req->ns->file->f_op->read_iter(&req->iocb, &iter);
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
@@ -102,6 +166,23 @@ static void nvmet_execute_flush(struct nvmet_req *req)
 	submit_bio(bio);
 }
 
+static void nvmet_flush_work_file(struct work_struct *work)
+{
+	int ret;
+	struct nvmet_req *req;
+
+	req = container_of(work, struct nvmet_req, flush_work);
+
+	ret = vfs_fsync(req->ns->file, 1);
+
+	nvmet_req_complete(req, ret);
+}
+
+static void nvmet_execute_flush_file(struct nvmet_req *req)
+{
+	schedule_work(&req->flush_work);
+}
+
 static u16 nvmet_discard_range(struct nvmet_ns *ns,
 		struct nvme_dsm_range *range, struct bio **bio)
 {
@@ -163,6 +244,43 @@ static void nvmet_execute_dsm(struct nvmet_req *req)
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
+		ret = vfs_fallocate(req->ns->file, mode, offset, len);
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
@@ -189,6 +307,22 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
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
+	ret = vfs_fallocate(req->ns->file, mode, offset, len);
+	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+}
+
 u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -207,20 +341,33 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
-		req->execute = nvmet_execute_rw;
+		if (req->ns->file)
+			req->execute = nvmet_execute_rw_file;
+		else
+			req->execute = nvmet_execute_rw;
 		req->data_len = nvmet_rw_len(req);
 		return 0;
 	case nvme_cmd_flush:
-		req->execute = nvmet_execute_flush;
+		if (req->ns->file) {
+			req->execute = nvmet_execute_flush_file;
+			INIT_WORK(&req->flush_work, nvmet_flush_work_file);
+		} else
+			req->execute = nvmet_execute_flush;
 		req->data_len = 0;
 		return 0;
 	case nvme_cmd_dsm:
-		req->execute = nvmet_execute_dsm;
+		if (req->ns->file)
+			req->execute = nvmet_execute_dsm_file;
+		else
+			req->execute = nvmet_execute_dsm;
 		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
 			sizeof(struct nvme_dsm_range);
 		return 0;
 	case nvme_cmd_write_zeroes:
-		req->execute = nvmet_execute_write_zeroes;
+		if (req->ns->file)
+			req->execute = nvmet_execute_write_zeroes_file;
+		else
+			req->execute = nvmet_execute_write_zeroes;
 		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 15fd84a..60f399f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -26,6 +26,8 @@
 #include <linux/configfs.h>
 #include <linux/rcupdate.h>
 #include <linux/blkdev.h>
+#include <linux/file.h>
+#include <linux/falloc.h>
 
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
@@ -43,6 +45,7 @@ struct nvmet_ns {
 	struct list_head	dev_link;
 	struct percpu_ref	ref;
 	struct block_device	*bdev;
+	struct file		*file;
 	u32			nsid;
 	u32			blksize_shift;
 	loff_t			size;
@@ -224,6 +227,8 @@ struct nvmet_req {
 	struct scatterlist	*sg;
 	struct bio		inline_bio;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
+	struct kiocb		iocb;
+	struct bio_vec		*bvec;
 	int			sg_cnt;
 	/* data length as parsed from the command: */
 	size_t			data_len;
@@ -234,6 +239,7 @@ struct nvmet_req {
 
 	void (*execute)(struct nvmet_req *req);
 	const struct nvmet_fabrics_ops *ops;
+	struct work_struct	flush_work;
 };
 
 static inline void nvmet_set_status(struct nvmet_req *req, u16 status)
-- 
2.9.5
