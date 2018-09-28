From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 28 Sep 2018 15:40:43 -0700
Subject: [PATCH v2] nvmet: don't split large I/Os unconditionally
Message-ID: <20180928224043.32134-1-sagi@grimberg.me>

If we know that the I/O size exceeds our inline bio vec, no
point using it and split the rest to begin with. We could
in theory reuse the inline bio and only allocate the bio_vec,
but its really not worth optimizing for.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- update change log
- rebased without bio_alloc failure handling patch

 drivers/nvme/target/io-cmd-bdev.c | 9 +++++++--
 drivers/nvme/target/nvmet.h       | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 7bc9f6240432..f93fb5711142 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -58,7 +58,7 @@ static void nvmet_bio_done(struct bio *bio)
 static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
-	struct bio *bio = &req->b.inline_bio;
+	struct bio *bio;
 	struct scatterlist *sg;
 	sector_t sector;
 	blk_qc_t cookie;
@@ -81,7 +81,12 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	sector = le64_to_cpu(req->cmd->rw.slba);
 	sector <<= (req->ns->blksize_shift - 9);
 
-	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	if (req->data_len <= NVMET_MAX_INLINE_DATA_LEN) {
+		bio = &req->b.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	} else {
+		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+	}
 	bio_set_dev(bio, req->ns->bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a056a4c96f67..10c96d43868d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -273,6 +273,7 @@ struct nvmet_fabrics_ops {
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
+#define NVMET_MAX_INLINE_DATA_LEN NVMET_MAX_INLINE_BIOVEC * PAGE_SIZE
 
 struct nvmet_req {
 	struct nvme_command	*cmd;
-- 
2.17.1
