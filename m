From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 17 May 2018 01:45:58 -0400
Subject: [PATCH V5] nvmet: add simple file backed ns support
Message-ID: <20180517054558.5648-1-chaitanya.kulkarni@wdc.com>

This patch adds simple file backed namespace support for
NVMeOF target.

In current implementation NVMeOF supports block
device backed namespaces on the target side.
With this implementation regular file(s) can be used
to initialize the namespace(s) via target side
configfs interface.

For admin smart log command on the target side, we only
use block device backed namespaces to compute target
side smart log.

The new file io-cmd-file.c is responsible for handling
the code for I/O commands when ns is file backed. Also,
we introduce mempools based slow path for file backed
ns.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---

Changes since V4:-

1. Change name of nvmet_parse_io_cmd ->
   nvmet_parse_io_cmd_blkdev() in io-cmd.c.
2. Isolate the file backed ns I/O command
   handlers to separate file io-cmd-file.c.
3. Introduce centralize I/O command parse function to
   parse I/O commands based on the ns handle
   (device and file).
4. Introduce per namespace mempool to ensure
   forward progress under reclaim for each namespace.
5. Introduce slow path for read/write commands,
   here we iterate through bvec allocated from mempool to
   complete file read/write handling.
6. Integrate Christoph's relative patch to use
   anonymous unions and file I/O command parse cleanup.
7. Restructure nvmet_execute_rw_file() to handle new
   allocations and slow path.
8. Adjust the code for 4.17.0-rc5.


Changes since V3:-

1. Fix the comment in the smart-log target code.
2. Change suffix from blk to blkdev.
3. Get rid of flags variable in
   nvmet_ns_enable_[blkdev|file]().
4. Skip the error print when path is not block
   device for nvmet_ns_enable_blkkdev().
5. Return PTR_ERR if blkdev open fails.
6. Remove NULL check after filp_open() and return
   PTR_ERR on filp_open() error. 
7. Use AT_STATX_FORCE_SYNC and STATX_SIZE for
   vfs_getattr().
8. Separate line for each assignment.
9. Remove new lines before return.
10. Remove nvmet_ns_dev_enable() and call
    nvmet_ns_enable_[blkdev|file]() to enable ns
    handle from nvmet_ns_enable().
11. Use workqueue for discard and write zeroes.
12. Separate the block device and file parsing commands.
13. Move #include <linux/file.h> core.c
    (needed for fput) and #include <linux/falloc.h>
    io-cmd.c from nvmet.h.
14. Unionize file and block device handles. 
15. Only initialize iocb for file IO.
16. Add WARN_ON_ONCE() in nvmet_ns_dev_disable().

Note :- Replacing kmalloc_array() with bvec_alloc()
        is not done in this version, as discusison
        is in progress.


Changes since V2:-

1. Adjust this patch for 4.17.0-rc4.


Changes since V1:-

1. Replace filp to file, filp_close to fput,
   call_[read|write]_iter() to [read|write]_iter().
2. Add code for the offloading flush operation for
   file-backed ns.
3. Aggregate the patches for O_DIRECT implementation.
4. Use inline bvec for smaller I/Os for file-backed ns.
5. Use file_inode() instead of open coding.
6. Get rid of bvec calculation macro and use
   DIV_ROUND_UP for the number of bvec calculation.
7. Avoid multiplication on the IO code patch.
8. Remove the req->bvec = NULL in IO completion
   callback.
9. Remove the sg mapping iterator and use simple
   for_each_sg_page() to iterate the pages.

---
 drivers/nvme/target/Makefile      |   2 +-
 drivers/nvme/target/core.c        | 130 +++++++++++++---
 drivers/nvme/target/io-cmd-file.c | 312 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd.c      |  25 +--
 drivers/nvme/target/nvmet.h       |  21 ++-
 5 files changed, 452 insertions(+), 38 deletions(-)
 create mode 100644 drivers/nvme/target/io-cmd-file.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 4882501..f5dfe65 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_NVME_TARGET_FC)		+= nvmet-fc.o
 obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o io-cmd.o fabrics-cmd.o \
-			discovery.o
+			discovery.o io-cmd-file.o
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
 nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95424f..e1d21f2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -15,6 +15,9 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/mempool.h>
 
 #include "nvmet.h"
 
@@ -271,6 +274,83 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
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
+static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
+{
+	if (ns->bdev) {
+		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
+		ns->bdev = NULL;
+	} else if (ns->file) {
+		mempool_destroy(ns->mempool);
+		ns->mempool = NULL;
+		kmem_cache_destroy(ns->cachep);
+		ns->cachep = NULL;
+		fput(ns->file);
+		ns->file = NULL;
+	} else
+		WARN_ON_ONCE("invalid ns handle\n");
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
+
+	ns->cachep = kmem_cache_create("nvmet-fs",
+			NVMET_MAX_BVEC * sizeof(struct bio_vec),
+			0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!ns->cachep)
+		goto err;
+
+	ns->mempool = mempool_create(NVMET_MPOOL_MIN_OBJ, mempool_alloc_slab,
+			mempool_free_slab, ns->cachep);
+
+	if (!ns->mempool)
+		goto err;
+
+	return ret;
+err:
+	ns->size = 0;
+	ns->blksize_shift = 0;
+	nvmet_ns_dev_disable(ns);
+	return ret;
+}
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
@@ -281,23 +361,16 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
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
@@ -328,9 +401,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
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
 
@@ -366,8 +438,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
 
-	if (ns->bdev)
-		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
+	nvmet_ns_dev_disable(ns);
 out_unlock:
 	mutex_unlock(&subsys->lock);
 }
@@ -499,6 +570,31 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 }
 EXPORT_SYMBOL_GPL(nvmet_sq_init);
 
+static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
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
+	else if (req->ns->bdev)
+		return nvmet_parse_io_cmd_blkdev(req);
+
+	WARN_ON_ONCE("failed to parse io cmd: invalid ns handle");
+
+	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+}
+
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops)
 {
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
new file mode 100644
index 0000000..bbf94b4
--- /dev/null
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe Over Fabrics Target File I/O commands implementation.
+ * Copyright (c) 2017-2018 Western Digital Corporation or its
+ * affiliates.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/uio.h>
+#include <linux/falloc.h>
+#include "nvmet.h"
+
+typedef ssize_t (*call_iter_t) (struct kiocb *, struct iov_iter *);
+typedef void (*ki_complete_t)(struct kiocb *iocb, long ret, long ret2);
+
+static size_t nvmet_init_bvec(struct bio_vec *bv, struct sg_page_iter *iter)
+{
+	bv->bv_page = sg_page_iter_page(iter);
+	bv->bv_offset = iter->sg->offset;
+	bv->bv_len = PAGE_SIZE - iter->sg->offset;
+
+	return bv->bv_len;
+}
+
+static ssize_t nvmet_issue_bvec(struct nvmet_req *req, loff_t pos,
+		unsigned long nr_segs, size_t count, ki_complete_t io_done)
+{
+	struct kiocb *iocb = &req->f.iocb;
+	call_iter_t call_iter;
+	struct iov_iter iter;
+	int ki_flags;
+	int ret;
+	int rw;
+
+	if (req->cmd->rw.opcode == nvme_cmd_write) {
+		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
+			ki_flags = IOCB_DSYNC;
+		call_iter = req->ns->file->f_op->write_iter;
+		rw = WRITE;
+	} else {
+		call_iter = req->ns->file->f_op->read_iter;
+		rw = READ;
+	}
+
+	iov_iter_bvec(&iter, ITER_BVEC | rw, req->f.bvec, nr_segs, count);
+
+	memset(iocb, 0, sizeof(*iocb));
+	iocb->ki_pos = pos;
+	iocb->ki_filp = req->ns->file;
+	iocb->ki_flags = IOCB_DIRECT;
+	iocb->ki_complete = io_done;
+
+	ret = call_iter(iocb, &iter);
+
+	if (ret != -EIOCBQUEUED)
+		iocb->ki_complete(iocb, ret, 0);
+
+	return ret;
+}
+
+static void nvmet_io_done_file(struct kiocb *iocb, long ret, long ret2)
+{
+	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
+
+	nvmet_req_complete(req, ret != req->data_len ?
+			NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+
+	if (req->f.bvec != req->inline_bvec)
+		kfree(req->f.bvec);
+}
+
+static void nvmet_do_io(struct nvmet_req *req, loff_t pos,
+		ki_complete_t io_done)
+{
+	struct sg_page_iter sg_pg_iter;
+	u16 status = NVME_SC_SUCCESS;
+	unsigned long bv_cnt = 0;
+	size_t map_len = 0;
+
+	for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
+		map_len += nvmet_init_bvec(&req->f.bvec[bv_cnt], &sg_pg_iter);
+		bv_cnt++;
+	}
+
+	if (map_len != req->data_len) {
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		goto free;
+	}
+
+	nvmet_issue_bvec(req, pos, bv_cnt, map_len, io_done);
+	return;
+free:
+	if (req->f.bvec != req->inline_bvec)
+		kfree(req->f.bvec);
+
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_io_done_file_slow(struct kiocb *iocb, long ret, long ret2)
+{
+	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
+
+	complete(&req->f.io_complete);
+}
+
+static void nvmet_do_io_slow(struct nvmet_req *req, loff_t pos,
+		ki_complete_t io_done, ssize_t nr_bvec)
+{
+	struct sg_page_iter sg_pg_iter;
+	u16 status = NVME_SC_SUCCESS;
+	unsigned long bv_cnt = 0;
+	size_t map_len = 0;
+	size_t len = 0;
+	ssize_t ret;
+
+	for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
+
+		map_len += nvmet_init_bvec(&req->f.bvec[bv_cnt], &sg_pg_iter);
+		len += req->f.bvec[bv_cnt].bv_len;
+		bv_cnt++;
+
+		WARN_ON((nr_bvec - 1) < 0);
+
+		if ((bv_cnt == NVMET_MAX_BVEC) || ((nr_bvec - 1) == 0)) {
+			init_completion(&req->f.io_complete);
+
+			ret = nvmet_issue_bvec(req, pos, bv_cnt, len, io_done);
+			if (ret == -EIOCBQUEUED)
+				wait_for_completion(&req->f.io_complete);
+			else if (ret < 0) {
+				status = NVME_SC_INTERNAL | NVME_SC_DNR;
+				goto err;
+			}
+
+			pos += len;
+			bv_cnt = 0;
+			len = 0;
+		}
+		nr_bvec--;
+	}
+	if (map_len != req->data_len)
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+err:
+	mempool_free(req->f.bvec, req->ns->mempool);
+
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_rw_file(struct nvmet_req *req)
+{
+	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
+	bool slow_path = false;
+	loff_t pos;
+
+	if (!req->sg_cnt || !nr_bvec) {
+		nvmet_req_complete(req, 0);
+		return;
+	}
+
+	req->f.bvec = req->inline_bvec;
+	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC) {
+		req->f.bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
+				GFP_KERNEL);
+		/* fallback */
+		if (!req->f.bvec) {
+			req->f.bvec = mempool_alloc(req->ns->mempool,
+					GFP_KERNEL);
+			if (!req->f.bvec)
+				goto out;
+			slow_path = true;
+		}
+	}
+
+	req->f.bvec = mempool_alloc(req->ns->mempool,
+			GFP_KERNEL);
+	if (!req->f.bvec)
+		goto out;
+	slow_path = true;
+	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
+
+	if (likely(slow_path == false))
+		nvmet_do_io(req, pos, nvmet_io_done_file);
+	else
+		nvmet_do_io_slow(req, pos, nvmet_io_done_file_slow, nr_bvec);
+
+	return;
+out:
+	nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
+}
+
+static void nvmet_flush_work_file(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	int ret;
+
+	ret = vfs_fsync(req->ns->file, 1);
+
+	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+}
+
+static void nvmet_execute_flush_file(struct nvmet_req *req)
+{
+	INIT_WORK(&req->f.work, nvmet_flush_work_file);
+	schedule_work(&req->f.work);
+}
+
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
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
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
+	INIT_WORK(&req->f.work, nvmet_dsm_work_file);
+	schedule_work(&req->f.work);
+}
+
+static void nvmet_write_zeroes_work_file(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
+	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
+	loff_t offset;
+	loff_t len;
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
+static void nvmet_execute_write_zeroes_file(struct nvmet_req *req)
+{
+	INIT_WORK(&req->f.work, nvmet_write_zeroes_work_file);
+	schedule_work(&req->f.work);
+}
+
+u16 nvmet_parse_io_cmd_file(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	switch (cmd->common.opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+		req->execute = nvmet_execute_rw_file;
+		req->data_len = nvmet_rw_len(req);
+		return 0;
+	case nvme_cmd_flush:
+		req->execute = nvmet_execute_flush_file;
+		req->data_len = 0;
+		return 0;
+	case nvme_cmd_dsm:
+		req->execute = nvmet_execute_dsm_file;
+		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
+			sizeof(struct nvme_dsm_range);
+		return 0;
+	case nvme_cmd_write_zeroes:
+		req->execute = nvmet_execute_write_zeroes_file;
+		req->data_len = 0;
+		return 0;
+	default:
+		pr_err("unhandled cmd for file ns %d on qid %d\n",
+				cmd->common.opcode, req->sq->qid);
+		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+	}
+}
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index cd23441..8e6d7a6 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -23,11 +23,11 @@ static void nvmet_bio_done(struct bio *bio)
 	nvmet_req_complete(req,
 		bio->bi_status ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 
-	if (bio != &req->inline_bio)
+	if (bio != &req->b.inline_bio)
 		bio_put(bio);
 }
 
-static inline u32 nvmet_rw_len(struct nvmet_req *req)
+inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
 			req->ns->blksize_shift;
@@ -36,7 +36,7 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
 static void nvmet_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
-	struct bio *bio = &req->inline_bio;
+	struct bio *bio = &req->b.inline_bio;
 	struct scatterlist *sg;
 	sector_t sector;
 	blk_qc_t cookie;
@@ -91,7 +91,7 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 
 static void nvmet_execute_flush(struct nvmet_req *req)
 {
-	struct bio *bio = &req->inline_bio;
+	struct bio *bio = &req->b.inline_bio;
 
 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	bio_set_dev(bio, req->ns->bdev);
@@ -189,20 +189,9 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
-u16 nvmet_parse_io_cmd(struct nvmet_req *req)
+u16 nvmet_parse_io_cmd_blkdev(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
-	u16 ret;
-
-	ret = nvmet_check_ctrl_status(req, cmd);
-	if (unlikely(ret)) {
-		req->ns = NULL;
-		return ret;
-	}
-
-	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
-	if (unlikely(!req->ns))
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
@@ -223,8 +212,8 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 		req->execute = nvmet_execute_write_zeroes;
 		return 0;
 	default:
-		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
-		       req->sq->qid);
+		pr_err("unhandled cmd for blkdev ns %d on qid %d\n",
+				cmd->common.opcode, req->sq->qid);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 15fd84a..215a206 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -29,6 +29,8 @@
 
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
+#define NVMET_MAX_BVEC			16
+#define NVMET_MPOOL_MIN_OBJ		NVMET_MAX_BVEC
 
 /* Helper Macros when NVMe error is NVME_SC_CONNECT_INVALID_PARAM
  * The 16 bit shift is to set IATTR bit to 1, which means offending
@@ -43,6 +45,7 @@ struct nvmet_ns {
 	struct list_head	dev_link;
 	struct percpu_ref	ref;
 	struct block_device	*bdev;
+	struct file		*file;
 	u32			nsid;
 	u32			blksize_shift;
 	loff_t			size;
@@ -57,6 +60,8 @@ struct nvmet_ns {
 	struct config_group	group;
 
 	struct completion	disable_done;
+	mempool_t		*mempool;
+	struct kmem_cache	*cachep;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
@@ -222,8 +227,18 @@ struct nvmet_req {
 	struct nvmet_cq		*cq;
 	struct nvmet_ns		*ns;
 	struct scatterlist	*sg;
-	struct bio		inline_bio;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
+	union {
+		struct {
+			struct bio      inline_bio;
+		} b;
+		struct {
+			struct kiocb            iocb;
+			struct bio_vec          *bvec;
+			struct work_struct      work;
+			struct completion	io_complete;
+		} f;
+	};
 	int			sg_cnt;
 	/* data length as parsed from the command: */
 	size_t			data_len;
@@ -263,7 +278,8 @@ struct nvmet_async_event {
 };
 
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
-u16 nvmet_parse_io_cmd(struct nvmet_req *req);
+u16 nvmet_parse_io_cmd_blkdev(struct nvmet_req *req);
+u16 nvmet_parse_io_cmd_file(struct nvmet_req *req);
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req);
 u16 nvmet_parse_discovery_cmd(struct nvmet_req *req);
 u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req);
@@ -338,4 +354,5 @@ extern struct rw_semaphore nvmet_config_sem;
 bool nvmet_host_allowed(struct nvmet_req *req, struct nvmet_subsys *subsys,
 		const char *hostnqn);
 
+inline u32 nvmet_rw_len(struct nvmet_req *req);
 #endif /* _NVMET_H */
-- 
2.9.5
