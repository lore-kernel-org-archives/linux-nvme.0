Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E7EC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PCVmnvQFFyCj5ju94vMfehfJWI1ilef6LRrwOVAWNU0=; b=RdouDx7Mx+cH8fewo5UiIkosJz
	2YyQXkuPzUWNgD+zMyFsYO+LHAaB3TDx+UGHc8hX30OW0WrapYMBc70t+8LsfTxX6Kvxlcgfe02/9
	X7HXzW4xygD+SyXG5YBa2EEeA/qQMXEx3ja3nBXu/zh0GckVejkuLbR2M1KaqsNRzF45OQSxpIUw6
	r4z/ftujn7wI3wZiEGjC5xPhp1B5a0l4gk5js7UVpcBI7dNuty11esaiMIB1q9++LJGQkg9tEyVtR
	fDqhSs4Uy7sclnV0ACzbOfKh1VhK8VYPj9ruuwtR84v+WL31pyrKR6Igffg8dJHgqQAFFFgjudHf4
	KobLxy4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdv6-0000000Bp6G-1Izv;
	Thu, 28 Mar 2024 00:47:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdtT-0000000Bo1Q-2i5k
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 Mar 2024 00:45:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=PCVmnvQFFyCj5ju94vMfehfJWI1ilef6LRrwOVAWNU0=; b=nrlTdz+S9K1hJ5SC3QhwrYXwVU
	tM08cxc6ddIYGRPM0pQUh7oWLJ/lo49Hs8LSm+mBv4nHf7uoMKzLC7VVpK2KoH+N8tyAqvh8ZcroU
	5MW1mCP531L2VBaI4jY4ufwyiTP8SQoNxTjviTk2b0olwBKAh7VVxGDtYKzci6wE/oKl/vBKMUwEl
	6K2fhbhPGWpv14wIMNO+d6fXCaw6ZdwTUtTOR51YZnIq8lIZi7A0bF1fC8eBJoKlT0Tbo7GOXxR3Z
	7mig77ozd0k+pax8pz+AMHOe2HCEjpB8blhtwi2/bpYTyr9bHxmUGr8rq/+BIQWbnOz2+tctv/iKL
	pSqbPWAg==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdtQ-000000058Bx-1Rli
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:45:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 00A7F616EC;
	Thu, 28 Mar 2024 00:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B20C43390;
	Thu, 28 Mar 2024 00:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586699;
	bh=SMibVC6FbqZm3EdFrCOhKLnOv95kT9vjzeUSiCaWZw4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZvRdQdUv/x0JtRJXlNp4nxbH5MCVeS/vFqgcuRsuFCHgeGmgkhtZi9Y4NDwTAIHEx
	 OalEo39oGE6OqgiGSLlgneqV85vJ++JaZ0qOqgwwvEcn7jAQJL49ZT+w8z3/cJU9Az
	 O9rUFRqrij9ZQCM57JfgO7Pvscd4rXy1YCWh2jS80fQ1u1n1QJxYq3i06KwzeBpwLU
	 sre+Be6Oo5UDEFLVoPzThxJTHNTp8pMJjBQPWi6nmvjtoFlnttw7a8C8b0nTiYCDcr
	 bhC2IuNgsm9rytEs3BPXYezK38B6y6BCKFOGs0g7Fkym5+atqZHFoLX7hGr0+XSJlH
	 bC7ivhl6fs+2w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 28/30] block: Remove zone write locking
Date: Thu, 28 Mar 2024 09:44:07 +0900
Message-ID: <20240328004409.594888-29-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_004520_680433_0D932A06 
X-CRM114-Status: GOOD (  19.21  )
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

Zone write locking is now unused and replaced with zone write plugging.
Remove all code that was implementing zone write locking, that is, the
various helper functions controlling request zone write locking and
the gendisk attached zone bitmaps.

The "zone_wlock" mq-debugfs entry that was listing zones that are
write-locked is replaced with the zone_wplugs entry which lists
the zones that currently have a write plug allocated. The information
provided is: the zone number, the zone write plug flags, the zone write
plug write pointer offset and the number of BIOs currently waiting for
execution in the zone write plug BIO list.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq-debugfs.c    |  1 -
 block/blk-zoned.c         | 66 ++-----------------------------
 include/linux/blk-mq.h    | 83 ---------------------------------------
 include/linux/blk_types.h |  1 -
 include/linux/blkdev.h    | 35 ++---------------
 5 files changed, 7 insertions(+), 179 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ca1f2b9422d5..770c0c2b72fa 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -256,7 +256,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(HASHED),
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
-	RQF_NAME(ZONE_WRITE_LOCKED),
 	RQF_NAME(TIMED_OUT),
 	RQF_NAME(RESV),
 };
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index d540688c30f9..df67b8b22f99 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -119,52 +119,6 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
-/*
- * Return true if a request is a write requests that needs zone write locking.
- */
-bool blk_req_needs_zone_write_lock(struct request *rq)
-{
-	if (!rq->q->disk->seq_zones_wlock)
-		return false;
-
-	return blk_rq_is_seq_zoned_write(rq);
-}
-EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
-
-bool blk_req_zone_write_trylock(struct request *rq)
-{
-	unsigned int zno = blk_rq_zone_no(rq);
-
-	if (test_and_set_bit(zno, rq->q->disk->seq_zones_wlock))
-		return false;
-
-	WARN_ON_ONCE(rq->rq_flags & RQF_ZONE_WRITE_LOCKED);
-	rq->rq_flags |= RQF_ZONE_WRITE_LOCKED;
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(blk_req_zone_write_trylock);
-
-void __blk_req_zone_write_lock(struct request *rq)
-{
-	if (WARN_ON_ONCE(test_and_set_bit(blk_rq_zone_no(rq),
-					  rq->q->disk->seq_zones_wlock)))
-		return;
-
-	WARN_ON_ONCE(rq->rq_flags & RQF_ZONE_WRITE_LOCKED);
-	rq->rq_flags |= RQF_ZONE_WRITE_LOCKED;
-}
-EXPORT_SYMBOL_GPL(__blk_req_zone_write_lock);
-
-void __blk_req_zone_write_unlock(struct request *rq)
-{
-	rq->rq_flags &= ~RQF_ZONE_WRITE_LOCKED;
-	if (rq->q->disk->seq_zones_wlock)
-		WARN_ON_ONCE(!test_and_clear_bit(blk_rq_zone_no(rq),
-						 rq->q->disk->seq_zones_wlock));
-}
-EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
-
 /**
  * bdev_nr_zones - Get number of zones
  * @bdev:	Target device
@@ -1600,9 +1554,6 @@ void disk_free_zone_resources(struct gendisk *disk)
 
 	kfree(disk->conv_zones_bitmap);
 	disk->conv_zones_bitmap = NULL;
-	kfree(disk->seq_zones_wlock);
-	disk->seq_zones_wlock = NULL;
-
 	disk->zone_capacity = 0;
 	disk->nr_zones = 0;
 }
@@ -1670,7 +1621,6 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 struct blk_revalidate_zone_args {
 	struct gendisk	*disk;
 	unsigned long	*conv_zones_bitmap;
-	unsigned long	*seq_zones_wlock;
 	unsigned int	nr_zones;
 	unsigned int	zone_capacity;
 	sector_t	sector;
@@ -1746,13 +1696,6 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		set_bit(idx, args->conv_zones_bitmap);
 		break;
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
-		if (!args->seq_zones_wlock) {
-			args->seq_zones_wlock =
-				blk_alloc_zone_bitmap(q->node, args->nr_zones);
-			if (!args->seq_zones_wlock)
-				return -ENOMEM;
-		}
-
 		/*
 		 * Remember the capacity of the first sequential zone and check
 		 * if it is constant for all zones.
@@ -1794,7 +1737,7 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 }
 
 /**
- * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
+ * blk_revalidate_disk_zones - (re)allocate and initialize zone write plugs
  * @disk:	Target disk
  *
  * Helper function for low-level device drivers to check, (re) allocate and
@@ -1868,15 +1811,13 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	}
 
 	/*
-	 * Install the new bitmaps and update nr_zones only once the queue is
-	 * stopped and all I/Os are completed (i.e. a scheduler is not
-	 * referencing the bitmaps).
+	 * Set the new disk zone parameters only once the queue is frozen and
+	 * all I/Os are completed.
 	 */
 	blk_mq_freeze_queue(q);
 	if (ret > 0) {
 		disk->nr_zones = args.nr_zones;
 		disk->zone_capacity = args.zone_capacity;
-		swap(disk->seq_zones_wlock, args.seq_zones_wlock);
 		swap(disk->conv_zones_bitmap, args.conv_zones_bitmap);
 		ret = 0;
 	} else {
@@ -1885,7 +1826,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	}
 	blk_mq_unfreeze_queue(q);
 
-	kfree(args.seq_zones_wlock);
 	kfree(args.conv_zones_bitmap);
 
 	return ret;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 60090c8366fb..89ba6b16fe8b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -54,8 +54,6 @@ typedef __u32 __bitwise req_flags_t;
 /* Look at ->special_vec for the actual data payload instead of the
    bio chain. */
 #define RQF_SPECIAL_PAYLOAD	((__force req_flags_t)(1 << 18))
-/* The per-zone write lock is held for this request */
-#define RQF_ZONE_WRITE_LOCKED	((__force req_flags_t)(1 << 19))
 /* The request completion needs to be signaled to zone write pluging. */
 #define RQF_ZONE_WRITE_PLUGGING	((__force req_flags_t)(1 << 20))
 /* ->timeout has been called, don't expire again */
@@ -1152,85 +1150,4 @@ static inline int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 void blk_dump_rq_flags(struct request *, char *);
 
-#ifdef CONFIG_BLK_DEV_ZONED
-static inline unsigned int blk_rq_zone_no(struct request *rq)
-{
-	return disk_zone_no(rq->q->disk, blk_rq_pos(rq));
-}
-
-static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
-{
-	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
-}
-
-/**
- * blk_rq_is_seq_zoned_write() - Check if @rq requires write serialization.
- * @rq: Request to examine.
- *
- * Note: REQ_OP_ZONE_APPEND requests do not require serialization.
- */
-static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
-{
-	return op_needs_zoned_write_locking(req_op(rq)) &&
-		blk_rq_zone_is_seq(rq);
-}
-
-bool blk_req_needs_zone_write_lock(struct request *rq);
-bool blk_req_zone_write_trylock(struct request *rq);
-void __blk_req_zone_write_lock(struct request *rq);
-void __blk_req_zone_write_unlock(struct request *rq);
-
-static inline void blk_req_zone_write_lock(struct request *rq)
-{
-	if (blk_req_needs_zone_write_lock(rq))
-		__blk_req_zone_write_lock(rq);
-}
-
-static inline void blk_req_zone_write_unlock(struct request *rq)
-{
-	if (rq->rq_flags & RQF_ZONE_WRITE_LOCKED)
-		__blk_req_zone_write_unlock(rq);
-}
-
-static inline bool blk_req_zone_is_write_locked(struct request *rq)
-{
-	return rq->q->disk->seq_zones_wlock &&
-		test_bit(blk_rq_zone_no(rq), rq->q->disk->seq_zones_wlock);
-}
-
-static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
-{
-	if (!blk_req_needs_zone_write_lock(rq))
-		return true;
-	return !blk_req_zone_is_write_locked(rq);
-}
-#else /* CONFIG_BLK_DEV_ZONED */
-static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
-{
-	return false;
-}
-
-static inline bool blk_req_needs_zone_write_lock(struct request *rq)
-{
-	return false;
-}
-
-static inline void blk_req_zone_write_lock(struct request *rq)
-{
-}
-
-static inline void blk_req_zone_write_unlock(struct request *rq)
-{
-}
-static inline bool blk_req_zone_is_write_locked(struct request *rq)
-{
-	return false;
-}
-
-static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
-{
-	return true;
-}
-#endif /* CONFIG_BLK_DEV_ZONED */
-
 #endif /* BLK_MQ_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ffe0c112b128..5751292fee6a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -297,7 +297,6 @@ enum {
 	BIO_QOS_THROTTLED,	/* bio went through rq_qos throttle path */
 	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
-	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
 	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
 	BIO_FLAG_LAST
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8798435d22c4..d2b8d7761269 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -177,23 +177,14 @@ struct gendisk {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	/*
-	 * Zoned block device information for request dispatch control.
-	 * nr_zones is the total number of zones of the device. This is always
-	 * 0 for regular block devices. conv_zones_bitmap is a bitmap of nr_zones
-	 * bits which indicates if a zone is conventional (bit set) or
-	 * sequential (bit clear). seq_zones_wlock is a bitmap of nr_zones
-	 * bits which indicates if a zone is write locked, that is, if a write
-	 * request targeting the zone was dispatched.
-	 *
-	 * Reads of this information must be protected with blk_queue_enter() /
-	 * blk_queue_exit(). Modifying this information is only allowed while
-	 * no requests are being processed. See also blk_mq_freeze_queue() and
-	 * blk_mq_unfreeze_queue().
+	 * Zoned block device information. Reads of this information must be
+	 * protected with blk_queue_enter() / blk_queue_exit(). Modifying this
+	 * information is only allowed while no requests are being processed.
+	 * See also blk_mq_freeze_queue() and blk_mq_unfreeze_queue().
 	 */
 	unsigned int		nr_zones;
 	unsigned int		zone_capacity;
 	unsigned long		*conv_zones_bitmap;
-	unsigned long		*seq_zones_wlock;
 	unsigned int		zone_wplugs_max_nr;
 	unsigned int            zone_wplugs_hash_bits;
 	spinlock_t              zone_wplugs_lock;
@@ -636,15 +627,6 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 	return sector >> ilog2(disk->queue->limits.chunk_sectors);
 }
 
-static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
-{
-	if (!blk_queue_is_zoned(disk->queue))
-		return false;
-	if (!disk->conv_zones_bitmap)
-		return true;
-	return !test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
-}
-
 static inline void disk_set_max_open_zones(struct gendisk *disk,
 		unsigned int max_open_zones)
 {
@@ -678,10 +660,6 @@ static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
 	return 0;
 }
-static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
-{
-	return false;
-}
 static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
 	return 0;
@@ -871,11 +849,6 @@ static inline bool bio_straddles_zones(struct bio *bio)
 		disk_zone_no(bio->bi_bdev->bd_disk, bio_end_sector(bio) - 1);
 }
 
-static inline unsigned int bio_zone_is_seq(struct bio *bio)
-{
-	return disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector);
-}
-
 /*
  * Return how much of the chunk is left to be used for I/O at a given offset.
  */
-- 
2.44.0


