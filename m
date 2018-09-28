From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 27 Sep 2018 17:40:56 -0700
Subject: [PATCH 1/2 for-4.19] nvmet: handle bio allocation failure
Message-ID: <20180928004056.22968-1-sagi@grimberg.me>

We cannot rely on bio_alloc to succeed, so we first allocate
the needed bios in a list, and only then submit all of them so
we can cleanup if something fails in the process of building
the chained bios.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/io-cmd-bdev.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 7bc9f6240432..0664e2049fa4 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -59,9 +59,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
 	struct bio *bio = &req->b.inline_bio;
+	struct bio_list list;
 	struct scatterlist *sg;
 	sector_t sector;
-	blk_qc_t cookie;
+	blk_qc_t cookie = BLK_QC_T_NONE;
 	int op, op_flags = 0, i;
 
 	if (!req->sg_cnt) {
@@ -88,27 +89,39 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_end_io = nvmet_bio_done;
 	bio_set_op_attrs(bio, op, op_flags);
 
+	bio_list_init(&list);
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
 				!= sg->length) {
 			struct bio *prev = bio;
 
 			bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+			if (unlikely(!bio))
+				goto err;
+
 			bio_set_dev(bio, req->ns->bdev);
 			bio->bi_iter.bi_sector = sector;
 			bio_set_op_attrs(bio, op, op_flags);
 
 			bio_chain(bio, prev);
-			submit_bio(prev);
+			bio_list_add(&list, bio);
 		}
 
 		sector += sg->length >> 9;
 		sg_cnt--;
 	}
 
-	cookie = submit_bio(bio);
+	bio_list_add(&list, bio);
+	while ((bio = bio_list_pop(&list)))
+		cookie = submit_bio(bio);
 
 	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
+	return;
+err:
+	while ((bio = bio_list_pop(&list)))
+		if (bio != &req->b.inline_bio)
+			bio_put(bio);
+	nvmet_req_complete(req, NVME_SC_INTERNAL);
 }
 
 static void nvmet_bdev_execute_flush(struct nvmet_req *req)
-- 
2.17.1
