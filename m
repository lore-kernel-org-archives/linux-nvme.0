From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Nov 2018 02:42:56 -0800
Subject: [RFC][PATCH] nvmet: use IOCB_NOWAIT for file-ns buffered I/O
In-Reply-To: <20180810050806.4366-1-chaitanya.kulkarni@wdc.com>
References: <20180810050806.4366-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181108104256.GA27435@infradead.org>

This looks generally fine.  I think we can make the responsibility
for who has to complete the request a little more clear with something
like the patch below.  The added benefit is that we also don't
retry for non-EAGAIN errors, which are fatal.

Btw, did you get a chance to run some benchmarks on this code?

---
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index bf04866f52e7..62e7ba3d888b 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -83,14 +83,11 @@ static void nvmet_file_init_bvec(struct bio_vec *bv, struct sg_page_iter *iter)
 }
 
 static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
-		unsigned long nr_segs, size_t count, bool nowait)
+		unsigned long nr_segs, size_t count, int ki_flags)
 {
 	struct kiocb *iocb = &req->f.iocb;
 	ssize_t (*call_iter)(struct kiocb *iocb, struct iov_iter *iter);
-	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
-	int ki_flags = nowait ? IOCB_NOWAIT : 0;
 	struct iov_iter iter;
-	ssize_t ret;
 	int rw;
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
@@ -109,32 +106,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	iocb->ki_filp = req->ns->file;
 	iocb->ki_flags = ki_flags | iocb_flags(req->ns->file);
 
-	if (nowait) {
-		ki_complete = iocb->ki_complete;
-		iocb->ki_complete = NULL;
-	}
-
-	ret = call_iter(iocb, &iter);
-
-	if (nowait) {
-		/* keep the completion for nowait == true separate */
-		if (ret > 0)
-			ki_complete(iocb, ret, 0);
-		/*
-		 * We don't complete the request when we get an error for
-		 * nowait == true. Instead just return and offload the I/O
-		 * to worker thread. Worker thread will reissue the I/O
-		 * without IOCB_NOWAIT and complete the request.
-		 */
-		goto out;
-	}
-
-
-	if (ret != -EIOCBQUEUED && iocb->ki_complete)
-		iocb->ki_complete(iocb, ret, 0);
-
-out:
-	return ret;
+	return call_iter(iocb, &iter);
 }
 
 static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
@@ -152,7 +124,7 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
 			NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 }
 
-static ssize_t nvmet_file_execute_io(struct nvmet_req *req, bool nowait)
+static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 {
 	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
 	struct sg_page_iter sg_pg_iter;
@@ -168,7 +140,7 @@ static ssize_t nvmet_file_execute_io(struct nvmet_req *req, bool nowait)
 	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
 	if (unlikely(pos + req->data_len > req->ns->size)) {
 		nvmet_req_complete(req, NVME_SC_LBA_RANGE | NVME_SC_DNR);
-		return -EIO;
+		return true;
 	}
 
 	memset(&req->f.iocb, 0, sizeof(struct kiocb));
@@ -182,9 +154,9 @@ static ssize_t nvmet_file_execute_io(struct nvmet_req *req, bool nowait)
 
 		if (unlikely(is_sync) &&
 		    (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {
-			ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len, nowait);
+			ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len, 0);
 			if (ret < 0)
-				goto out;
+				goto complete;
 			pos += len;
 			bv_cnt = 0;
 			len = 0;
@@ -192,26 +164,42 @@ static ssize_t nvmet_file_execute_io(struct nvmet_req *req, bool nowait)
 		nr_bvec--;
 	}
 
-	if (WARN_ON_ONCE(total_len != req->data_len))
+	if (WARN_ON_ONCE(total_len != req->data_len)) {
 		ret = -EIO;
-out:
-	if (unlikely(is_sync || ret)) {
-		/* for nowait == false complete the request */
-		if (!nowait)
-			nvmet_file_io_done(&req->f.iocb,
-					ret < 0 ? ret : total_len, 0);
-		/* for nowait == true offload the I/O, we just return */
-		return ret;
+		goto complete;
+	}
+
+	if (unlikely(is_sync)) {
+		ret = total_len;
+		goto complete;
+	}
+
+	/*
+	 * A NULL ki_complete ask for synchronous execution, which we want
+	 * for the IOCB_NOWAIT case.
+	 */
+	if (!(ki_flags & IOCB_NOWAIT))
+		req->f.iocb.ki_complete = nvmet_file_io_done;
+
+	ret = nvmet_file_submit_bvec(req, pos, bv_cnt, total_len, ki_flags);
+	if (ret == -EIOCBQUEUED)
+		return true;
+	if (ret == -EAGAIN) {
+		if (WARN_ON_ONCE(!(ki_flags & IOCB_NOWAIT)))
+			goto complete;
+		return false;
 	}
-	req->f.iocb.ki_complete = nvmet_file_io_done;
-	return nvmet_file_submit_bvec(req, pos, bv_cnt, total_len, nowait);
+
+complete:
+	nvmet_file_io_done(&req->f.iocb, ret, 0);
+	return true;
 }
 
 static void nvmet_file_buffered_io_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
 
-	nvmet_file_execute_io(req, false);
+	nvmet_file_execute_io(req, 0);
 }
 
 static void nvmet_file_submit_buffered_io(struct nvmet_req *req)
@@ -223,7 +211,6 @@ static void nvmet_file_submit_buffered_io(struct nvmet_req *req)
 static void nvmet_file_execute_rw(struct nvmet_req *req)
 {
 	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
-	ssize_t ret;
 
 	if (!req->sg_cnt || !nr_bvec) {
 		nvmet_req_complete(req, 0);
@@ -244,14 +231,13 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 		req->f.mpool_alloc = false;
 
 	if (req->ns->buffered_io) {
-		if (likely(!req->f.mpool_alloc)) {
-			ret = nvmet_file_execute_io(req, true);
-			if (ret > 0)
-				return;
-		}
+		if (likely(!req->f.mpool_alloc) &&
+		    nvmet_file_execute_io(req, IOCB_NOWAIT))
+			return;
 		nvmet_file_submit_buffered_io(req);
-	} else
-		nvmet_file_execute_io(req, false);
+	} else {
+		nvmet_file_execute_io(req, 0);
+	}
 }
 
 u16 nvmet_file_flush(struct nvmet_req *req)
