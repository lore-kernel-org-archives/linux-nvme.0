From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 Dec 2015 15:48:44 -0700
Subject: [PATCH] block: Split bios on chunk boundaries
Message-ID: <1450824524-5413-1-git-send-email-keith.busch@intel.com>

For h/w that advertise their block storage's underlying chunk size, it's
a big performance win to not submit commands that cross them. This patch
uses that criteria if it is provided. If it is not provided, this patch
uses the max sectors as before.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 0e5643a..d05fdd2 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -83,7 +83,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	struct bio *new = NULL;
 
 	bio_for_each_segment(bv, bio, iter) {
-		if (sectors + (bv.bv_len >> 9) > queue_max_sectors(q))
+		if (sectors + (bv.bv_len >> 9) > blk_max_size_offset(q, bio->bi_iter.bi_sector))
 			goto split;
 
 		/*
-- 
2.6.2.307.g37023ba
