From: keith.busch@intel.com (Keith Busch)
Date: Tue,  8 Jul 2014 11:42:38 -0600
Subject: [PATCH 1/2] block: Implement support for write zeros
Message-ID: <1404841359-24595-1-git-send-email-keith.busch@intel.com>

The 'write zeros' command supported on some block devices allows a device
to efficiently set a range of logical blocks to zero; no host allocated
logical block buffer required.

This patch implements support for 'write zeros' in the block layer,
and will be used from blkdev_issue_zeroout() as a first option if the
device supports this command type.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/bio.c               |    2 +-
 block/blk-core.c          |    5 ++++
 block/blk-lib.c           |   62 +++++++++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |    5 ++++
 block/blk-settings.c      |   12 +++++++++
 include/linux/bio.h       |    9 ++++---
 include/linux/blk_types.h |    6 +++--
 include/linux/blkdev.h    |   16 ++++++++++++
 8 files changed, 111 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 0ec61c9..082c717 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -647,7 +647,7 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
-	if (bio->bi_rw & REQ_DISCARD)
+	if (bio->bi_rw & (REQ_DISCARD | REQ_WRITE_ZEROS))
 		goto integrity_clone;
 
 	if (bio->bi_rw & REQ_WRITE_SAME) {
diff --git a/block/blk-core.c b/block/blk-core.c
index 6f8dba1..c67c002 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1824,6 +1824,11 @@ generic_make_request_checks(struct bio *bio)
 		goto end_io;
 	}
 
+	if (bio->bi_rw & REQ_WRITE_ZEROS && !bdev_write_zeros(bio->bi_bdev)) {
+		err = -EOPNOTSUPP;
+		goto end_io;
+	}
+
 	/*
 	 * Various block parts want %current->io_context and lazy ioc
 	 * allocation ends up trading a lot of pain for a small amount of
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 8411be3..0e28509 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -215,6 +215,64 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_write_same);
 
+int blkdev_issue_write_zeros(struct block_device *bdev, sector_t sector,
+			    sector_t nr_sects, gfp_t gfp_mask)
+{
+	DECLARE_COMPLETION_ONSTACK(wait);
+	struct request_queue *q = bdev_get_queue(bdev);
+	unsigned int max_write_zeros_sectors;
+	struct bio_batch bb;
+	struct bio *bio;
+	int ret = 0;
+
+	if (!q)
+		return -ENXIO;
+
+	max_write_zeros_sectors = q->limits.max_write_zeros_sectors;
+
+	if (max_write_zeros_sectors == 0)
+		return -EOPNOTSUPP;
+
+	atomic_set(&bb.done, 1);
+	bb.flags = 1 << BIO_UPTODATE;
+	bb.wait = &wait;
+
+	while (nr_sects) {
+		bio = bio_alloc(gfp_mask, 1);
+		if (!bio) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_end_io = bio_batch_end_io;
+		bio->bi_bdev = bdev;
+		bio->bi_private = &bb;
+
+		if (nr_sects > max_write_zeros_sectors) {
+			bio->bi_iter.bi_size = max_write_zeros_sectors << 9;
+			nr_sects -= max_write_zeros_sectors;
+			sector += max_write_zeros_sectors;
+		} else {
+			bio->bi_iter.bi_size = nr_sects << 9;
+			nr_sects = 0;
+		}
+
+		atomic_inc(&bb.done);
+		submit_bio(REQ_WRITE | REQ_WRITE_ZEROS, bio);
+	}
+
+	/* Wait for bios in-flight */
+	if (!atomic_dec_and_test(&bb.done))
+		wait_for_completion_io(&wait);
+
+	if (!test_bit(BIO_UPTODATE, &bb.flags))
+		ret = -ENOTSUPP;
+
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_issue_write_zeros);
+
 /**
  * blkdev_issue_zeroout - generate number of zero filed write bios
  * @bdev:	blockdev to issue
@@ -291,6 +349,10 @@ static int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 			 sector_t nr_sects, gfp_t gfp_mask)
 {
+	if (bdev_write_zeros(bdev)) {
+		if (!blkdev_issue_write_zeros(bdev, sector, nr_sects, gfp_mask))
+			return 0;
+	}
 	if (bdev_write_same(bdev)) {
 		unsigned char bdn[BDEVNAME_SIZE];
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 5453583..b0c3316 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -31,6 +31,9 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	if (bio->bi_rw & REQ_WRITE_SAME)
 		return 1;
 
+	if (bio->bi_rw & REQ_WRITE_ZEROS)
+		return 0;
+
 	fbio = bio;
 	cluster = blk_queue_cluster(q);
 	seg_size = 0;
@@ -210,6 +213,8 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 
 		return 0;
 	}
+	if (bio->bi_rw & REQ_WRITE_ZEROS)
+		return 0;
 
 	if (bio->bi_rw & REQ_WRITE_SAME) {
 single_segment:
diff --git a/block/blk-settings.c b/block/blk-settings.c
index f1a1795..0b7d1cf 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -322,6 +322,18 @@ void blk_queue_max_write_same_sectors(struct request_queue *q,
 EXPORT_SYMBOL(blk_queue_max_write_same_sectors);
 
 /**
+ * blk_queue_max_write_zeros_sectors - set max sectors for a single write zeros
+ * @q:  the request queue for the device
+ * @max_write_zeros_sectors: maximum number of sectors to write per command
+ **/
+void blk_queue_max_write_zeros_sectors(struct request_queue *q,
+				      unsigned int max_write_zeros_sectors)
+{
+	q->limits.max_write_zeros_sectors = max_write_zeros_sectors;
+}
+EXPORT_SYMBOL(blk_queue_max_write_zeros_sectors);
+
+/**
  * blk_queue_max_segments - set max hw segments for a request for this queue
  * @q:  the request queue for the device
  * @max_segments:  max number of segments
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d2633ee..56f02eb 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -106,7 +106,7 @@ static inline bool bio_has_data(struct bio *bio)
 {
 	if (bio &&
 	    bio->bi_iter.bi_size &&
-	    !(bio->bi_rw & REQ_DISCARD))
+	    !(bio->bi_rw & (REQ_DISCARD | REQ_WRITE_ZEROS)))
 		return true;
 
 	return false;
@@ -260,8 +260,8 @@ static inline unsigned bio_segments(struct bio *bio)
 	struct bvec_iter iter;
 
 	/*
-	 * We special case discard/write same, because they interpret bi_size
-	 * differently:
+	 * We special case discard/write same/zeros, because they interpret
+	 * bi_size differently:
 	 */
 
 	if (bio->bi_rw & REQ_DISCARD)
@@ -270,6 +270,9 @@ static inline unsigned bio_segments(struct bio *bio)
 	if (bio->bi_rw & REQ_WRITE_SAME)
 		return 1;
 
+	if (bio->bi_rw & REQ_WRITE_ZEROS)
+		return 1;
+
 	bio_for_each_segment(bv, bio, iter)
 		segs++;
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 66c2167..98d2295 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -160,6 +160,7 @@ enum rq_flag_bits {
 	__REQ_DISCARD,		/* request to discard sectors */
 	__REQ_SECURE,		/* secure discard (used with __REQ_DISCARD) */
 	__REQ_WRITE_SAME,	/* write same block many times */
+	__REQ_WRITE_ZEROS,	/* write zeros */
 
 	__REQ_NOIDLE,		/* don't anticipate more IO after this one */
 	__REQ_FUA,		/* forced unit access */
@@ -203,6 +204,7 @@ enum rq_flag_bits {
 #define REQ_PRIO		(1ULL << __REQ_PRIO)
 #define REQ_DISCARD		(1ULL << __REQ_DISCARD)
 #define REQ_WRITE_SAME		(1ULL << __REQ_WRITE_SAME)
+#define REQ_WRITE_ZEROS		(1ULL << __REQ_WRITE_ZEROS)
 #define REQ_NOIDLE		(1ULL << __REQ_NOIDLE)
 
 #define REQ_FAILFAST_MASK \
@@ -210,10 +212,10 @@ enum rq_flag_bits {
 #define REQ_COMMON_MASK \
 	(REQ_WRITE | REQ_FAILFAST_MASK | REQ_SYNC | REQ_META | REQ_PRIO | \
 	 REQ_DISCARD | REQ_WRITE_SAME | REQ_NOIDLE | REQ_FLUSH | REQ_FUA | \
-	 REQ_SECURE)
+	 REQ_SECURE | REQ_WRITE_ZEROS)
 #define REQ_CLONE_MASK		REQ_COMMON_MASK
 
-#define BIO_NO_ADVANCE_ITER_MASK	(REQ_DISCARD|REQ_WRITE_SAME)
+#define BIO_NO_ADVANCE_ITER_MASK	(REQ_DISCARD|REQ_WRITE_SAME|REQ_WRITE_ZEROS)
 
 /* This mask is used for both bio and request merge checking */
 #define REQ_NOMERGE_FLAGS \
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8699bcf..d896aa9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -289,6 +289,7 @@ struct queue_limits {
 	unsigned int		io_opt;
 	unsigned int		max_discard_sectors;
 	unsigned int		max_write_same_sectors;
+	unsigned int		max_write_zeros_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 
@@ -910,6 +911,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 	if (unlikely(cmd_flags & REQ_WRITE_SAME))
 		return q->limits.max_write_same_sectors;
 
+	if (unlikely(cmd_flags & REQ_WRITE_ZEROS))
+		return q->limits.max_write_zeros_sectors;
+
 	return q->limits.max_sectors;
 }
 
@@ -1011,6 +1015,8 @@ extern void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors);
 extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
+extern void blk_queue_max_write_zeros_sectors(struct request_queue *q,
+		unsigned int max_write_same_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned short);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_alignment_offset(struct request_queue *q,
@@ -1366,6 +1372,16 @@ static inline unsigned int bdev_write_same(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_write_zeros(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (q)
+		return q->limits.max_write_zeros_sectors;
+
+	return 0;
+}
+
 static inline int queue_dma_alignment(struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
-- 
1.7.10.4
