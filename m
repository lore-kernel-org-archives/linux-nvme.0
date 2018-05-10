From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 10 May 2018 17:45:08 -0400
Subject: [PATCH V4] nvmet: add simple file backed ns support
Message-ID: <20180510214508.4563-1-chaitanya.kulkarni@wdc.com>

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
Changes since V3:-

1. Fix the comment in the smart-log target code.
2. Change suffix from blk to blkdev.
3. Get rid of flags variable in nvmet_ns_enable_[blkdev|file]().
4. Skip the error print when path is not block device for
   nvmet_ns_enable_blkkdev().
5. Return PTR_ERR if blkdev open fails.
6. Remove NULL check after filp_open() and return PTR_ERR
   on filp_open() error. 
7. Use AT_STATX_FORCE_SYNC and STATX_SIZE for vfs_getattr().
8. Separate line for each assignment
9. Remove new lines before return.
10. Remove nvmet_ns_dev_enable() and call
    nvmet_ns_enable_[blkdev|file]() to enable ns handle from
    nvmet_ns_enable().
11. Use workqueue for discard and write zeroes.
12. Separate the block device and file parsing commands.
13. Move #include <linux/file.h> core.c (needed for fput) and
    #include <linux/falloc.h> io-cmd.c from nvmet.h.
14. Unionize file and block device handles. 
15. Only initialize iocb for file IO.
16. Add WARN_ON_ONCE() in nvmet_ns_dev_disable().

Note :- Replacing kmalloc_array() with bvec_alloc() is not 
done in this version, as discusison is in progress.


Changes since V2:-

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
 drivers/nvme/target/admin-cmd.c |   9 ++
 drivers/nvme/target/core.c      |  87 +++++++++++---
 drivers/nvme/target/io-cmd.c    | 246 +++++++++++++++++++++++++++++++++++++---
 drivers/nvme/target/nvmet.h     |  19 +++-
 4 files changed, 327 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5e0e9fc..f88c83d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -45,6 +45,10 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		return NVME_SC_INVALID_NS;
 	}
 
+	/* we don't have the right data for file backed ns */
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
+		/* we don't have the right data for file backed ns */
+		if (!ns->bdev)
+			continue;
 		host_reads += part_stat_read(ns->bdev->bd_part, ios[READ]);
 		data_units_read +=
 			part_stat_read(ns->bdev->bd_part, sectors[READ]);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95424f..c6f43cb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
+#include <linux/file.h>
 
 #include "nvmet.h"
 
@@ -271,6 +272,67 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
 	percpu_ref_put(&ns->ref);
 }
 
+static int nvmet_ns_enable_blkdev(struct nvmet_ns *ns)
+{
+	int ret;
+
+	ns->bdev = blkdev_get_by_path(ns->device_path,
+			FMODE_READ | FMODE_WRITE, NULL);
+	if (IS_ERR(ns->bdev)) {
+		ret = PTR_ERR(ns->bdev);
+		if (ret != -ENOTBLK) {
+			pr_err("failed to open block device %s: (%ld)\n",
+					ns->device_path, PTR_ERR(ns->bdev));
+		}
+		ns->bdev = NULL;
+		return ret;
+	}
+	ns->size = i_size_read(ns->bdev->bd_inode);
+	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+	return 0;
+}
+
+static int nvmet_ns_enable_file(struct nvmet_ns *ns)
+{
+	int ret;
+	struct kstat stat;
+
+	ns->file = filp_open(ns->device_path,
+			O_RDWR | O_LARGEFILE | O_DIRECT, 0);
+	if (IS_ERR(ns->file)) {
+		pr_err("failed to open file %s: (%ld)\n",
+				ns->device_path, PTR_ERR(ns->bdev));
+		return PTR_ERR(ns->file);
+	}
+
+	ret = vfs_getattr(&ns->file->f_path,
+			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
+	if (ret)
+		goto err;
+
+	ns->size = stat.size;
+	ns->blksize_shift = file_inode(ns->file)->i_blkbits;
+	return ret;
+err:
+	fput(ns->file);
+	ns->size = 0;
+	ns->blksize_shift = 0;
+	ns->file = NULL;
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
+		WARN_ON_ONCE("invalid ns handle\n");
+}
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
@@ -281,23 +343,16 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
-	ns->bdev = blkdev_get_by_path(ns->device_path, FMODE_READ | FMODE_WRITE,
-			NULL);
-	if (IS_ERR(ns->bdev)) {
-		pr_err("failed to open block device %s: (%ld)\n",
-		       ns->device_path, PTR_ERR(ns->bdev));
-		ret = PTR_ERR(ns->bdev);
-		ns->bdev = NULL;
+	ret = nvmet_ns_enable_blkdev(ns);
+	if (ret)
+		ret = nvmet_ns_enable_file(ns);
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
@@ -328,9 +383,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
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
 
@@ -366,8 +420,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
 
-	if (ns->bdev)
-		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
+	nvmet_ns_dev_disable(ns);
 out_unlock:
 	mutex_unlock(&subsys->lock);
 }
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index cd23441..a5f787b 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -14,8 +14,20 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/blkdev.h>
 #include <linux/module.h>
+#include <linux/uio.h>
+#include <linux/falloc.h>
+
 #include "nvmet.h"
 
+static struct nvmet_req *nvmet_get_req_from_work(struct work_struct *w)
+{
+	struct nvmet_ns_file_handle *f =
+		container_of(w, struct nvmet_ns_file_handle, io_work);
+	union ns_handle *u =  container_of(f, union ns_handle, f);
+
+	return container_of(u, struct nvmet_req, handle);
+}
+
 static void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
@@ -23,7 +35,7 @@ static void nvmet_bio_done(struct bio *bio)
 	nvmet_req_complete(req,
 		bio->bi_status ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 
-	if (bio != &req->inline_bio)
+	if (bio != &req->handle.b.inline_bio)
 		bio_put(bio);
 }
 
@@ -36,7 +48,7 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
 static void nvmet_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
-	struct bio *bio = &req->inline_bio;
+	struct bio *bio = &req->handle.b.inline_bio;
 	struct scatterlist *sg;
 	sector_t sector;
 	blk_qc_t cookie;
@@ -89,9 +101,80 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
 }
 
+static void nvmet_file_io_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct nvmet_ns_file_handle *f =
+		container_of(iocb, struct nvmet_ns_file_handle, iocb);
+	union ns_handle *u =  container_of(f, union ns_handle, f);
+	struct nvmet_req *req = container_of(u, struct nvmet_req, handle);
+
+	if (req->handle.f.bvec != req->inline_bvec)
+		kfree(req->handle.f.bvec);
+
+	nvmet_req_complete(req, ret != req->data_len ?
+			NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+}
+
+static void nvmet_execute_rw_file(struct nvmet_req *req)
+{
+	int rw = req->cmd->rw.opcode == nvme_cmd_write ? WRITE : READ;
+	u32 nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
+	struct sg_page_iter sg_pg_iter;
+	struct bio_vec *bvec;
+	struct iov_iter iter;
+	struct kiocb *iocb;
+	ssize_t len = 0, ret;
+	int bv_cnt = 0;
+	loff_t pos;
+
+	bvec = req->inline_bvec;
+	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC) {
+		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
+				GFP_KERNEL);
+		if (!bvec)
+			goto out;
+	}
+	req->handle.f.bvec = bvec;
+	iocb = &req->handle.f.iocb;
+
+	for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
+		bvec[bv_cnt].bv_page = sg_page_iter_page(&sg_pg_iter);
+		bvec[bv_cnt].bv_offset = sg_pg_iter.sg->offset;
+		bvec[bv_cnt].bv_len = PAGE_SIZE - sg_pg_iter.sg->offset;
+		len += bvec[bv_cnt].bv_len;
+		bv_cnt++;
+	}
+
+	if (len != req->data_len)
+		goto free;
+
+	iov_iter_bvec(&iter, ITER_BVEC | rw, bvec, bv_cnt, len);
+	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
+	iocb->ki_pos = pos;
+	iocb->ki_filp = req->ns->file;
+	iocb->ki_flags = IOCB_DIRECT;
+	iocb->ki_complete = nvmet_file_io_complete;
+
+	if (req->cmd->rw.opcode == nvme_cmd_write) {
+		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
+			iocb->ki_flags |= IOCB_DSYNC;
+		ret = req->ns->file->f_op->write_iter(iocb, &iter);
+	} else
+		ret = req->ns->file->f_op->read_iter(iocb, &iter);
+
+	if (ret != -EIOCBQUEUED)
+		nvmet_file_io_complete(iocb, ret, 0);
+	return;
+free:
+	if (bvec != req->inline_bvec)
+		kfree(req->handle.f.bvec);
+out:
+	nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
+}
+
 static void nvmet_execute_flush(struct nvmet_req *req)
 {
-	struct bio *bio = &req->inline_bio;
+	struct bio *bio = &req->handle.b.inline_bio;
 
 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	bio_set_dev(bio, req->ns->bdev);
@@ -102,6 +185,24 @@ static void nvmet_execute_flush(struct nvmet_req *req)
 	submit_bio(bio);
 }
 
+static void nvmet_flush_work_file(struct work_struct *w)
+{
+	struct nvmet_req *req = nvmet_get_req_from_work(w);
+	u16 status = NVME_SC_SUCCESS;
+	int ret;
+
+	ret = vfs_fsync(req->ns->file, 1);
+	if (ret)
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_flush_file(struct nvmet_req *req)
+{
+	schedule_work(&req->handle.f.io_work);
+}
+
 static u16 nvmet_discard_range(struct nvmet_ns *ns,
 		struct nvme_dsm_range *range, struct bio **bio)
 {
@@ -163,6 +264,50 @@ static void nvmet_execute_dsm(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_execute_discard_file(struct nvmet_req *req)
+{
+	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
+	struct nvme_dsm_range range;
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
+static void nvmet_dsm_work_file(struct work_struct *w)
+{
+	struct nvmet_req *req = nvmet_get_req_from_work(w);
+
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
+static void nvmet_execute_dsm_file(struct nvmet_req *req)
+{
+	schedule_work(&req->handle.f.io_work);
+}
+
 static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 {
 	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
@@ -189,20 +334,31 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
-u16 nvmet_parse_io_cmd(struct nvmet_req *req)
+static void nvmet_write_zeroes_work_file(struct work_struct *w)
 {
-	struct nvme_command *cmd = req->cmd;
-	u16 ret;
+	struct nvmet_req *req = nvmet_get_req_from_work(w);
+	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
+	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
+	loff_t offset;
+	loff_t len;
+	int ret;
 
-	ret = nvmet_check_ctrl_status(req, cmd);
-	if (unlikely(ret)) {
-		req->ns = NULL;
-		return ret;
-	}
+	offset = le64_to_cpu(write_zeroes->slba) << req->ns->blksize_shift;
+	len = (((sector_t)le32_to_cpu(write_zeroes->length) + 1) <<
+			req->ns->blksize_shift);
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
-	if (unlikely(!req->ns))
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+	ret = vfs_fallocate(req->ns->file, mode, offset, len);
+	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+}
+
+static void nvmet_execute_write_zeroes_file(struct nvmet_req *req)
+{
+	schedule_work(&req->handle.f.io_work);
+}
+
+static u16 nvmet_parse_io_cmd_blkdev(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
 
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
@@ -223,8 +379,66 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 		req->execute = nvmet_execute_write_zeroes;
 		return 0;
 	default:
-		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
-		       req->sq->qid);
+		pr_err("unhandled cmd for blkdev ns %d on qid %d\n",
+				cmd->common.opcode, req->sq->qid);
+		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+	}
+	return 0;
+}
+
+u16 nvmet_parse_io_cmd_file(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	switch (cmd->common.opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+		req->handle.f.bvec = NULL;
+		memset(&req->handle.f.iocb, 0, sizeof(req->handle.f.iocb));
+		req->execute = nvmet_execute_rw_file;
+		req->data_len = nvmet_rw_len(req);
+		return 0;
+	case nvme_cmd_flush:
+		req->execute = nvmet_execute_flush_file;
+		INIT_WORK(&req->handle.f.io_work, nvmet_flush_work_file);
+		req->data_len = 0;
+		return 0;
+	case nvme_cmd_dsm:
+		INIT_WORK(&req->handle.f.io_work, nvmet_dsm_work_file);
+		req->execute = nvmet_execute_dsm_file;
+		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
+			sizeof(struct nvme_dsm_range);
+		return 0;
+	case nvme_cmd_write_zeroes:
+		INIT_WORK(&req->handle.f.io_work, nvmet_write_zeroes_work_file);
+		req->execute = nvmet_execute_write_zeroes_file;
+		req->data_len = 0;
+		return 0;
+	default:
+		pr_err("unhandled cmd for file ns %d on qid %d\n",
+				cmd->common.opcode, req->sq->qid);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
+	return 0;
+}
+
+u16 nvmet_parse_io_cmd(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+	u16 ret;
+
+	ret = nvmet_check_ctrl_status(req, cmd);
+	if (unlikely(ret)) {
+		req->ns = NULL;
+		return ret;
+	}
+
+	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
+	if (unlikely(!req->ns))
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+
+	if (req->ns->file)
+		return nvmet_parse_io_cmd_file(req);
+	else
+		return nvmet_parse_io_cmd_blkdev(req);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 15fd84a..5a91d9b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -43,6 +43,7 @@ struct nvmet_ns {
 	struct list_head	dev_link;
 	struct percpu_ref	ref;
 	struct block_device	*bdev;
+	struct file		*file;
 	u32			nsid;
 	u32			blksize_shift;
 	loff_t			size;
@@ -215,6 +216,22 @@ struct nvmet_fabrics_ops {
 
 #define NVMET_MAX_INLINE_BIOVEC	8
 
+
+struct nvmet_ns_bdev_handle {
+	struct bio		inline_bio;
+};
+
+struct nvmet_ns_file_handle {
+	struct kiocb		iocb;
+	struct bio_vec		*bvec;
+	struct work_struct	io_work;
+};
+
+union ns_handle {
+	struct nvmet_ns_bdev_handle	b;
+	struct nvmet_ns_file_handle	f;
+};
+
 struct nvmet_req {
 	struct nvme_command	*cmd;
 	struct nvme_completion	*rsp;
@@ -222,8 +239,8 @@ struct nvmet_req {
 	struct nvmet_cq		*cq;
 	struct nvmet_ns		*ns;
 	struct scatterlist	*sg;
-	struct bio		inline_bio;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
+	union  ns_handle	handle;
 	int			sg_cnt;
 	/* data length as parsed from the command: */
 	size_t			data_len;
-- 
2.9.5
