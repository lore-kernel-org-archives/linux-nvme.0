From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu,  9 Aug 2018 22:08:06 -0700
Subject: [RFC][PATCH] nvmet: use IOCB_NOWAIT for file-ns buffered I/O
Message-ID: <20180810050806.4366-1-chaitanya.kulkarni@wdc.com>

This patch optimizes read command behavior when file-ns configured
with buffered I/O. Instead of offloading the buffered I/O read operations
to the worker threads, we first issue the read operation with IOCB_NOWAIT
and try and access the data from the cache. Here we only offload the
request to the worker thread and complete the request in the worker
thread context when IOCB_NOWAIT request fails.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Hi,

This is an attempt to optimize the buffered I/O read requests for
file-backed namespce by using previously introduced flag IOCB_NOWAIT.
It will be great if I can get some feedback on how to improve the code.

Also, I'm thinking if this patch is accepted then we should have one
patch for error injection as file-backed namespace code in io-cmd-file.c
is getting more complex since the initial submission, any thuoghts ?

Regards,
Chaitanya
---
 drivers/nvme/target/io-cmd-file.c | 108 ++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 81a9dc5290a8..489f5d3d9d30 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -83,17 +83,19 @@ static void nvmet_file_init_bvec(struct bio_vec *bv, struct sg_page_iter *iter)
 }
 
 static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
-		unsigned long nr_segs, size_t count)
+		unsigned long nr_segs, size_t count, bool nowait)
 {
 	struct kiocb *iocb = &req->f.iocb;
 	ssize_t (*call_iter)(struct kiocb *iocb, struct iov_iter *iter);
+	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
+	int ki_flags = nowait ? IOCB_NOWAIT : 0;
 	struct iov_iter iter;
-	int ki_flags = 0, rw;
 	ssize_t ret;
+	int rw;
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
-			ki_flags = IOCB_DSYNC;
+			ki_flags |= IOCB_DSYNC;
 		call_iter = req->ns->file->f_op->write_iter;
 		rw = WRITE;
 	} else {
@@ -107,11 +109,31 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	iocb->ki_filp = req->ns->file;
 	iocb->ki_flags = ki_flags | iocb_flags(req->ns->file);
 
+	if (nowait) {
+		ki_complete = iocb->ki_complete;
+		iocb->ki_complete = NULL;
+	}
+
 	ret = call_iter(iocb, &iter);
 
+	if (nowait) {
+		/* keep the completion for nowait == true separate */
+		if (ret > 0)
+			ki_complete(iocb, ret, 0);
+		/*
+		 * We don't complete the request when we get an error for
+		 * nowait == true. Instead just return and offload the I/O
+		 * to worker thread. Worker thread will reissue the I/O
+		 * without IOCB_NOWAIT and complete the request.
+		 */
+		goto out;
+	}
+
+
 	if (ret != -EIOCBQUEUED && iocb->ki_complete)
 		iocb->ki_complete(iocb, ret, 0);
 
+out:
 	return ret;
 }
 
@@ -130,7 +152,7 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
 			NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 }
 
-static void nvmet_file_execute_rw(struct nvmet_req *req)
+static ssize_t nvmet_file_execute_io(struct nvmet_req *req, bool nowait)
 {
 	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
 	struct sg_page_iter sg_pg_iter;
@@ -140,30 +162,13 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 	ssize_t ret = 0;
 	loff_t pos;
 
-	if (!req->sg_cnt || !nr_bvec) {
-		nvmet_req_complete(req, 0);
-		return;
-	}
+	if (req->f.mpool_alloc && nr_bvec > NVMET_MAX_MPOOL_BVEC)
+		is_sync = true;
 
 	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
 	if (unlikely(pos + req->data_len > req->ns->size)) {
 		nvmet_req_complete(req, NVME_SC_LBA_RANGE | NVME_SC_DNR);
-		return;
-	}
-
-	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC)
-		req->f.bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
-				GFP_KERNEL);
-	else
-		req->f.bvec = req->inline_bvec;
-
-	req->f.mpool_alloc = false;
-	if (unlikely(!req->f.bvec)) {
-		/* fallback under memory pressure */
-		req->f.bvec = mempool_alloc(req->ns->bvec_pool, GFP_KERNEL);
-		req->f.mpool_alloc = true;
-		if (nr_bvec > NVMET_MAX_MPOOL_BVEC)
-			is_sync = true;
+		return -EIO;
 	}
 
 	memset(&req->f.iocb, 0, sizeof(struct kiocb));
@@ -177,7 +182,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 		if (unlikely(is_sync) &&
 		    (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {
-			ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len);
+			ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len, nowait);
 			if (ret < 0)
 				goto out;
 			pos += len;
@@ -191,26 +196,64 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 		ret = -EIO;
 out:
 	if (unlikely(is_sync || ret)) {
-		nvmet_file_io_done(&req->f.iocb, ret < 0 ? ret : total_len, 0);
-		return;
+		/* for nowait == false complete the request */
+		if (!nowait)
+			nvmet_file_io_done(&req->f.iocb,
+					ret < 0 ? ret : total_len, 0);
+		/* for nowait == true offload the I/O, we just return */
+		return ret;
 	}
 	req->f.iocb.ki_complete = nvmet_file_io_done;
-	nvmet_file_submit_bvec(req, pos, bv_cnt, total_len);
+	return nvmet_file_submit_bvec(req, pos, bv_cnt, total_len, nowait);
 }
 
 static void nvmet_file_buffered_io_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
 
-	nvmet_file_execute_rw(req);
+	nvmet_file_execute_io(req, false);
 }
 
-static void nvmet_file_execute_rw_buffered_io(struct nvmet_req *req)
+static void nvmet_file_submit_buffered_io(struct nvmet_req *req)
 {
 	INIT_WORK(&req->f.work, nvmet_file_buffered_io_work);
 	queue_work(buffered_io_wq, &req->f.work);
 }
 
+static void nvmet_file_execute_rw(struct nvmet_req *req)
+{
+	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
+	ssize_t ret;
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
+	if (unlikely(!req->f.bvec)) {
+		/* fallback under memory pressure */
+		req->f.bvec = mempool_alloc(req->ns->bvec_pool, GFP_KERNEL);
+		req->f.mpool_alloc = true;
+	} else
+		req->f.mpool_alloc = false;
+
+	if (req->ns->buffered_io) {
+		if (likely(!req->f.mpool_alloc)) {
+			ret = nvmet_file_execute_io(req, true);
+			if (ret > 0)
+				return;
+		}
+		nvmet_file_submit_buffered_io(req);
+	} else
+		nvmet_file_execute_io(req, false);
+}
+
 u16 nvmet_file_flush(struct nvmet_req *req)
 {
 	if (vfs_fsync(req->ns->file, 1) < 0)
@@ -319,10 +362,7 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
-		if (req->ns->buffered_io)
-			req->execute = nvmet_file_execute_rw_buffered_io;
-		else
-			req->execute = nvmet_file_execute_rw;
+		req->execute = nvmet_file_execute_rw;
 		req->data_len = nvmet_rw_len(req);
 		return 0;
 	case nvme_cmd_flush:
-- 
2.17.0
