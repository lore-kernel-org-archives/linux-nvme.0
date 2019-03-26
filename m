From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 26 Mar 2019 11:19:28 +0800
Subject: [PATCH 4/4] nvmet: build bvec from sg directly
In-Reply-To: <20190326031928.9499-1-ming.lei@redhat.com>
References: <20190326031928.9499-1-ming.lei@redhat.com>
Message-ID: <20190326031928.9499-5-ming.lei@redhat.com>

NVMe target only accepts single-page sg list, so build bvec
from sg directly.

Cc: Yi Zhang <yi.zhang at redhat.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/target/io-cmd-file.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 149e17e699e5..bc6ebb51b0bf 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -75,12 +75,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	return ret;
 }
 
-static void nvmet_file_init_bvec(struct bio_vec *bv, struct sg_page_iter *iter)
+static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
 {
-	bv->bv_page = sg_page_iter_page(iter);
-	bv->bv_offset = iter->sg->offset;
-	bv->bv_len = min_t(unsigned, PAGE_SIZE - iter->sg->offset,
-			   iter->sg->length);
+	bv->bv_page = sg_page(sg);
+	bv->bv_offset = sg->offset;
+	bv->bv_len = sg->length;
 }
 
 static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
@@ -130,13 +129,13 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
 static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 {
 	ssize_t nr_bvec = req->sg_cnt;
-	struct sg_page_iter sg_pg_iter;
 	unsigned long bv_cnt = 0;
 	bool is_sync = false;
 	size_t len = 0, total_len = 0;
 	ssize_t ret = 0;
 	loff_t pos;
-
+	int i;
+	struct scatterlist *sg;
 
 	if (req->f.mpool_alloc && nr_bvec > NVMET_MAX_MPOOL_BVEC)
 		is_sync = true;
@@ -148,8 +147,8 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	}
 
 	memset(&req->f.iocb, 0, sizeof(struct kiocb));
-	for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
-		nvmet_file_init_bvec(&req->f.bvec[bv_cnt], &sg_pg_iter);
+	for_each_sg(req->sg, sg, req->sg_cnt, i) {
+		nvmet_file_init_bvec(&req->f.bvec[bv_cnt], sg);
 		len += req->f.bvec[bv_cnt].bv_len;
 		total_len += req->f.bvec[bv_cnt].bv_len;
 		bv_cnt++;
-- 
2.9.5
