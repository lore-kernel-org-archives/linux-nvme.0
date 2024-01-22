Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E85C47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=52aHFJZJgSpZSzGsXJ9gQ/byUa4eJvkbOMdIjhNPR1s=; b=eDEe6GeNoXVeHnctDtHBXzjznm
	cZFezg4C2n5XkXl0plUnP/qNqLZBimyBMg1HtqsQVpyeqzxwU0CN3kkbKfsfgEaQJd2lVBvWFPTd9
	pFBgi4Zu+lOSuR2E7RaIUAudFUygfBcjcTOjH160NPcMoKzbldTtzfWuk7tlyV4uYVtTe/9++I03T
	T32krU3Arr4hsiZm7FFIPerl8eaA/nTz/D5V8RwVpSGECcpT1CvtyfIWyNw7FnY1BnRd+NnovMSCP
	3/uIKgTHPwxxaTxuFTel/S5ME16rMnmV+ttxfgNAWgHPIVqal7Psa/+tBO/udm4LHPfPZ+AcQEbZQ
	toUURHTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEE-00DGfk-0E;
	Mon, 22 Jan 2024 17:36:58 +0000
Received: from [2001:4bb8:198:a22c:146a:86ef:5806:b115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEC-00DGdV-1P;
	Mon, 22 Jan 2024 17:36:56 +0000
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
Subject: [PATCH 03/15] block: add an API to atomically update queue limits
Date: Mon, 22 Jan 2024 18:36:33 +0100
Message-Id: <20240122173645.1686078-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122173645.1686078-1-hch@lst.de>
References: <20240122173645.1686078-1-hch@lst.de>
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
commit it if it passes validity checking.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       |   1 +
 block/blk-settings.c   | 140 +++++++++++++++++++++++++++++++++++++++++
 block/blk.h            |   1 +
 include/linux/blkdev.h |  23 +++++++
 4 files changed, 165 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 11342af420d0c4..09f4a44a4aa3cc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -424,6 +424,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	mutex_init(&q->debugfs_mutex);
 	mutex_init(&q->sysfs_lock);
 	mutex_init(&q->sysfs_dir_lock);
+	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index e872b0e168525e..b6692143ccf034 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -96,6 +96,146 @@ static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
 	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
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
+		if (WARN_ON_ONCE(!lim->chunk_sectors))
+			return -EINVAL;
+		lim->max_zone_append_sectors =
+			min3(lim->max_hw_sectors,
+			     lim->max_zone_append_sectors,
+			     lim->chunk_sectors);
+	}
+
+	return 0;
+}
+
+int blk_validate_limits(struct queue_limits *lim)
+{
+	unsigned int max_hw_sectors;
+
+	if (!lim->logical_block_size)
+		lim->logical_block_size = SECTOR_SIZE;
+
+	if (!lim->physical_block_size)
+		lim->physical_block_size = SECTOR_SIZE;
+	if (lim->physical_block_size < lim->logical_block_size)
+		lim->physical_block_size = lim->physical_block_size;
+
+	if (!lim->io_min)
+		lim->io_min = SECTOR_SIZE;
+	if (lim->io_min < lim->physical_block_size)
+		lim->io_min = lim->physical_block_size;
+
+	if (!lim->max_hw_sectors)
+		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
+	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SIZE / SECTOR_SIZE))
+		return -EINVAL;
+
+	lim->max_hw_sectors = round_down(lim->max_hw_sectors,
+			lim->logical_block_size >> SECTOR_SHIFT);
+
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
+
+	lim->max_sectors = round_down(lim->max_sectors,
+			lim->logical_block_size >> SECTOR_SHIFT);
+
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
+	if (!lim->seg_boundary_mask)
+		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
+	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (!lim->max_segment_size)
+		lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
+	if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
+		return -EINVAL;
+
+	/*
+	 * Devices that require a virtual boundary do not support scatter/gather
+	 * I/O natively, but instead require a descriptor list entry for each
+	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
+	 * of that they are not limited by our notion of "segment size".
+	 */
+	if (lim->virt_boundary_mask) {
+		if (WARN_ON_ONCE(lim->max_segment_size &&
+				 lim->max_segment_size != UINT_MAX))
+			return -EINVAL;
+		lim->max_segment_size = UINT_MAX;
+	}
+
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
index 1ef920f72e0f87..58b5dbac2a487d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -447,6 +447,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
 		unpin_user_page(page);
 }
 
+int blk_validate_limits(struct queue_limits *lim);
 struct request_queue *blk_alloc_queue(int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4a2e82c7971c86..5b5d3b238de1e7 100644
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


