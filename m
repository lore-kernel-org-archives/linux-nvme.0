From: keith.busch@intel.com (Keith Busch)
Date: Tue, 12 Jan 2016 15:08:39 -0700
Subject: [PATCH] block: split bios to max possible length
Message-ID: <1452636519-32697-1-git-send-email-keith.busch@intel.com>

This splits bio in the middle of a vector to form the largest possible
bio at the h/w's desired alignment, and guarantees the bio being split
will have some data.

The criteria for splitting is changed from the max sectors to the h/w's
optimal sector alignment if it is provided. For h/w that advertise their
block storage's underlying chunk size, it's a big performance win to not
submit commands that cross them. If sector alignment is not provided,
this patch uses the max sectors as before.

This addresses the performance issue commit d380561113 attempted to
fix, but was reverted due to splitting logic error.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Ming Lei <tom.leiming at gmail.com>
Cc: Kent Overstreet <kent.overstreet at gmail.com>
Cc: <stable at vger.kernel.org> # 4.4.x-
---
 block/blk-merge.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index e01405a..6b982ca 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -81,9 +81,6 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	struct bio *new = NULL;
 
 	bio_for_each_segment(bv, bio, iter) {
-		if (sectors + (bv.bv_len >> 9) > queue_max_sectors(q))
-			goto split;
-
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
@@ -91,6 +88,22 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		if (bvprvp && bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
 			goto split;
 
+		if (sectors + (bv.bv_len >> 9) >
+				blk_max_size_offset(q, bio->bi_iter.bi_sector)) {
+			/*
+			 * Consider this a new segment if we're splitting in
+			 * the middle of this vector.
+			 */
+			if (nsegs < queue_max_segments(q) &&
+			    sectors < blk_max_size_offset(q,
+						bio->bi_iter.bi_sector)) {
+				nsegs++;
+				sectors = blk_max_size_offset(q,
+						bio->bi_iter.bi_sector);
+			}
+			goto split;
+		}
+
 		if (bvprvp && blk_queue_cluster(q)) {
 			if (seg_size + bv.bv_len > queue_max_segment_size(q))
 				goto new_segment;
-- 
2.6.2.307.g37023ba
