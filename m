From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 16 Jul 2018 18:47:31 -0700
Subject: [RFC PATCH] nvmet: add file-ns buffered-io DSM IDR support
Message-ID: <1531792051-4916-1-git-send-email-chaitanya.kulkarni@wdc.com>

This implements the NVMe Dataset Management command attribute
Integral Dataset Read for file-ns when configured for with buffered-io
mode. Here we just issue reads to the lba range present as a part of
NVMe DSM command and populate the cache.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Hi,
        This is an attempt to use the Dataset management hinting to
        bring the specific LBA's into the cache from the disk. It will
        be great if I can get some feedback or suggestion to implement
        this feature for file-backed ns when configured in buffered I/O 
        mode. This RFC is light one details, just want to get the idea from
        everyone.

Regards,
Chaitanya
---
 drivers/nvme/target/io-cmd-file.c | 141 ++++++++++++++++++++++++++----
 1 file changed, 125 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0780925ca36f..426e94c31b9d 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -82,33 +82,44 @@ static void nvmet_file_init_bvec(struct bio_vec *bv, struct sg_page_iter *iter)
 	bv->bv_len = PAGE_SIZE - iter->sg->offset;
 }
 
-static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
-		unsigned long nr_segs, size_t count)
+static inline void nvmet_file_init_iocb(struct kiocb *iocb, struct file *f,
+		loff_t pos, int ki_flags)
+{
+	iocb->ki_filp = f;
+	iocb->ki_pos = pos;
+	iocb->ki_flags = ki_flags | iocb_flags(f);
+}
+
+static ssize_t __nvmet_file_submit_bvec(struct kiocb *iocb, struct bio_vec *bv,
+		int rw, unsigned long nr_segs, size_t count)
 {
-	struct kiocb *iocb = &req->f.iocb;
 	ssize_t (*call_iter)(struct kiocb *iocb, struct iov_iter *iter);
+	struct file *f = iocb->ki_filp;
 	struct iov_iter iter;
-	int ki_flags = 0, rw;
+
+	iov_iter_bvec(&iter, ITER_BVEC | rw, bv, nr_segs, count);
+
+	call_iter = rw == WRITE ? f->f_op->write_iter : f->f_op->read_iter;
+	return call_iter(iocb, &iter);
+}
+
+static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
+		unsigned long nr_bvec, size_t len)
+{
+	struct kiocb *iocb = &req->f.iocb;
+	int ki_flags = 0;
 	ssize_t ret;
+	int rw;
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			ki_flags = IOCB_DSYNC;
-		call_iter = req->ns->file->f_op->write_iter;
 		rw = WRITE;
-	} else {
-		call_iter = req->ns->file->f_op->read_iter;
+	} else
 		rw = READ;
-	}
-
-	iov_iter_bvec(&iter, ITER_BVEC | rw, req->f.bvec, nr_segs, count);
-
-	iocb->ki_pos = pos;
-	iocb->ki_filp = req->ns->file;
-	iocb->ki_flags = ki_flags | iocb_flags(req->ns->file);
-
-	ret = call_iter(iocb, &iter);
 
+	nvmet_file_init_iocb(iocb, req->ns->file, pos, ki_flags);
+	ret = __nvmet_file_submit_bvec(iocb, req->f.bvec, rw, nr_bvec, len);
 	if (ret != -EIOCBQUEUED && iocb->ki_complete)
 		iocb->ki_complete(iocb, ret, 0);
 
@@ -254,6 +265,99 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 }
 
+int nr_pages(void *data, unsigned int len)
+{
+	unsigned long kaddr = (unsigned long)data;
+	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long start = kaddr >> PAGE_SHIFT;
+
+	return end - start;
+}
+
+static ssize_t get_bvec(struct bio_vec **bvec, void *buf, unsigned int len)
+{
+	ssize_t max_vec = nr_pages(buf, len);
+	struct bio_vec *tbvec;
+	unsigned int offset;
+	struct page *page;
+	unsigned int size;
+	ssize_t i = -1;
+
+	tbvec = kmalloc(sizeof(*tbvec) * max_vec, GFP_KERNEL);
+	if (!tbvec)
+		goto out;
+
+	*bvec = tbvec;
+	offset = offset_in_page(buf);
+	for (i = 0; i < max_vec; i++) {
+		size = PAGE_SIZE - offset;
+		if (len <= 0)
+			break;
+		if (size > len)
+			size = len;
+
+		page = virt_to_page(buf);
+		tbvec->bv_page = page;
+		tbvec->bv_offset = offset;
+		tbvec->bv_len = size;
+
+		buf += size;
+		len -= size;
+		offset = 0;
+		tbvec++;
+	}
+
+	if (WARN_ON(len != 0)) {
+		kfree(*bvec);
+		*bvec = NULL;
+		i = -1;
+	}
+out:
+	return i;
+}
+
+static void nvmet_file_execute_idr(struct nvmet_req *req)
+{
+	struct bio_vec *bvec = NULL;
+	struct nvme_dsm_range range;
+	struct kiocb iocb;
+	ssize_t nr_bvec;
+	loff_t offset;
+	loff_t len;
+	int i, ret;
+	char *buf;
+
+	/* TODO : offload this loop to the worker thread & complete the req */
+	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
+		ret = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
+					sizeof(range));
+		if (ret)
+			break;
+		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
+		len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
+
+		/* TODO : chop len & allocate size < kmalloc alloc limit */
+		buf = kmalloc(len, GFP_KERNEL);
+		if (!buf) {
+			ret = -ENOMEM;
+			break;
+		}
+		nr_bvec = get_bvec(&bvec, buf, len);
+		if (!bvec) {
+			ret = -ENOMEM;
+			goto free;
+		}
+		nvmet_file_init_iocb(&iocb, req->ns->file, offset, 0);
+		ret = __nvmet_file_submit_bvec(&iocb, bvec, READ, nr_bvec, len);
+free:
+		kfree(bvec);
+		kfree(buf);
+		if (ret)
+			break;
+	}
+	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+}
+
 static void nvmet_file_dsm_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
@@ -263,6 +367,11 @@ static void nvmet_file_dsm_work(struct work_struct *w)
 		nvmet_file_execute_discard(req);
 		return;
 	case NVME_DSMGMT_IDR:
+		if (req->ns->buffered_io) {
+			nvmet_file_execute_idr(req);
+			return;
+		}
+		/* fall thru */
 	case NVME_DSMGMT_IDW:
 	default:
 		/* Not supported yet */
-- 
2.17.0
