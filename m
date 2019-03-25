From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 25 Mar 2019 18:07:08 +0800
Subject: [PATCH 2/2] nvme: target: build bvec from sg directly
In-Reply-To: <20190325100708.24172-1-ming.lei@redhat.com>
References: <20190325100708.24172-1-ming.lei@redhat.com>
Message-ID: <20190325100708.24172-3-ming.lei@redhat.com>

Now multi-page bvec is supported, and the whole IO stack is capable
of handling multi-page bvec.

So build each bvec from the sg directly.

Cc: Yi Zhang <yi.zhang at redhat.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/target/io-cmd-file.c | 55 ++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 1c76e9e2a474..e2a92b85baa0 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -121,15 +121,14 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
 
 static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 {
-	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
+	ssize_t nr_bvec = req->sg_cnt;
 	struct scatterlist *sg;
-	struct bio_vec *bv;
 	unsigned long bv_cnt = 0;
 	bool is_sync = false;
 	size_t len = 0, total_len = 0;
 	ssize_t ret = 0;
 	loff_t pos;
-	int i, j, sg_done;
+	int i;
 
 	if (req->f.mpool_alloc && nr_bvec > NVMET_MAX_MPOOL_BVEC)
 		is_sync = true;
@@ -141,33 +140,31 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	}
 
 	memset(&req->f.iocb, 0, sizeof(struct kiocb));
-	for_each_sg(req->sg, sg, req->sg_cnt, i)
-		for (j = 0, sg_done = 0;
-		     (bv = &req->f.bvec[bv_cnt]) && sg_done < sg->length;
-		     j++, sg_done += bv->bv_len) {
-			bv->bv_offset = j ? 0 : sg->offset;
-			bv->bv_len = min_t(unsigned, PAGE_SIZE - bv->bv_offset,
-					   sg->length - sg_done);
-			bv->bv_page = nth_page(sg_page(sg), j);
-
-			len += bv->bv_len;
-			total_len += bv->bv_len;
-			bv_cnt++;
-
-			WARN_ON_ONCE((nr_bvec - 1) < 0);
-
-			if (unlikely(is_sync) &&
-			    (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {
-				ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len, 0);
-				if (ret < 0)
-					goto complete;
-
-				pos += len;
-				bv_cnt = 0;
-				len = 0;
-			}
-			nr_bvec--;
+	for_each_sg(req->sg, sg, req->sg_cnt, i) {
+		struct bio_vec *bv = &req->f.bvec[bv_cnt];
+
+		bv->bv_offset = sg->offset;
+		bv->bv_len = sg->length;
+		bv->bv_page = sg_page(sg);
+
+		len += bv->bv_len;
+		total_len += bv->bv_len;
+		bv_cnt++;
+
+		WARN_ON_ONCE((nr_bvec - 1) < 0);
+
+		if (unlikely(is_sync) &&
+		    (nr_bvec - 1 == 0 || bv_cnt == NVMET_MAX_MPOOL_BVEC)) {
+			ret = nvmet_file_submit_bvec(req, pos, bv_cnt, len, 0);
+			if (ret < 0)
+				goto complete;
+
+			pos += len;
+			bv_cnt = 0;
+			len = 0;
 		}
+		nr_bvec--;
+	}
 
 	if (WARN_ON_ONCE(total_len != req->data_len)) {
 		ret = -EIO;
-- 
2.9.5
