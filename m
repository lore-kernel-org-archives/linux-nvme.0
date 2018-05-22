From: hch@lst.de (Christoph Hellwig)
Date: Tue, 22 May 2018 09:34:20 +0200
Subject: [PATCH V6] nvmet: add simple file backed ns support
In-Reply-To: <20180519073536.9712-1-chaitanya.kulkarni@wdc.com>
References: <20180519073536.9712-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180522073420.GA8655@lst.de>

Hi Chaitanya,

this looks great!

Reviewed-by: Christoph Hellwig <hch at lst.de>

Just a few cosmetic fixups for a minor resend, and one thing that
I think is a minor bug at the end:

> -nvmet-y		+= core.o configfs.o admin-cmd.o io-cmd.o fabrics-cmd.o \
> -			discovery.o
> +nvmet-y		+= core.o configfs.o admin-cmd.o io-cmd-bdev.o fabrics-cmd.o \

Please keep the length of the line under 80 chars for the makefile as
well.

> +	/* fallback under memory pressure */
> +
> +	req->f.mpool_alloc = false;

I'd remove the empty line above to keep the comment closer to the code
described by it.

> +		if (is_sync && (nr_bvec - 1 == 0 ||
> +					bv_cnt == NVMET_MAX_MPOOL_BVEC)) {

I usually try to align line breaks to boundaries of the logical operations
to make the statement easier to read, e.g.:

		if (is_sync &&
		    ((nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {

> +	if (likely(!is_sync)) {
> +		req->f.iocb.ki_complete = nvmet_file_io_done;
> +		nvmet_file_submit_bvec(req, pos, bv_cnt, map_len);
> +	} else if (req->f.mpool_alloc) {
> +		mempool_free(req->f.bvec, req->ns->bvec_pool);
> +		nvmet_req_complete(req,
> +				ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
> +	}

Don't we need to do the completion and freeing here also for the
non-mempool case?  What do you think about this patch that just
uses the completion handler for the sync case as well and cleans
up this function a bit:

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 3bc98b518bd4..9805bbfa0d86 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -66,14 +66,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	return ret;
 }
 
-static size_t nvmet_file_init_bvec(struct bio_vec *bv,
-		struct sg_page_iter *iter)
+static void nvmet_file_init_bvec(struct bio_vec *bv, struct sg_page_iter *iter)
 {
 	bv->bv_page = sg_page_iter_page(iter);
 	bv->bv_offset = iter->sg->offset;
 	bv->bv_len = PAGE_SIZE - iter->sg->offset;
-
-	return bv->bv_len;
 }
 
 static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
@@ -130,9 +127,8 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 	struct sg_page_iter sg_pg_iter;
 	unsigned long bv_cnt = 0;
 	bool is_sync = false;
-	size_t map_len = 0;
-	size_t len = 0;
-	ssize_t ret;
+	size_t len = 0, total_len = 0;
+	ssize_t ret = 0;
 	loff_t pos;
 
 	if (!req->sg_cnt || !nr_bvec) {
@@ -147,7 +143,6 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 		req->f.bvec = req->inline_bvec;
 
 	/* fallback under memory pressure */
-
 	req->f.mpool_alloc = false;
 	if (unlikely(!req->f.bvec)) {
 		req->f.bvec = mempool_alloc(req->ns->bvec_pool, GFP_KERNEL);
@@ -160,19 +155,18 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 	memset(&req->f.iocb, 0, sizeof(struct kiocb));
 	for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
-		map_len += nvmet_file_init_bvec(&req->f.bvec[bv_cnt],
-				&sg_pg_iter);
+		nvmet_file_init_bvec(&req->f.bvec[bv_cnt], &sg_pg_iter);
 		len += req->f.bvec[bv_cnt].bv_len;
+		total_len += req->f.bvec[bv_cnt].bv_len;
 		bv_cnt++;
 
-		WARN_ON((nr_bvec - 1) < 0);
+		WARN_ON_ONCE(nr_bvec - 1 < 0);
 
-		if (is_sync && (nr_bvec - 1 == 0 ||
-					bv_cnt == NVMET_MAX_MPOOL_BVEC)) {
+		if (unlikely(is_sync) &&
+		    (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {
 			ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len);
 			if (ret < 0)
-				goto err;
-
+				goto out;
 			pos += len;
 			bv_cnt = 0;
 			len = 0;
@@ -180,27 +174,15 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 		nr_bvec--;
 	}
 
-	if (map_len != req->data_len)
-		goto err;
-
-	if (likely(!is_sync)) {
-		req->f.iocb.ki_complete = nvmet_file_io_done;
-		nvmet_file_submit_bvec(req, pos, bv_cnt, map_len);
-	} else if (req->f.mpool_alloc) {
-		mempool_free(req->f.bvec, req->ns->bvec_pool);
-		nvmet_req_complete(req,
-				ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
-	}
-	return;
-err:
-	if (req->f.bvec != req->inline_bvec) {
-		if (req->f.mpool_alloc == false)
-			kfree(req->f.bvec);
-		else
-			mempool_free(req->f.bvec, req->ns->bvec_pool);
+	if (WARN_ON_ONCE(total_len != req->data_len))
+		ret = -EIO;
+out:
+	if (unlikely(is_sync || ret)) {
+		nvmet_file_io_done(&req->f.iocb, ret, 0);
+		return;
 	}
-
-	nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
+	req->f.iocb.ki_complete = nvmet_file_io_done;
+	nvmet_file_submit_bvec(req, pos, bv_cnt, total_len);
 }
 
 static void nvmet_file_flush_work(struct work_struct *w)
