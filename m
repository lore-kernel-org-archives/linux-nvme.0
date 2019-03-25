From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 25 Mar 2019 18:07:07 +0800
Subject: [PATCH 1/2] nvme: target: fix nvmet_file_init_bvec()
In-Reply-To: <20190325100708.24172-1-ming.lei@redhat.com>
References: <20190325100708.24172-1-ming.lei@redhat.com>
Message-ID: <20190325100708.24172-2-ming.lei@redhat.com>

There isn't sg iterator helper for building bvec, so invent one
and fix the issue in nvmet_file_init_bvec().

The issue is that one sg may include multipge continuous pages, and
only the 1st .bv_offset isn't zero, also the length for the last bvec
has to consider the remained length.

Reported-by: Yi Zhang <yi.zhang at redhat.com>
Fixes: d5eff33ee6f8("nvmet: add simple file backed ns support")
Cc: Yi Zhang <yi.zhang at redhat.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Cc: <stable at vger.kernel.org>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/target/io-cmd-file.c | 57 ++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 3e43212d3c1c..1c76e9e2a474 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -75,13 +75,6 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	return ret;
 }
 
-static void nvmet_file_init_bvec(struct bio_vec *bv, struct sg_page_iter *iter)
-{
-	bv->bv_page = sg_page_iter_page(iter);
-	bv->bv_offset = iter->sg->offset;
-	bv->bv_len = PAGE_SIZE - iter->sg->offset;
-}
-
 static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 		unsigned long nr_segs, size_t count, int ki_flags)
 {
@@ -129,13 +122,14 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
 static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 {
 	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
-	struct sg_page_iter sg_pg_iter;
+	struct scatterlist *sg;
+	struct bio_vec *bv;
 	unsigned long bv_cnt = 0;
 	bool is_sync = false;
 	size_t len = 0, total_len = 0;
 	ssize_t ret = 0;
 	loff_t pos;
-
+	int i, j, sg_done;
 
 	if (req->f.mpool_alloc && nr_bvec > NVMET_MAX_MPOOL_BVEC)
 		is_sync = true;
@@ -147,26 +141,33 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	}
 
 	memset(&req->f.iocb, 0, sizeof(struct kiocb));
-	for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
-		nvmet_file_init_bvec(&req->f.bvec[bv_cnt], &sg_pg_iter);
-		len += req->f.bvec[bv_cnt].bv_len;
-		total_len += req->f.bvec[bv_cnt].bv_len;
-		bv_cnt++;
-
-		WARN_ON_ONCE((nr_bvec - 1) < 0);
-
-		if (unlikely(is_sync) &&
-		    (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {
-			ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len, 0);
-			if (ret < 0)
-				goto complete;
-
-			pos += len;
-			bv_cnt = 0;
-			len = 0;
+	for_each_sg(req->sg, sg, req->sg_cnt, i)
+		for (j = 0, sg_done = 0;
+		     (bv = &req->f.bvec[bv_cnt]) && sg_done < sg->length;
+		     j++, sg_done += bv->bv_len) {
+			bv->bv_offset = j ? 0 : sg->offset;
+			bv->bv_len = min_t(unsigned, PAGE_SIZE - bv->bv_offset,
+					   sg->length - sg_done);
+			bv->bv_page = nth_page(sg_page(sg), j);
+
+			len += bv->bv_len;
+			total_len += bv->bv_len;
+			bv_cnt++;
+
+			WARN_ON_ONCE((nr_bvec - 1) < 0);
+
+			if (unlikely(is_sync) &&
+			    (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {
+				ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len, 0);
+				if (ret < 0)
+					goto complete;
+
+				pos += len;
+				bv_cnt = 0;
+				len = 0;
+			}
+			nr_bvec--;
 		}
-		nr_bvec--;
-	}
 
 	if (WARN_ON_ONCE(total_len != req->data_len)) {
 		ret = -EIO;
-- 
2.9.5
