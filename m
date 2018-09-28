From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 27 Sep 2018 17:44:07 -0700
Subject: [PATCH 2/2] nvmet: don't split large I/Os unconditionally
Message-ID: <20180928004407.25237-1-sagi@grimberg.me>

If we know that the I/O size exceeds our inline bio vec, no
point using it and split the rest to begin with.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/io-cmd-bdev.c | 12 ++++++++++--
 drivers/nvme/target/nvmet.h       |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0664e2049fa4..9b299d3d2b22 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -58,7 +58,7 @@ static void nvmet_bio_done(struct bio *bio)
 static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
-	struct bio *bio = &req->b.inline_bio;
+	struct bio *bio;
 	struct bio_list list;
 	struct scatterlist *sg;
 	sector_t sector;
@@ -82,7 +82,14 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	sector = le64_to_cpu(req->cmd->rw.slba);
 	sector <<= (req->ns->blksize_shift - 9);
 
-	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	if (req->data_len <= NVMET_MAX_INLINE_DATA_LEN) {
+		bio = &req->b.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	} else {
+		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+		if (unlikely(!bio))
+			goto out;
+	}
 	bio_set_dev(bio, req->ns->bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
@@ -121,6 +128,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	while ((bio = bio_list_pop(&list)))
 		if (bio != &req->b.inline_bio)
 			bio_put(bio);
+out:
 	nvmet_req_complete(req, NVME_SC_INTERNAL);
 }
 
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
