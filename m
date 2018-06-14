From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 13 Jun 2018 20:54:24 -0400
Subject: [PATH V3] nvmet: allow file backed ns to use cache
Message-ID: <20180614005424.5023-1-chaitanya.kulkarni@wdc.com>

This is an incremental patch based on adding support for file backed
namespaces over NVMeOF target:-

http://lists.infradead.org/pipermail/linux-nvme/2018-May/017775.html/
http://lists.infradead.org/pipermail/linux-nvme/2018-May/017777.html.

We introduce "buffered_io" a new target namespace attribute. In default
execution, we set "buffered_io" to false. For Read/Write requests when
"buffered_io" is set we introduce per namespace workqueue.

In order to support the transparent mode switch between buffered and
direct I/O, we open two handles to a single file (with and without
O_DIRECT flag) and initialize all the resources needed for buffered I/O
when the user enables the file backed ns.

For each Read/Write request based on how "buffered_io" flag is set we
conditionally use IOCB_DIRECT flag for I/O submission.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Changes since V1 :-

1. Add support for transparent mode switch between buffered and direct I/O.
---
 drivers/nvme/target/configfs.c    | 25 +++++++++++++++
 drivers/nvme/target/core.c        |  1 +
 drivers/nvme/target/io-cmd-file.c | 66 +++++++++++++++++++++++++++++++++------
 drivers/nvme/target/nvmet.h       |  3 ++
 4 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d3f3b3ec4d1a..a3ee3f137b8c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -407,11 +407,36 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, enable);
 
+static ssize_t nvmet_ns_buffered_io_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n",
+			atomic_read(&to_nvmet_ns(item)->buffered_io));
+}
+
+static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool buffered_io;
+	int ret = 0;
+
+	if (strtobool(page, &buffered_io))
+		return -EINVAL;
+
+	if (ns->file)
+		atomic_set(&ns->buffered_io, buffered_io == true ? 1 : 0);
+
+	return ret ? ret : count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, buffered_io);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
 	&nvmet_ns_attr_device_uuid,
 	&nvmet_ns_attr_enable,
+	&nvmet_ns_attr_buffered_io,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a03da764ecae..22f36b32ff2e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -437,6 +437,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	ns->nsid = nsid;
 	ns->subsys = subsys;
 	uuid_gen(&ns->uuid);
+	atomic_set(&ns->buffered_io, 0);
 
 	return ns;
 }
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 8c42b3a8c420..2cbb3a21bbb9 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -13,13 +13,26 @@
 #define NVMET_MAX_MPOOL_BVEC		16
 #define NVMET_MIN_MPOOL_OBJ		16
 
+static inline struct file *nvmet_file_get_handle(struct nvmet_req *req)
+{
+	if (atomic_read(&req->ns->buffered_io) == 1)
+		return req->ns->file_cache;
+
+	return req->ns->file;
+}
+
 void nvmet_file_ns_disable(struct nvmet_ns *ns)
 {
 	if (ns->file) {
+		flush_workqueue(ns->file_wq);
+		destroy_workqueue(ns->file_wq);
+		ns->file_wq = NULL;
 		mempool_destroy(ns->bvec_pool);
 		ns->bvec_pool = NULL;
 		kmem_cache_destroy(ns->bvec_cache);
 		ns->bvec_cache = NULL;
+		fput(ns->file_cache);
+		ns->file_cache = NULL;
 		fput(ns->file);
 		ns->file = NULL;
 	}
@@ -27,17 +40,25 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
-	int ret;
+	int flags = O_RDWR | O_LARGEFILE;
 	struct kstat stat;
+	int ret;
 
-	ns->file = filp_open(ns->device_path,
-			O_RDWR | O_LARGEFILE | O_DIRECT, 0);
+	ns->file = filp_open(ns->device_path, flags | O_DIRECT, 0);
 	if (IS_ERR(ns->file)) {
 		pr_err("failed to open file %s: (%ld)\n",
 				ns->device_path, PTR_ERR(ns->file));
 		return PTR_ERR(ns->file);
 	}
 
+	ns->file_cache = filp_open(ns->device_path, flags, 0);
+	if (IS_ERR(ns->file_cache)) {
+		pr_err("failed to open buffered I/O file handle %s: (%ld)\n",
+				ns->device_path, PTR_ERR(ns->file_cache));
+		fput(ns->file);
+		return PTR_ERR(ns->file_cache);
+	}
+
 	ret = vfs_getattr(&ns->file->f_path,
 			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
 	if (ret)
@@ -62,6 +83,13 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		goto err;
 	}
 
+	ns->file_wq = alloc_workqueue("nvmet-file",
+			WQ_UNBOUND_MAX_ACTIVE | WQ_MEM_RECLAIM, 0);
+	if (!ns->file_wq) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
 	return ret;
 err:
 	ns->size = 0;
@@ -98,9 +126,10 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 
 	iov_iter_bvec(&iter, ITER_BVEC | rw, req->f.bvec, nr_segs, count);
 
+	ki_flags |= atomic_read(&req->ns->buffered_io) == 1 ? 0 : IOCB_DIRECT;
 	iocb->ki_pos = pos;
-	iocb->ki_filp = req->ns->file;
-	iocb->ki_flags = IOCB_DIRECT | ki_flags;
+	iocb->ki_filp = nvmet_file_get_handle(req);
+	iocb->ki_flags = ki_flags;
 
 	ret = call_iter(iocb, &iter);
 
@@ -189,12 +218,26 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 	nvmet_file_submit_bvec(req, pos, bv_cnt, total_len);
 }
 
+static void nvmet_file_buffered_io_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+
+	nvmet_file_execute_rw(req);
+}
+
+static void nvmet_file_execute_rw_buffered_io(struct nvmet_req *req)
+{
+	INIT_WORK(&req->f.work, nvmet_file_buffered_io_work);
+	queue_work(req->ns->file_wq, &req->f.work);
+}
+
 static void nvmet_file_flush_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	struct file *f = nvmet_file_get_handle(req);
 	int ret;
 
-	ret = vfs_fsync(req->ns->file, 1);
+	ret = vfs_fsync(f, 1);
 
 	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 }
@@ -207,6 +250,7 @@ static void nvmet_file_execute_flush(struct nvmet_req *req)
 
 static void nvmet_file_execute_discard(struct nvmet_req *req)
 {
+	struct file *f = nvmet_file_get_handle(req);
 	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
 	struct nvme_dsm_range range;
 	loff_t offset;
@@ -219,7 +263,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 			break;
 		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
 		len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
-		ret = vfs_fallocate(req->ns->file, mode, offset, len);
+		ret = vfs_fallocate(f, mode, offset, len);
 		if (ret)
 			break;
 	}
@@ -255,6 +299,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
 	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
 	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
+	struct file *f = nvmet_file_get_handle(req);
 	loff_t offset;
 	loff_t len;
 	int ret;
@@ -263,7 +308,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	len = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 			req->ns->blksize_shift);
 
-	ret = vfs_fallocate(req->ns->file, mode, offset, len);
+	ret = vfs_fallocate(f, mode, offset, len);
 	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 }
 
@@ -280,7 +325,10 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
-		req->execute = nvmet_file_execute_rw;
+		if (atomic_read(&req->ns->buffered_io) == 0)
+			req->execute = nvmet_file_execute_rw;
+		else
+			req->execute = nvmet_file_execute_rw_buffered_io;
 		req->data_len = nvmet_rw_len(req);
 		return 0;
 	case nvme_cmd_flush:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 480dfe10fad9..7b5ea2e5512c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -59,12 +59,15 @@ struct nvmet_ns {
 	struct percpu_ref	ref;
 	struct block_device	*bdev;
 	struct file		*file;
+	struct file		*file_cache;
 	u32			nsid;
 	u32			blksize_shift;
 	loff_t			size;
 	u8			nguid[16];
 	uuid_t			uuid;
 
+	atomic_t		buffered_io;
+	struct workqueue_struct *file_wq;
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
-- 
2.14.1
