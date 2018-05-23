From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 23 May 2018 00:34:39 -0400
Subject: [PATCH V7] nvmet: add simple file backed ns support
Message-ID: <20180523043439.12846-1-chaitanya.kulkarni@wdc.com>

This patch adds simple file backed namespace support for NVMeOF target.

In the current implementation, NVMeOF supports block device backed
namespaces on the target side. With this implementation regular file(s)
can be used to initialize the namespace(s) via target side configfs
interface.

For admin smart log command on the target side, we only use block device
backed namespaces to compute target side smart log.

The new file io-cmd-file.c is responsible for handling the code for I/O
commands when ns is file backed. Also, we introduce mempools based slow
path using sync I/Os for file backed ns to ensure forward progress under
reclaim.

With introduction of the new handle type (file) we also restructure the
code for block device I/O commands where we rename the
io-cmd.c -> io->cmd-bdev.c, use "nvmet_bdev_" prefix to
I/O command handler function and introduce
nvmet_[bdev | file]_ns_[enable | disable]() variants for block device and
file in respective files.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---

Changes Since V6 :- (Codebase :- 4.17.0-rc6)

1. Apply Christoph's cleanup changes.
2. Make a slight change in the cleanup patch, a call to completion
   routine from nvmet_file_execute_rw() now uses error value only when
   ret < 0 (error case) otherwise total_len. Without this change ret will
   hold the value return for the last I/O, this will fail for multiple
   iterations of the successful sync I/O case where we need to pass
   total I/O size (total_len) for completion routine.


Changes since V5:- (Codebase :- 4.17.0-rc5)

1. Rename io-cmd.c to io-cmd-bdev.c, and add "nvmet_bdev" prefix to
   I/O command handlers in the same file.
2. Move bdev and file ns enable|disable functions to io-cmd-bdev.c
   io-cmd-file.c
3. Change the kmem_cache identifier from "nvmet-fs" -> "nvmet-bvec".
4. Remove error print for nvmet_parse_io_cmd() for invalid handle type.
5. Trim the file header for io-cmd-file.c.
6. Remove typedefs for function pointers.
7. Restructure the file I/O code and aggregate slow and fast path
   into one function.
8. Rename NVMET_MAX_BVEC -> NVMET_MAX_MPOOL_BVEC.
9. Move nvmet_rw_len() to nvmet.h and keep it inline.
10. Define NVMET_MPOOL_MIN_OBJ directly.
11. Rename ns->cachep -> ns->bvec_cache and ns->mempool -> ns->bvec_pool.
12. Only issue mempool backed sync I/O when
    nr_bvec > NVMET_MAX_MPOOL_BVEC.


Changes since V4:-

1. Adjust the code for 4.17.0-rc5.
2. Change name of nvmet_parse_io_cmd -> nvmet_parse_io_cmd_blkdev() in
   io-cmd.c.
3. Isolate the file backed ns I/O command handlers to separate file
   io-cmd-file.c.
4. Integrate Christoph's relative patch to use anonymous unions and file
   I/O command parse cleanup.
5. Introduce per namespace mempool to ensure forward progress under
   reclaim for each namespace.
6. Introduce centralize I/O command parse function to parse I/O commands
   based on the ns handle (device and file).
7. Introduce slow path for read/write commands, here we iterate through
   bvec allocated from mempool to complete file read/write handling.
8. Restructure nvmet_execute_rw_file() to handle new allocations and slow
   path.


Changes since V3:-

1. Fix the comment in the smart-log target code.
2. Change suffix from blk to blkdev.
3. Get rid of flags variable in nvmet_ns_enable_[blkdev|file]().
4. Skip the error print when path is not block device for
   nvmet_ns_enable_blkkdev().
5. Return PTR_ERR if blkdev open fails.
6. Remove NULL check after filp_open() and return PTR_ERR on filp_open()
   error.
7. Use AT_STATX_FORCE_SYNC and STATX_SIZE for vfs_getattr().
8. Separate line for each assignment.
9. Remove new lines before return.
10. Remove nvmet_ns_dev_enable() and call nvmet_ns_enable_[blkdev|file]()
    to enable ns handle from nvmet_ns_enable().
11. Use workqueue for discard and write zeroes.
12. Separate the block device and file parsing commands.
13. Move #include <linux/file.h> core.c (needed for fput) and
    #include <linux/falloc.h> io-cmd.c from nvmet.h.
14. Unionize file and block device handles.
15. Only initialize iocb for file IO.
16. Add WARN_ON_ONCE() in nvmet_ns_dev_disable().

Note :- Replacing kmalloc_array() with bvec_alloc() is not done in this
        version, as discussion is in progress.


Changes since V2:-

1. Adjust this patch for 4.17.0-rc4.


Changes since V1:-

1. Replace filp to file, filp_close to fput,
   call_[read|write]_iter() to [read|write]_iter().
2. Add code for the offloading flush operation for file-backed ns.
3. Aggregate the patches for O_DIRECT implementation.
4. Use inline bvec for smaller I/Os for file-backed ns.
5. Use file_inode() instead of open coding.
6. Get rid of bvec calculation macro and use DIV_ROUND_UP for the number
   of bvec calculation.
7. Avoid multiplication on the IO code patch.
8. Remove the req->bvec = NULL in IO completion callback.
9. Remove the sg mapping iterator and use simple for_each_sg_page() to
   iterate the pages.

---
 drivers/nvme/target/Makefile                    |   4 +-
 drivers/nvme/target/admin-cmd.c                 |   8 +
 drivers/nvme/target/core.c                      |  52 ++--
 drivers/nvme/target/{io-cmd.c => io-cmd-bdev.c} |  66 ++++--
 drivers/nvme/target/io-cmd-file.c               | 300 ++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h                     |  28 ++-
 6 files changed, 415 insertions(+), 43 deletions(-)
 rename drivers/nvme/target/{io-cmd.c => io-cmd-bdev.c} (77%)
 create mode 100644 drivers/nvme/target/io-cmd-file.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 4882501..8118c93 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -6,8 +6,8 @@ obj-$(CONFIG_NVME_TARGET_RDMA)		+= nvmet-rdma.o
 obj-$(CONFIG_NVME_TARGET_FC)		+= nvmet-fc.o
 obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
 
-nvmet-y		+= core.o configfs.o admin-cmd.o io-cmd.o fabrics-cmd.o \
-			discovery.o
+nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
+			discovery.o io-cmd-file.o io-cmd-bdev.o
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
 nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5e0e9fc..68a3457 100644
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
@@ -54,6 +58,7 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
 	put_unaligned_le64(host_writes, &slog->host_writes[0]);
 	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
+out:
 	nvmet_put_namespace(ns);
 
 	return NVME_SC_SUCCESS;
@@ -71,6 +76,9 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
+		/* we don't have the right data for file backed ns */
+		if (!ns->bdev)
+			continue;
 		host_reads += part_stat_read(ns->bdev->bd_part, ios[READ]);
 		data_units_read +=
 			part_stat_read(ns->bdev->bd_part, sectors[READ]);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95424f..bf92066 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -271,6 +271,12 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
 	percpu_ref_put(&ns->ref);
 }
 
+static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
+{
+	nvmet_bdev_ns_disable(ns);
+	nvmet_file_ns_disable(ns);
+}
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
@@ -281,23 +287,16 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
-	ns->bdev = blkdev_get_by_path(ns->device_path, FMODE_READ | FMODE_WRITE,
-			NULL);
-	if (IS_ERR(ns->bdev)) {
-		pr_err("failed to open block device %s: (%ld)\n",
-		       ns->device_path, PTR_ERR(ns->bdev));
-		ret = PTR_ERR(ns->bdev);
-		ns->bdev = NULL;
+	ret = nvmet_bdev_ns_enable(ns);
+	if (ret)
+		ret = nvmet_file_ns_enable(ns);
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
@@ -328,9 +327,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
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
 
@@ -366,8 +364,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
 
-	if (ns->bdev)
-		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
+	nvmet_ns_dev_disable(ns);
 out_unlock:
 	mutex_unlock(&subsys->lock);
 }
@@ -499,6 +496,27 @@ int nvmet_sq_init(struct nvmet_sq *sq)
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
+		return nvmet_file_parse_io_cmd(req);
+	else
+		return nvmet_bdev_parse_io_cmd(req);
+}
+
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops)
 {
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd-bdev.c
similarity index 77%
rename from drivers/nvme/target/io-cmd.c
rename to drivers/nvme/target/io-cmd-bdev.c
index cd23441..fbb6bec 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -16,6 +16,34 @@
 #include <linux/module.h>
 #include "nvmet.h"
 
+int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
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
+void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
+{
+	if (ns->bdev) {
+		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
+		ns->bdev = NULL;
+	}
+}
+
 static void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
@@ -23,20 +51,14 @@ static void nvmet_bio_done(struct bio *bio)
 	nvmet_req_complete(req,
 		bio->bi_status ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 
-	if (bio != &req->inline_bio)
+	if (bio != &req->b.inline_bio)
 		bio_put(bio);
 }
 
-static inline u32 nvmet_rw_len(struct nvmet_req *req)
-{
-	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
-			req->ns->blksize_shift;
-}
-
-static void nvmet_execute_rw(struct nvmet_req *req)
+static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
-	struct bio *bio = &req->inline_bio;
+	struct bio *bio = &req->b.inline_bio;
 	struct scatterlist *sg;
 	sector_t sector;
 	blk_qc_t cookie;
@@ -89,9 +111,9 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
 }
 
-static void nvmet_execute_flush(struct nvmet_req *req)
+static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 {
-	struct bio *bio = &req->inline_bio;
+	struct bio *bio = &req->b.inline_bio;
 
 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	bio_set_dev(bio, req->ns->bdev);
@@ -102,7 +124,7 @@ static void nvmet_execute_flush(struct nvmet_req *req)
 	submit_bio(bio);
 }
 
-static u16 nvmet_discard_range(struct nvmet_ns *ns,
+static u16 nvmet_bdev_discard_range(struct nvmet_ns *ns,
 		struct nvme_dsm_range *range, struct bio **bio)
 {
 	int ret;
@@ -116,7 +138,7 @@ static u16 nvmet_discard_range(struct nvmet_ns *ns,
 	return 0;
 }
 
-static void nvmet_execute_discard(struct nvmet_req *req)
+static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 {
 	struct nvme_dsm_range range;
 	struct bio *bio = NULL;
@@ -129,7 +151,7 @@ static void nvmet_execute_discard(struct nvmet_req *req)
 		if (status)
 			break;
 
-		status = nvmet_discard_range(req->ns, &range, &bio);
+		status = nvmet_bdev_discard_range(req->ns, &range, &bio);
 		if (status)
 			break;
 	}
@@ -148,11 +170,11 @@ static void nvmet_execute_discard(struct nvmet_req *req)
 	}
 }
 
-static void nvmet_execute_dsm(struct nvmet_req *req)
+static void nvmet_bdev_execute_dsm(struct nvmet_req *req)
 {
 	switch (le32_to_cpu(req->cmd->dsm.attributes)) {
 	case NVME_DSMGMT_AD:
-		nvmet_execute_discard(req);
+		nvmet_bdev_execute_discard(req);
 		return;
 	case NVME_DSMGMT_IDR:
 	case NVME_DSMGMT_IDW:
@@ -163,7 +185,7 @@ static void nvmet_execute_dsm(struct nvmet_req *req)
 	}
 }
 
-static void nvmet_execute_write_zeroes(struct nvmet_req *req)
+static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 {
 	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
 	struct bio *bio = NULL;
@@ -189,7 +211,7 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
-u16 nvmet_parse_io_cmd(struct nvmet_req *req)
+u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
 	u16 ret;
@@ -207,20 +229,20 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
-		req->execute = nvmet_execute_rw;
+		req->execute = nvmet_bdev_execute_rw;
 		req->data_len = nvmet_rw_len(req);
 		return 0;
 	case nvme_cmd_flush:
-		req->execute = nvmet_execute_flush;
+		req->execute = nvmet_bdev_execute_flush;
 		req->data_len = 0;
 		return 0;
 	case nvme_cmd_dsm:
-		req->execute = nvmet_execute_dsm;
+		req->execute = nvmet_bdev_execute_dsm;
 		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
 			sizeof(struct nvme_dsm_range);
 		return 0;
 	case nvme_cmd_write_zeroes:
-		req->execute = nvmet_execute_write_zeroes;
+		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
new file mode 100644
index 0000000..1e16cfc
--- /dev/null
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe Over Fabrics Target File I/O commands implementation.
+ * Copyright (c) 2017-2018 Western Digital Corporation or its
+ * affiliates.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/uio.h>
+#include <linux/falloc.h>
+#include <linux/file.h>
+#include "nvmet.h"
+
+#define NVMET_MAX_MPOOL_BVEC		16
+#define NVMET_MIN_MPOOL_OBJ		16
+
+void nvmet_file_ns_disable(struct nvmet_ns *ns)
+{
+	if (ns->file) {
+		mempool_destroy(ns->bvec_pool);
+		ns->bvec_pool = NULL;
+		kmem_cache_destroy(ns->bvec_cache);
+		ns->bvec_cache = NULL;
+		fput(ns->file);
+		ns->file = NULL;
+	}
+}
+
+int nvmet_file_ns_enable(struct nvmet_ns *ns)
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
+	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
+			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
+			0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!ns->bvec_cache)
+		goto err;
+
+	ns->bvec_pool = mempool_create(NVMET_MIN_MPOOL_OBJ, mempool_alloc_slab,
+			mempool_free_slab, ns->bvec_cache);
+
+	if (!ns->bvec_pool)
+		goto err;
+
+	return ret;
+err:
+	ns->size = 0;
+	ns->blksize_shift = 0;
+	nvmet_file_ns_disable(ns);
+	return ret;
+}
+
+static void nvmet_file_init_bvec(struct bio_vec *bv, struct sg_page_iter *iter)
+{
+	bv->bv_page = sg_page_iter_page(iter);
+	bv->bv_offset = iter->sg->offset;
+	bv->bv_len = PAGE_SIZE - iter->sg->offset;
+}
+
+static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
+		unsigned long nr_segs, size_t count)
+{
+	struct kiocb *iocb = &req->f.iocb;
+	ssize_t (*call_iter)(struct kiocb *iocb, struct iov_iter *iter);
+	struct iov_iter iter;
+	int ki_flags = 0, rw;
+	ssize_t ret;
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
+	iocb->ki_pos = pos;
+	iocb->ki_filp = req->ns->file;
+	iocb->ki_flags = IOCB_DIRECT | ki_flags;
+
+	ret = call_iter(iocb, &iter);
+
+	if (ret != -EIOCBQUEUED && iocb->ki_complete)
+		iocb->ki_complete(iocb, ret, 0);
+
+	return ret;
+}
+
+static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
+{
+	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
+
+	if (req->f.bvec != req->inline_bvec) {
+		if (likely(req->f.mpool_alloc == false))
+			kfree(req->f.bvec);
+		else
+			mempool_free(req->f.bvec, req->ns->bvec_pool);
+	}
+
+	nvmet_req_complete(req, ret != req->data_len ?
+			NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+}
+
+static void nvmet_file_execute_rw(struct nvmet_req *req)
+{
+	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
+	struct sg_page_iter sg_pg_iter;
+	unsigned long bv_cnt = 0;
+	bool is_sync = false;
+	size_t len = 0, total_len = 0;
+	ssize_t ret = 0;
+	loff_t pos;
+
+	if (!req->sg_cnt || !nr_bvec) {
+		nvmet_req_complete(req, 0);
+		return;
+	}
+
+	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC)
+		req->f.bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
+				GFP_KERNEL);
+	else
+		req->f.bvec = req->inline_bvec;
+
+	req->f.mpool_alloc = false;
+	if (unlikely(!req->f.bvec)) {
+		/* fallback under memory pressure */
+		req->f.bvec = mempool_alloc(req->ns->bvec_pool, GFP_KERNEL);
+		req->f.mpool_alloc = true;
+		if (nr_bvec > NVMET_MAX_MPOOL_BVEC)
+			is_sync = true;
+	}
+
+	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
+
+	memset(&req->f.iocb, 0, sizeof(struct kiocb));
+	for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
+		nvmet_file_init_bvec(&req->f.bvec[bv_cnt], &sg_pg_iter);
+		len += req->f.bvec[bv_cnt].bv_len;
+		total_len += req->f.bvec[bv_cnt].bv_len;
+		bv_cnt++;
+
+		WARN_ON_ONCE((nr_bvec - 1) < 0);
+
+		if (unlikely(is_sync) &&
+			(nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {
+			ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len);
+			if (ret < 0)
+				goto out;
+			pos += len;
+			bv_cnt = 0;
+			len = 0;
+		}
+		nr_bvec--;
+	}
+
+	if (WARN_ON_ONCE(total_len != req->data_len))
+		ret = -EIO;
+out:
+	if (unlikely(is_sync || ret)) {
+		nvmet_file_io_done(&req->f.iocb, ret < 0 ? ret : total_len, 0);
+		return;
+	}
+	req->f.iocb.ki_complete = nvmet_file_io_done;
+	nvmet_file_submit_bvec(req, pos, bv_cnt, total_len);
+}
+
+static void nvmet_file_flush_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	int ret;
+
+	ret = vfs_fsync(req->ns->file, 1);
+
+	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+}
+
+static void nvmet_file_execute_flush(struct nvmet_req *req)
+{
+	INIT_WORK(&req->f.work, nvmet_file_flush_work);
+	schedule_work(&req->f.work);
+}
+
+static void nvmet_file_execute_discard(struct nvmet_req *req)
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
+static void nvmet_file_dsm_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+
+	switch (le32_to_cpu(req->cmd->dsm.attributes)) {
+	case NVME_DSMGMT_AD:
+		nvmet_file_execute_discard(req);
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
+static void nvmet_file_execute_dsm(struct nvmet_req *req)
+{
+	INIT_WORK(&req->f.work, nvmet_file_dsm_work);
+	schedule_work(&req->f.work);
+}
+
+static void nvmet_file_write_zeroes_work(struct work_struct *w)
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
+static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
+{
+	INIT_WORK(&req->f.work, nvmet_file_write_zeroes_work);
+	schedule_work(&req->f.work);
+}
+
+u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	switch (cmd->common.opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+		req->execute = nvmet_file_execute_rw;
+		req->data_len = nvmet_rw_len(req);
+		return 0;
+	case nvme_cmd_flush:
+		req->execute = nvmet_file_execute_flush;
+		req->data_len = 0;
+		return 0;
+	case nvme_cmd_dsm:
+		req->execute = nvmet_file_execute_dsm;
+		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
+			sizeof(struct nvme_dsm_range);
+		return 0;
+	case nvme_cmd_write_zeroes:
+		req->execute = nvmet_file_execute_write_zeroes;
+		req->data_len = 0;
+		return 0;
+	default:
+		pr_err("unhandled cmd for file ns %d on qid %d\n",
+				cmd->common.opcode, req->sq->qid);
+		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+	}
+}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 15fd84a..2d09afc 100644
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
@@ -57,6 +58,8 @@ struct nvmet_ns {
 	struct config_group	group;
 
 	struct completion	disable_done;
+	mempool_t		*bvec_pool;
+	struct kmem_cache	*bvec_cache;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
@@ -222,8 +225,18 @@ struct nvmet_req {
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
+			bool			mpool_alloc;
+			struct kiocb            iocb;
+			struct bio_vec          *bvec;
+			struct work_struct      work;
+		} f;
+	};
 	int			sg_cnt;
 	/* data length as parsed from the command: */
 	size_t			data_len;
@@ -263,7 +276,8 @@ struct nvmet_async_event {
 };
 
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
-u16 nvmet_parse_io_cmd(struct nvmet_req *req);
+u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
+u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req);
 u16 nvmet_parse_discovery_cmd(struct nvmet_req *req);
 u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req);
@@ -338,4 +352,14 @@ extern struct rw_semaphore nvmet_config_sem;
 bool nvmet_host_allowed(struct nvmet_req *req, struct nvmet_subsys *subsys,
 		const char *hostnqn);
 
+int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
+int nvmet_file_ns_enable(struct nvmet_ns *ns);
+void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
+void nvmet_file_ns_disable(struct nvmet_ns *ns);
+
+static inline u32 nvmet_rw_len(struct nvmet_req *req)
+{
+	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
+			req->ns->blksize_shift;
+}
 #endif /* _NVMET_H */
-- 
2.9.5
