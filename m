From: hch@lst.de (Christoph Hellwig)
Date: Mon, 14 May 2018 15:30:35 +0200
Subject: [PATCH V4] nvmet: add simple file backed ns support
In-Reply-To: <CAK0tqinRJzSU=1ZvnHE3ntcwMHsHcEODNYZQRR+kJfijeM52KQ@mail.gmail.com>
References: <20180510214508.4563-1-chaitanya.kulkarni@wdc.com>
 <20180511070040.GA8633@lst.de>
 <CAK0tqinRJzSU=1ZvnHE3ntcwMHsHcEODNYZQRR+kJfijeM52KQ@mail.gmail.com>
Message-ID: <20180514133035.GA26579@lst.de>

On Fri, May 11, 2018@10:50:06AM -0700, chaitany kulkarni wrote:
> > Can you just make this an anonymous union so that identifiers stay
> > short and crispy?
> >
> 
> I was not able to find a way to use container_of with anonymous unions
> so kept the code without anonymous unions for now.

Relative patch to your below that uses an anonymous union:

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index a5f787b21a75..b0550737e39e 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -19,15 +19,6 @@
 
 #include "nvmet.h"
 
-static struct nvmet_req *nvmet_get_req_from_work(struct work_struct *w)
-{
-	struct nvmet_ns_file_handle *f =
-		container_of(w, struct nvmet_ns_file_handle, io_work);
-	union ns_handle *u =  container_of(f, union ns_handle, f);
-
-	return container_of(u, struct nvmet_req, handle);
-}
-
 static void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
@@ -35,7 +26,7 @@ static void nvmet_bio_done(struct bio *bio)
 	nvmet_req_complete(req,
 		bio->bi_status ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 
-	if (bio != &req->handle.b.inline_bio)
+	if (bio != &req->b.inline_bio)
 		bio_put(bio);
 }
 
@@ -48,7 +39,7 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
 static void nvmet_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
-	struct bio *bio = &req->handle.b.inline_bio;
+	struct bio *bio = &req->b.inline_bio;
 	struct scatterlist *sg;
 	sector_t sector;
 	blk_qc_t cookie;
@@ -103,13 +94,10 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 
 static void nvmet_file_io_complete(struct kiocb *iocb, long ret, long ret2)
 {
-	struct nvmet_ns_file_handle *f =
-		container_of(iocb, struct nvmet_ns_file_handle, iocb);
-	union ns_handle *u =  container_of(f, union ns_handle, f);
-	struct nvmet_req *req = container_of(u, struct nvmet_req, handle);
+	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
 
-	if (req->handle.f.bvec != req->inline_bvec)
-		kfree(req->handle.f.bvec);
+	if (req->f.bvec != req->inline_bvec)
+		kfree(req->f.bvec);
 
 	nvmet_req_complete(req, ret != req->data_len ?
 			NVME_SC_INTERNAL | NVME_SC_DNR : 0);
@@ -120,36 +108,35 @@ static void nvmet_execute_rw_file(struct nvmet_req *req)
 	int rw = req->cmd->rw.opcode == nvme_cmd_write ? WRITE : READ;
 	u32 nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
 	struct sg_page_iter sg_pg_iter;
-	struct bio_vec *bvec;
 	struct iov_iter iter;
-	struct kiocb *iocb;
+	struct kiocb *iocb = &req->f.iocb;
 	ssize_t len = 0, ret;
 	int bv_cnt = 0;
 	loff_t pos;
 
-	bvec = req->inline_bvec;
 	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC) {
-		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
+		req->f.bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				GFP_KERNEL);
-		if (!bvec)
+		if (!req->f.bvec)
 			goto out;
+	} else {
+		req->f.bvec = req->inline_bvec;
 	}
-	req->handle.f.bvec = bvec;
-	iocb = &req->handle.f.iocb;
 
 	for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
-		bvec[bv_cnt].bv_page = sg_page_iter_page(&sg_pg_iter);
-		bvec[bv_cnt].bv_offset = sg_pg_iter.sg->offset;
-		bvec[bv_cnt].bv_len = PAGE_SIZE - sg_pg_iter.sg->offset;
-		len += bvec[bv_cnt].bv_len;
+		req->f.bvec[bv_cnt].bv_page = sg_page_iter_page(&sg_pg_iter);
+		req->f.bvec[bv_cnt].bv_offset = sg_pg_iter.sg->offset;
+		req->f.bvec[bv_cnt].bv_len = PAGE_SIZE - sg_pg_iter.sg->offset;
+		len += req->f.bvec[bv_cnt].bv_len;
 		bv_cnt++;
 	}
 
 	if (len != req->data_len)
 		goto free;
 
-	iov_iter_bvec(&iter, ITER_BVEC | rw, bvec, bv_cnt, len);
+	iov_iter_bvec(&iter, ITER_BVEC | rw, req->f.bvec, bv_cnt, len);
 	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
+	memset(iocb, 0, sizeof(*iocb));
 	iocb->ki_pos = pos;
 	iocb->ki_filp = req->ns->file;
 	iocb->ki_flags = IOCB_DIRECT;
@@ -166,15 +153,15 @@ static void nvmet_execute_rw_file(struct nvmet_req *req)
 		nvmet_file_io_complete(iocb, ret, 0);
 	return;
 free:
-	if (bvec != req->inline_bvec)
-		kfree(req->handle.f.bvec);
+	if (req->f.bvec != req->inline_bvec)
+		kfree(req->f.bvec);
 out:
 	nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
 }
 
 static void nvmet_execute_flush(struct nvmet_req *req)
 {
-	struct bio *bio = &req->handle.b.inline_bio;
+	struct bio *bio = &req->b.inline_bio;
 
 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	bio_set_dev(bio, req->ns->bdev);
@@ -187,7 +174,7 @@ static void nvmet_execute_flush(struct nvmet_req *req)
 
 static void nvmet_flush_work_file(struct work_struct *w)
 {
-	struct nvmet_req *req = nvmet_get_req_from_work(w);
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
 	u16 status = NVME_SC_SUCCESS;
 	int ret;
 
@@ -200,7 +187,8 @@ static void nvmet_flush_work_file(struct work_struct *w)
 
 static void nvmet_execute_flush_file(struct nvmet_req *req)
 {
-	schedule_work(&req->handle.f.io_work);
+	INIT_WORK(&req->f.work, nvmet_flush_work_file);
+	schedule_work(&req->f.work);
 }
 
 static u16 nvmet_discard_range(struct nvmet_ns *ns,
@@ -288,7 +276,7 @@ static void nvmet_execute_discard_file(struct nvmet_req *req)
 
 static void nvmet_dsm_work_file(struct work_struct *w)
 {
-	struct nvmet_req *req = nvmet_get_req_from_work(w);
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
 
 	switch (le32_to_cpu(req->cmd->dsm.attributes)) {
 	case NVME_DSMGMT_AD:
@@ -305,7 +293,8 @@ static void nvmet_dsm_work_file(struct work_struct *w)
 
 static void nvmet_execute_dsm_file(struct nvmet_req *req)
 {
-	schedule_work(&req->handle.f.io_work);
+	INIT_WORK(&req->f.work, nvmet_dsm_work_file);
+	schedule_work(&req->f.work);
 }
 
 static void nvmet_execute_write_zeroes(struct nvmet_req *req)
@@ -336,7 +325,7 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 
 static void nvmet_write_zeroes_work_file(struct work_struct *w)
 {
-	struct nvmet_req *req = nvmet_get_req_from_work(w);
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
 	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
 	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
 	loff_t offset;
@@ -353,7 +342,8 @@ static void nvmet_write_zeroes_work_file(struct work_struct *w)
 
 static void nvmet_execute_write_zeroes_file(struct nvmet_req *req)
 {
-	schedule_work(&req->handle.f.io_work);
+	INIT_WORK(&req->f.work, nvmet_write_zeroes_work_file);
+	schedule_work(&req->f.work);
 }
 
 static u16 nvmet_parse_io_cmd_blkdev(struct nvmet_req *req)
@@ -393,24 +383,19 @@ u16 nvmet_parse_io_cmd_file(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
-		req->handle.f.bvec = NULL;
-		memset(&req->handle.f.iocb, 0, sizeof(req->handle.f.iocb));
 		req->execute = nvmet_execute_rw_file;
 		req->data_len = nvmet_rw_len(req);
 		return 0;
 	case nvme_cmd_flush:
 		req->execute = nvmet_execute_flush_file;
-		INIT_WORK(&req->handle.f.io_work, nvmet_flush_work_file);
 		req->data_len = 0;
 		return 0;
 	case nvme_cmd_dsm:
-		INIT_WORK(&req->handle.f.io_work, nvmet_dsm_work_file);
 		req->execute = nvmet_execute_dsm_file;
 		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
 			sizeof(struct nvme_dsm_range);
 		return 0;
 	case nvme_cmd_write_zeroes:
-		INIT_WORK(&req->handle.f.io_work, nvmet_write_zeroes_work_file);
 		req->execute = nvmet_execute_write_zeroes_file;
 		req->data_len = 0;
 		return 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5a91d9ba464b..04c76aa67e3c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -216,22 +216,6 @@ struct nvmet_fabrics_ops {
 
 #define NVMET_MAX_INLINE_BIOVEC	8
 
-
-struct nvmet_ns_bdev_handle {
-	struct bio		inline_bio;
-};
-
-struct nvmet_ns_file_handle {
-	struct kiocb		iocb;
-	struct bio_vec		*bvec;
-	struct work_struct	io_work;
-};
-
-union ns_handle {
-	struct nvmet_ns_bdev_handle	b;
-	struct nvmet_ns_file_handle	f;
-};
-
 struct nvmet_req {
 	struct nvme_command	*cmd;
 	struct nvme_completion	*rsp;
@@ -240,7 +224,16 @@ struct nvmet_req {
 	struct nvmet_ns		*ns;
 	struct scatterlist	*sg;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
-	union  ns_handle	handle;
+	union {
+		struct {
+			struct bio	inline_bio;
+		} b;
+		struct {
+			struct kiocb		iocb;
+			struct bio_vec		*bvec;
+			struct work_struct	work;
+		} f;
+	};
 	int			sg_cnt;
 	/* data length as parsed from the command: */
 	size_t			data_len;
