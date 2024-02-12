Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4F1C4829F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4b5eRHEph3yRko4lq7ZaN4W/jCkJ/qWIhwup5Lem+cw=; b=y//3QKOlU6hy9xIajlXpXIzrsh
	im+MY6uWuWNLo6VtoCl6vERHAA2zAvDYWpgHeaMKevq4HikDz/YhoVKHpB/snikWZFP4SNOWrPXNM
	J+ZuhwMpPlme2H8iTMGtsfDIb0dMmrKJdET9IUqWobwDD7WSg5yj5AD6PXA+o6u5i8U1QPwXoj+a+
	jjp2pbLRQP4PDIJyqwDbu9X79WVimbvn5HfZ30qXmdUKRV7Lh+moWFxh0/y73EXV46LX3ZogFVvNL
	drDftJq2fKbW2yTHPbd/jWpjUsov4t+LLKE1FxKpVF0RYwsZiks+LV5PaZNSdivD4K5YtTSHnfkIA
	UURZU7nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5H-00000004Pcf-0asG;
	Mon, 12 Feb 2024 06:46:31 +0000
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5F-00000004Pak-0tN0;
	Mon, 12 Feb 2024 06:46:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH 04/15] block: add an API to atomically update queue limits
Date: Mon, 12 Feb 2024 07:45:58 +0100
Message-Id: <20240212064609.1327143-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212064609.1327143-1-hch@lst.de>
References: <20240212064609.1327143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a new queue_limits_{start,commit}_update pair of functions that
allows taking an atomic snapshot of queue limits, update it, and
commit it if it passes validity checking.  Also use the low-level
validation helper to implement blk_set_default_limits instead of
duplicating the initialization.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       |   1 +
 block/blk-settings.c   | 228 ++++++++++++++++++++++++++++++++++-------
 block/blk.h            |   4 +-
 include/linux/blkdev.h |  23 +++++
 4 files changed, 218 insertions(+), 38 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2b11d8325fde68..cb56724a8dfb25 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -425,6 +425,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	mutex_init(&q->debugfs_mutex);
 	mutex_init(&q->sysfs_lock);
 	mutex_init(&q->sysfs_dir_lock);
+	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1cae2db41490d2..27b9b4a2a85395 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -25,42 +25,6 @@ void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 }
 EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
 
-/**
- * blk_set_default_limits - reset limits to default values
- * @lim:  the queue_limits structure to reset
- *
- * Description:
- *   Returns a queue_limit struct to its default state.
- */
-void blk_set_default_limits(struct queue_limits *lim)
-{
-	lim->max_segments = BLK_MAX_SEGMENTS;
-	lim->max_discard_segments = 1;
-	lim->max_integrity_segments = 0;
-	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
-	lim->virt_boundary_mask = 0;
-	lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
-	lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
-	lim->max_user_sectors = lim->max_dev_sectors = 0;
-	lim->chunk_sectors = 0;
-	lim->max_write_zeroes_sectors = 0;
-	lim->max_zone_append_sectors = 0;
-	lim->max_discard_sectors = 0;
-	lim->max_hw_discard_sectors = 0;
-	lim->max_secure_erase_sectors = 0;
-	lim->discard_granularity = 512;
-	lim->discard_alignment = 0;
-	lim->discard_misaligned = 0;
-	lim->logical_block_size = lim->physical_block_size = lim->io_min = 512;
-	lim->bounce = BLK_BOUNCE_NONE;
-	lim->alignment_offset = 0;
-	lim->io_opt = 0;
-	lim->misaligned = 0;
-	lim->zoned = false;
-	lim->zone_write_granularity = 0;
-	lim->dma_alignment = 511;
-}
-
 /**
  * blk_set_stacking_limits - set default limits for stacking devices
  * @lim:  the queue_limits structure to reset
@@ -99,6 +63,198 @@ static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
 	bdi->io_pages = lim->max_sectors >> PAGE_SECTORS_SHIFT;
 }
 
+static int blk_validate_zoned_limits(struct queue_limits *lim)
+{
+	if (!lim->zoned) {
+		if (WARN_ON_ONCE(lim->max_open_zones) ||
+		    WARN_ON_ONCE(lim->max_active_zones) ||
+		    WARN_ON_ONCE(lim->zone_write_granularity) ||
+		    WARN_ON_ONCE(lim->max_zone_append_sectors))
+			return -EINVAL;
+		return 0;
+	}
+
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_BLK_DEV_ZONED)))
+		return -EINVAL;
+
+	if (lim->zone_write_granularity < lim->logical_block_size)
+		lim->zone_write_granularity = lim->logical_block_size;
+
+	if (lim->max_zone_append_sectors) {
+		/*
+		 * The Zone Append size is limited by the maximum I/O size
+		 * and the zone size given that it can't span zones.
+		 */
+		lim->max_zone_append_sectors =
+			min3(lim->max_hw_sectors,
+			     lim->max_zone_append_sectors,
+			     lim->chunk_sectors);
+	}
+
+	return 0;
+}
+
+/*
+ * Check that the limits in lim are valid, initialize defaults for unset
+ * values, and cap values based on others where needed.
+ */
+static int blk_validate_limits(struct queue_limits *lim)
+{
+	unsigned int max_hw_sectors;
+
+	/*
+	 * Unless otherwise specified, default to 512 byte logical blocks and a
+	 * physical block size equal to the logical block size.
+	 */
+	if (!lim->logical_block_size)
+		lim->logical_block_size = SECTOR_SIZE;
+	if (lim->physical_block_size < lim->logical_block_size)
+		lim->physical_block_size = lim->logical_block_size;
+
+	/*
+	 * The minimum I/O size defaults to the physical block size unless
+	 * explicitly overridden.
+	 */
+	if (lim->io_min < lim->physical_block_size)
+		lim->io_min = lim->physical_block_size;
+
+	/*
+	 * max_hw_sectors has a somewhat weird default for historical reason,
+	 * but driver really should set their own instead of relying on this
+	 * value.
+	 *
+	 * The block layer relies on the fact that every driver can
+	 * handle at lest a page worth of data per I/O, and needs the value
+	 * aligned to the logical block size.
+	 */
+	if (!lim->max_hw_sectors)
+		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
+	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SECTORS))
+		return -EINVAL;
+	lim->max_hw_sectors = round_down(lim->max_hw_sectors,
+			lim->logical_block_size >> SECTOR_SHIFT);
+
+	/*
+	 * The actual max_sectors value is a complex beast and also takes the
+	 * max_dev_sectors value (set by SCSI ULPs) and a user configurable
+	 * value into account.  The ->max_sectors value is always calculated
+	 * from these, so directly setting it won't have any effect.
+	 */
+	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
+				lim->max_dev_sectors);
+	if (lim->max_user_sectors) {
+		if (lim->max_user_sectors > max_hw_sectors ||
+		    lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
+			return -EINVAL;
+		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
+	} else {
+		lim->max_sectors = min(max_hw_sectors, BLK_DEF_MAX_SECTORS_CAP);
+	}
+	lim->max_sectors = round_down(lim->max_sectors,
+			lim->logical_block_size >> SECTOR_SHIFT);
+
+	/*
+	 * Random default for the maximum number of sectors.  Driver should not
+	 * rely on this and set their own.
+	 */
+	if (!lim->max_segments)
+		lim->max_segments = BLK_MAX_SEGMENTS;
+
+	lim->max_discard_sectors = lim->max_hw_discard_sectors;
+	if (!lim->max_discard_segments)
+		lim->max_discard_segments = 1;
+
+	if (lim->discard_granularity < lim->physical_block_size)
+		lim->discard_granularity = lim->physical_block_size;
+
+	/*
+	 * By default there is no limit on the segment boundary alignment,
+	 * but if there is one it can't be smaller than the page size as
+	 * that would break all the normal I/O patterns.
+	 */
+	if (!lim->seg_boundary_mask)
+		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
+	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
+		return -EINVAL;
+
+	/*
+	 * The maximum segment size has an odd historic 64k default that
+	 * drivers probably should override.  Just like the I/O size we
+	 * require drivers to at least handle a full page per segment.
+	 */
+	if (!lim->max_segment_size)
+		lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
+	if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
+		return -EINVAL;
+
+	/*
+	 * Devices that require a virtual boundary do not support scatter/gather
+	 * I/O natively, but instead require a descriptor list entry for each
+	 * page (which might not be identical to the Linux PAGE_SIZE).  Because
+	 * of that they are not limited by our notion of "segment size".
+	 */
+	if (lim->virt_boundary_mask) {
+		if (WARN_ON_ONCE(lim->max_segment_size &&
+				 lim->max_segment_size != UINT_MAX))
+			return -EINVAL;
+		lim->max_segment_size = UINT_MAX;
+	}
+
+	/*
+	 * We require drivers to at least do logical block aligned I/O, but
+	 * historically could not check for that due to the separate calls
+	 * to set the limits.  Once the transition is finished the check
+	 * below should be narrowed down to check the logical block size.
+	 */
+	if (!lim->dma_alignment)
+		lim->dma_alignment = SECTOR_SIZE - 1;
+	if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
+		return -EINVAL;
+
+	if (lim->alignment_offset) {
+		lim->alignment_offset &= (lim->physical_block_size - 1);
+		lim->misaligned = 0;
+	}
+
+	return blk_validate_zoned_limits(lim);
+}
+
+/*
+ * Set the default limits for a newly allocated queue.  @lim contains the
+ * initial limits set by the driver, which could be no limit in which case
+ * all fields are cleared to zero.
+ */
+int blk_set_default_limits(struct queue_limits *lim)
+{
+	return blk_validate_limits(lim);
+}
+
+/**
+ * queue_limits_commit_update - commit an atomic update of queue limits
+ * @q:		queue to update
+ * @lim:	limits to apply
+ *
+ * Apply the limits in @lim that were obtained from queue_limits_start_update()
+ * and updated by the caller to @q.
+ *
+ * Returns 0 if successful, else a negative error code.
+ */
+int queue_limits_commit_update(struct request_queue *q,
+		struct queue_limits *lim)
+	__releases(q->limits_lock)
+{
+	int error = blk_validate_limits(lim);
+
+	if (!error) {
+		q->limits = *lim;
+		if (q->disk)
+			blk_apply_bdi_limits(q->disk->bdi, lim);
+	}
+	mutex_unlock(&q->limits_lock);
+	return error;
+}
+EXPORT_SYMBOL_GPL(queue_limits_commit_update);
+
 /**
  * blk_queue_bounce_limit - set bounce buffer limit for queue
  * @q: the request queue for the device
diff --git a/block/blk.h b/block/blk.h
index 913c93838a01bf..7c30e2ac8ebcd3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -330,7 +330,7 @@ void blk_rq_set_mixed_merge(struct request *rq);
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
 
-void blk_set_default_limits(struct queue_limits *lim);
+int blk_set_default_limits(struct queue_limits *lim);
 int blk_dev_init(void);
 
 /*
@@ -448,7 +448,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
 		unpin_user_page(page);
 }
 
-struct request_queue *blk_alloc_queue(int node_id);
+struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index de9251922f7583..97c01efed68253 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -473,6 +473,7 @@ struct request_queue {
 
 	struct mutex		sysfs_lock;
 	struct mutex		sysfs_dir_lock;
+	struct mutex		limits_lock;
 
 	/*
 	 * for reusing dead hctx instance in case of updating
@@ -861,6 +862,28 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
 	return chunk_sectors - (offset & (chunk_sectors - 1));
 }
 
+/**
+ * queue_limits_start_update - start an atomic update of queue limits
+ * @q:		queue to update
+ *
+ * This functions starts an atomic update of the queue limits.  It takes a lock
+ * to prevent other updates and returns a snapshot of the current limits that
+ * the caller can modify.  The caller must call queue_limits_commit_update()
+ * to finish the update.
+ *
+ * Context: process context.  The caller must have frozen the queue or ensured
+ * that there is outstanding I/O by other means.
+ */
+static inline struct queue_limits
+queue_limits_start_update(struct request_queue *q)
+	__acquires(q->limits_lock)
+{
+	mutex_lock(&q->limits_lock);
+	return q->limits;
+}
+int queue_limits_commit_update(struct request_queue *q,
+		struct queue_limits *lim);
+
 /*
  * Access functions for manipulating queue properties
  */
-- 
2.39.2


