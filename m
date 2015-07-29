From: keith.busch@intel.com (Keith Busch)
Date: Wed, 29 Jul 2015 11:01:53 -0600
Subject: [PATCH] blk: add vector gaps queue parameter
Message-ID: <1438189313-29722-1-git-send-email-keith.busch@intel.com>

SG_GAPS queue flag checks for bio vector alignment against PAGE_SIZE,
but the device may have different constraints. This patch adds a new
mask to queue limits a driver with such constraints can set to allow
forming requests that would have previously been unnecessarily split.

Since nvme is the only driver using this, the patch includes this driver
setting the mask.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/bio.c               |    2 +-
 block/blk-merge.c         |    6 ++++--
 block/blk-settings.c      |   14 +++++++++++++-
 drivers/block/nvme-core.c |    1 +
 include/linux/bio.h       |    4 ++--
 include/linux/blkdev.h    |    6 ++++++
 6 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d6e5ba3..6483091 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -771,7 +771,7 @@ static int __bio_add_page(struct request_queue *q, struct bio *bio, struct page
 		 * offset would create a gap, disallow it.
 		 */
 		if (q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS) &&
-		    bvec_gap_to_prev(prev, offset))
+		    bvec_gap_to_prev(prev, offset, queue_virt_mask(q)))
 			return 0;
 	}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 30a0d9f..4fe11cf 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -361,7 +361,8 @@ static int req_gap_to_prev(struct request *req, struct request *next)
 	struct bio *prev = req->biotail;
 
 	return bvec_gap_to_prev(&prev->bi_io_vec[prev->bi_vcnt - 1],
-				next->bio->bi_io_vec[0].bv_offset);
+				next->bio->bi_io_vec[0].bv_offset,
+				queue_virt_mask(req->q));
 }
 
 static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
@@ -594,7 +595,8 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 		struct bio_vec *bprev;
 
 		bprev = &rq->biotail->bi_io_vec[rq->biotail->bi_vcnt - 1];
-		if (bvec_gap_to_prev(bprev, bio->bi_io_vec[0].bv_offset))
+		if (bvec_gap_to_prev(bprev, bio->bi_io_vec[0].bv_offset,
+							queue_virt_mask(q)))
 			return false;
 	}
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 12600bf..4acd505 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -111,6 +111,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->max_segments = BLK_MAX_SEGMENTS;
 	lim->max_integrity_segments = 0;
 	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
+	lim->virt_mask = 0;
 	lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
 	lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
 	lim->chunk_sectors = 0;
@@ -550,7 +551,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
 					    b->seg_boundary_mask);
-
+	t->virt_mask = min_not_zero(t->virt_mask, b->virt_mask);
 	t->max_segments = min_not_zero(t->max_segments, b->max_segments);
 	t->max_integrity_segments = min_not_zero(t->max_integrity_segments,
 						 b->max_integrity_segments);
@@ -788,6 +789,17 @@ void blk_queue_segment_boundary(struct request_queue *q, unsigned long mask)
 EXPORT_SYMBOL(blk_queue_segment_boundary);
 
 /**
+ * blk_queue_virt_boundary - set boundary rules for bio merging
+ * @q:  the request queue for the device
+ * @mask:  the memory boundary mask
+ **/
+void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
+{
+	q->limits.virt_mask = mask;
+}
+EXPORT_SYMBOL(blk_queue_virt_boundary);
+
+/**
  * blk_queue_dma_alignment - set dma length and memory alignment
  * @q:     the request queue for the device
  * @mask:  alignment mask
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..1993cc8 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2087,6 +2087,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 		blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
 	if (dev->vwc & NVME_CTRL_VWC_PRESENT)
 		blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
+	blk_queue_virt_boundary(ns->queue, dev->page_size - 1);
 
 	disk->major = nvme_major;
 	disk->first_minor = 0;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 5e963a6..9f906c5 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -190,9 +190,9 @@ static inline void *bio_data(struct bio *bio)
  * Check if adding a bio_vec after bprv with offset would create a gap in
  * the SG list. Most drivers don't care about this, but some do.
  */
-static inline bool bvec_gap_to_prev(struct bio_vec *bprv, unsigned int offset)
+static inline bool bvec_gap_to_prev(struct bio_vec *bprv, unsigned int offset, unsigned long mask)
 {
-	return offset || ((bprv->bv_offset + bprv->bv_len) & (PAGE_SIZE - 1));
+	return offset || ((bprv->bv_offset + bprv->bv_len) & mask);
 }
 
 #define bio_io_error(bio) bio_endio((bio), -EIO)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d4068c1..4e28fb5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -258,6 +258,7 @@ struct blk_queue_tag {
 struct queue_limits {
 	unsigned long		bounce_pfn;
 	unsigned long		seg_boundary_mask;
+	unsigned long		virt_mask;
 
 	unsigned int		max_hw_sectors;
 	unsigned int		chunk_sectors;
@@ -1154,6 +1155,11 @@ static inline unsigned long queue_segment_boundary(struct request_queue *q)
 	return q->limits.seg_boundary_mask;
 }
 
+static inline unsigned long queue_virt_mask(struct request_queue *q)
+{
+	return q->limits.virt_mask;
+}
+
 static inline unsigned int queue_max_sectors(struct request_queue *q)
 {
 	return q->limits.max_sectors;
-- 
1.7.10.4
