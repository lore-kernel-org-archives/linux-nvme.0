From: keith.busch@intel.com (Keith Busch)
Date: Tue,  4 Aug 2015 13:32:13 -0600
Subject: [PATCHv4] blk: Replace SG_GAPGS with new queue limits mask
Message-ID: <1438716733-566-1-git-send-email-keith.busch@intel.com>

The SG_GAPS queue flag caused checks for bio vector alignment against
PAGE_SIZE, but the device may have different constraints. This patch
adds a queue limits so a driver with such constraints can set to allow
requests that would have been unnecessarily split. The new gaps check
takes the request_queue as a parameter to simplify the logic around
invoking this function.

This new limit makes the queue flag redundant, so removing it and
all usage. Device-mappers will inherit the correct settings through
blk_stack_limits().

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v3->v4:
  Simplified invoking bvec_gap_to_prev() by adding the request_queue
  parameter. A side effect from this required the function be moved form
  bio.h to blkdev.h to resolve a circular header dependency.

 block/bio.c               |    3 +--
 block/blk-merge.c         |   20 ++++++--------------
 block/blk-settings.c      |   14 ++++++++++++++
 drivers/block/nvme-core.c |    2 +-
 drivers/md/dm-table.c     |   13 -------------
 include/linux/bio.h       |    9 ---------
 include/linux/blkdev.h    |   21 ++++++++++++++++++++-
 7 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d6e5ba3..679a0fc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -770,8 +770,7 @@ static int __bio_add_page(struct request_queue *q, struct bio *bio, struct page
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
 		 */
-		if (q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS) &&
-		    bvec_gap_to_prev(prev, offset))
+		if (bvec_gap_to_prev(q, prev, offset))
 			return 0;
 	}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 30a0d9f..2030ccb 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -356,12 +356,12 @@ static bool req_no_special_merge(struct request *req)
 	return !q->mq_ops && req->special;
 }
 
-static int req_gap_to_prev(struct request *req, struct request *next)
+static int req_gap_to_prev(struct request *req, struct bio *next)
 {
 	struct bio *prev = req->biotail;
 
-	return bvec_gap_to_prev(&prev->bi_io_vec[prev->bi_vcnt - 1],
-				next->bio->bi_io_vec[0].bv_offset);
+	return bvec_gap_to_prev(req->q, &prev->bi_io_vec[prev->bi_vcnt - 1],
+			next->bi_io_vec[1].bv_offset);
 }
 
 static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
@@ -378,8 +378,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	if (req_no_special_merge(req) || req_no_special_merge(next))
 		return 0;
 
-	if (test_bit(QUEUE_FLAG_SG_GAPS, &q->queue_flags) &&
-	    req_gap_to_prev(req, next))
+	if (req_gap_to_prev(req, next->bio))
 		return 0;
 
 	/*
@@ -564,8 +563,6 @@ int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 {
-	struct request_queue *q = rq->q;
-
 	if (!rq_mergeable(rq) || !bio_mergeable(bio))
 		return false;
 
@@ -590,13 +587,8 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 		return false;
 
 	/* Only check gaps if the bio carries data */
-	if (q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS) && bio_has_data(bio)) {
-		struct bio_vec *bprev;
-
-		bprev = &rq->biotail->bi_io_vec[rq->biotail->bi_vcnt - 1];
-		if (bvec_gap_to_prev(bprev, bio->bi_io_vec[0].bv_offset))
-			return false;
-	}
+	if (bio_has_data(bio) && req_gap_to_prev(rq, bio))
+		return false;
 
 	return true;
 }
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 12600bf..1e9fc6c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -111,6 +111,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->max_segments = BLK_MAX_SEGMENTS;
 	lim->max_integrity_segments = 0;
 	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
+	lim->virt_boundary_mask = 0;
 	lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
 	lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
 	lim->chunk_sectors = 0;
@@ -550,6 +551,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
 					    b->seg_boundary_mask);
+	t->virt_boundary_mask = min_not_zero(t->virt_boundary_mask,
+					    b->virt_boundary_mask);
 
 	t->max_segments = min_not_zero(t->max_segments, b->max_segments);
 	t->max_integrity_segments = min_not_zero(t->max_integrity_segments,
@@ -788,6 +791,17 @@ void blk_queue_segment_boundary(struct request_queue *q, unsigned long mask)
 EXPORT_SYMBOL(blk_queue_segment_boundary);
 
 /**
+ * blk_queue_virt_boundary - set boundary rules for bio merging
+ * @q:  the request queue for the device
+ * @mask:  the memory boundary mask
+ **/
+void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
+{
+	q->limits.virt_boundary_mask = mask;
+}
+EXPORT_SYMBOL(blk_queue_virt_boundary);
+
+/**
  * blk_queue_dma_alignment - set dma length and memory alignment
  * @q:     the request queue for the device
  * @mask:  alignment mask
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..7e9dd11 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2067,7 +2067,6 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 		goto out_free_ns;
 	queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, ns->queue);
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
-	queue_flag_set_unlocked(QUEUE_FLAG_SG_GAPS, ns->queue);
 	ns->dev = dev;
 	ns->queue->queuedata = ns;
 
@@ -2087,6 +2086,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 		blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
 	if (dev->vwc & NVME_CTRL_VWC_PRESENT)
 		blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
+	blk_queue_virt_boundary(ns->queue, dev->page_size - 1);
 
 	disk->major = nvme_major;
 	disk->first_minor = 0;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 16ba55a..b3a8ab0 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1388,14 +1388,6 @@ static int queue_supports_sg_merge(struct dm_target *ti, struct dm_dev *dev,
 	return q && !test_bit(QUEUE_FLAG_NO_SG_MERGE, &q->queue_flags);
 }
 
-static int queue_supports_sg_gaps(struct dm_target *ti, struct dm_dev *dev,
-				  sector_t start, sector_t len, void *data)
-{
-	struct request_queue *q = bdev_get_queue(dev->bdev);
-
-	return q && !test_bit(QUEUE_FLAG_SG_GAPS, &q->queue_flags);
-}
-
 static bool dm_table_all_devices_attribute(struct dm_table *t,
 					   iterate_devices_callout_fn func)
 {
@@ -1516,11 +1508,6 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	else
 		queue_flag_set_unlocked(QUEUE_FLAG_NO_SG_MERGE, q);
 
-	if (dm_table_all_devices_attribute(t, queue_supports_sg_gaps))
-		queue_flag_clear_unlocked(QUEUE_FLAG_SG_GAPS, q);
-	else
-		queue_flag_set_unlocked(QUEUE_FLAG_SG_GAPS, q);
-
 	dm_table_set_integrity(t);
 
 	/*
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 5e963a6..8acb76c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -186,15 +186,6 @@ static inline void *bio_data(struct bio *bio)
 #define BIOVEC_SEG_BOUNDARY(q, b1, b2) \
 	__BIO_SEG_BOUNDARY(bvec_to_phys((b1)), bvec_to_phys((b2)) + (b2)->bv_len, queue_segment_boundary((q)))
 
-/*
- * Check if adding a bio_vec after bprv with offset would create a gap in
- * the SG list. Most drivers don't care about this, but some do.
- */
-static inline bool bvec_gap_to_prev(struct bio_vec *bprv, unsigned int offset)
-{
-	return offset || ((bprv->bv_offset + bprv->bv_len) & (PAGE_SIZE - 1));
-}
-
 #define bio_io_error(bio) bio_endio((bio), -EIO)
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d4068c1..68adec9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -258,6 +258,7 @@ struct blk_queue_tag {
 struct queue_limits {
 	unsigned long		bounce_pfn;
 	unsigned long		seg_boundary_mask;
+	unsigned long		virt_boundary_mask;
 
 	unsigned int		max_hw_sectors;
 	unsigned int		chunk_sectors;
@@ -486,7 +487,6 @@ struct request_queue {
 #define QUEUE_FLAG_DEAD        19	/* queue tear-down finished */
 #define QUEUE_FLAG_INIT_DONE   20	/* queue is initialized */
 #define QUEUE_FLAG_NO_SG_MERGE 21	/* don't attempt to merge SG segments*/
-#define QUEUE_FLAG_SG_GAPS     22	/* queue doesn't support SG gaps */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -986,6 +986,7 @@ extern int blk_queue_dma_drain(struct request_queue *q,
 			       void *buf, unsigned int size);
 extern void blk_queue_lld_busy(struct request_queue *q, lld_busy_fn *fn);
 extern void blk_queue_segment_boundary(struct request_queue *, unsigned long);
+extern void blk_queue_virt_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_prep_rq(struct request_queue *, prep_rq_fn *pfn);
 extern void blk_queue_unprep_rq(struct request_queue *, unprep_rq_fn *ufn);
 extern void blk_queue_merge_bvec(struct request_queue *, merge_bvec_fn *);
@@ -1154,6 +1155,11 @@ static inline unsigned long queue_segment_boundary(struct request_queue *q)
 	return q->limits.seg_boundary_mask;
 }
 
+static inline unsigned long queue_virt_boundary(struct request_queue *q)
+{
+	return q->limits.virt_boundary_mask;
+}
+
 static inline unsigned int queue_max_sectors(struct request_queue *q)
 {
 	return q->limits.max_sectors;
@@ -1354,6 +1360,19 @@ static inline void put_dev_sector(Sector p)
 	page_cache_release(p.v);
 }
 
+/*
+ * Check if adding a bio_vec after bprv with offset would create a gap in
+ * the SG list. Most drivers don't care about this, but some do.
+ */
+static inline bool bvec_gap_to_prev(struct request_queue *q,
+				struct bio_vec *bprv, unsigned int offset)
+{
+	if (!queue_virt_boundary(q))
+		return false;
+	return offset ||
+		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
+}
+
 struct work_struct;
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_schedule_delayed_work(struct delayed_work *dwork, unsigned long delay);
-- 
1.7.10.4
