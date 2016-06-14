From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 14 Jun 2016 07:27:21 -0700
Subject: [PATCH 04/11] nvmet: update for req_op changes
In-Reply-To: <1465389066-19119-5-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
 <1465389066-19119-5-git-send-email-hch@lst.de>
Message-ID: <20160614142721.GA17219@infradead.org>

FYI, this missed half of the fixups, here is the other half:

---
>From c5caa4c7c3ad5f9648e18f42687c0b63885f428d Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 14 Jun 2016 09:27:53 +0200
Subject: nvmet: more fixups for the op vs flags split

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/io-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 4cfd481..2cd069b6 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -73,6 +73,7 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
+	bio_set_op_attrs(bio, op, op_flags);
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
@@ -107,7 +108,7 @@ static void nvmet_execute_flush(struct nvmet_req *req)
 	bio->bi_bdev = req->ns->bdev;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
-	bio->bi_rw = WRITE_FLUSH;
+	bio_set_op_attrs(bio, REQ_OP_WRITE, WRITE_FLUSH);
 
 	submit_bio(bio);
 }
-- 
2.1.4
