From: hch@lst.de (Christoph Hellwig)
Date: Thu,  9 Nov 2017 14:29:27 +0100
Subject: [PATCH] nvmet: kill nvmet_inline_bio_init
Message-ID: <20171109132927.1766-1-hch@lst.de>

Much easier to just opencode this helper.  Also use ARRAY_SIZE instead of
passing the inline bvec array size manually.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/io-cmd.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index db632818777d..0a4372a016f2 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -33,18 +33,11 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
 			req->ns->blksize_shift;
 }
 
-static void nvmet_inline_bio_init(struct nvmet_req *req)
-{
-	struct bio *bio = &req->inline_bio;
-
-	bio_init(bio, req->inline_bvec, NVMET_MAX_INLINE_BIOVEC);
-}
-
 static void nvmet_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
+	struct bio *bio = &req->inline_bio;
 	struct scatterlist *sg;
-	struct bio *bio;
 	sector_t sector;
 	blk_qc_t cookie;
 	int op, op_flags = 0, i;
@@ -66,8 +59,7 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 	sector = le64_to_cpu(req->cmd->rw.slba);
 	sector <<= (req->ns->blksize_shift - 9);
 
-	nvmet_inline_bio_init(req);
-	bio = &req->inline_bio;
+	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	bio_set_dev(bio, req->ns->bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
@@ -99,11 +91,9 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 
 static void nvmet_execute_flush(struct nvmet_req *req)
 {
-	struct bio *bio;
-
-	nvmet_inline_bio_init(req);
-	bio = &req->inline_bio;
+	struct bio *bio = &req->inline_bio;
 
+	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
 	bio_set_dev(bio, req->ns->bdev);
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
-- 
2.14.2
