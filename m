Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFBCCD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JeX4M5kAUMpKpDNvZWticW/zAKeCbj3e0QyLXVV19rg=; b=2HuOFBI6ELKIet2kSFulDmcGlG
	HofJ2FEZ7ullZEyqGD4QcbKkdOAeCOnWolHL327M8ncNTFj2ZSQKORil9Mn/VlVwAdciUfVgVuIWB
	62CrJf8ua6xoDQTqCAUbHIEqmEw52PSnNC38HNYWjWNglXHRUSeyRAR0bbqtBqAMMzLidYuXau8bV
	ULEAZrPJoONSnSabE3v7mirhJhQXe2ktPVyPqHo9X10mKmbZDxTwUoNbHNwVNpxv6jyMCh6rc8BH3
	n96VSbZkFAogO1iCBZFqdUjIRgKMonSexb37zUuLCvED++hej7iCOdX5L8JXmk0ILZQIzcAwVV+QS
	D4nte1Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rreVT-0000000BQaI-2DhH;
	Tue, 02 Apr 2024 13:48:55 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQU-0000000B6Kl-0iPc
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:39:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7E4D5CE1B73;
	Tue,  2 Apr 2024 12:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC37C433F1;
	Tue,  2 Apr 2024 12:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061581;
	bh=q9wDtCDSuKBBkvh7ngGyYa08b0p3FXiAGbfJb7g+BI0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JxUQR4WntEu5OqPzPvv8SHZTvpMsnofXIereFhcZsR68al45bPuND5ozb3OGq2VHS
	 SFfZjGkJEPXMASZESz+ebstyI/tvS8H0z0SrUOJ8DTZ+51UQff7cjPsFlMDmjMWDOd
	 lWoI8ZnLp/YTS5f3ccXRLKcUSNdbpJJKqjN7Fntv4trmc0JaEJpKdyGi6GK3SHFGAq
	 GLuls5e1+/rMlU0ZTTs5W63A4W8kSo3fhUVj6oPtDFBt0HbnjZq3w/H7MbA0q9KI0o
	 UPDOv4OMv6aTREtnycQ4RRcDv2+NwtukG5neCvKZ+5MTeYmJyxaS76hT48Oyo2iMHS
	 BQwLKsiH6Dxpw==
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
Subject: [PATCH v4 22/28] block: Remove elevator required features
Date: Tue,  2 Apr 2024 21:39:01 +0900
Message-ID: <20240402123907.512027-23-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_053943_024029_6073ECCF 
X-CRM114-Status: GOOD (  20.43  )
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

The only elevator feature ever implemented is ELEVATOR_F_ZBD_SEQ_WRITE
for signaling that a scheduler implements zone write locking to tightly
control the dispatching order of write operations to zoned block
devices. With the removal of zone write locking support in mq-deadline
and the reliance of all block device drivers on the block layer zone
write plugging to control ordering of write operations to zones, the
elevator feature ELEVATOR_F_ZBD_SEQ_WRITE is completely unused.
Remove it, and also remove the now unused code for filtering the
possible schedulers for a block device based on required features.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c   | 16 ---------------
 block/elevator.c       | 46 +++++-------------------------------------
 block/elevator.h       |  1 -
 include/linux/blkdev.h | 10 ---------
 4 files changed, 5 insertions(+), 68 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c0197e1e7485..715f4b6356c4 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -1052,22 +1052,6 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 }
 EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 
-/**
- * blk_queue_required_elevator_features - Set a queue required elevator features
- * @q:		the request queue for the target device
- * @features:	Required elevator features OR'ed together
- *
- * Tell the block layer that for the device controlled through @q, only the
- * only elevators that can be used are those that implement at least the set of
- * features specified by @features.
- */
-void blk_queue_required_elevator_features(struct request_queue *q,
-					  unsigned int features)
-{
-	q->required_elevator_features = features;
-}
-EXPORT_SYMBOL_GPL(blk_queue_required_elevator_features);
-
 /**
  * blk_queue_can_use_dma_map_merging - configure queue for merging segments.
  * @q:		the request queue for the device
diff --git a/block/elevator.c b/block/elevator.c
index 5ff093cb3cf8..f64ebd726e58 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -83,13 +83,6 @@ bool elv_bio_merge_ok(struct request *rq, struct bio *bio)
 }
 EXPORT_SYMBOL(elv_bio_merge_ok);
 
-static inline bool elv_support_features(struct request_queue *q,
-		const struct elevator_type *e)
-{
-	return (q->required_elevator_features & e->elevator_features) ==
-		q->required_elevator_features;
-}
-
 /**
  * elevator_match - Check whether @e's name or alias matches @name
  * @e: Scheduler to test
@@ -120,7 +113,7 @@ static struct elevator_type *elevator_find_get(struct request_queue *q,
 
 	spin_lock(&elv_list_lock);
 	e = __elevator_find(name);
-	if (e && (!elv_support_features(q, e) || !elevator_tryget(e)))
+	if (e && (!elevator_tryget(e)))
 		e = NULL;
 	spin_unlock(&elv_list_lock);
 	return e;
@@ -580,34 +573,8 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
 }
 
 /*
- * Get the first elevator providing the features required by the request queue.
- * Default to "none" if no matching elevator is found.
- */
-static struct elevator_type *elevator_get_by_features(struct request_queue *q)
-{
-	struct elevator_type *e, *found = NULL;
-
-	spin_lock(&elv_list_lock);
-
-	list_for_each_entry(e, &elv_list, list) {
-		if (elv_support_features(q, e)) {
-			found = e;
-			break;
-		}
-	}
-
-	if (found && !elevator_tryget(found))
-		found = NULL;
-
-	spin_unlock(&elv_list_lock);
-	return found;
-}
-
-/*
- * For a device queue that has no required features, use the default elevator
- * settings. Otherwise, use the first elevator available matching the required
- * features. If no suitable elevator is find or if the chosen elevator
- * initialization fails, fall back to the "none" elevator (no elevator).
+ * Use the default elevator settings. If the chosen elevator initialization
+ * fails, fall back to the "none" elevator (no elevator).
  */
 void elevator_init_mq(struct request_queue *q)
 {
@@ -622,10 +589,7 @@ void elevator_init_mq(struct request_queue *q)
 	if (unlikely(q->elevator))
 		return;
 
-	if (!q->required_elevator_features)
-		e = elevator_get_default(q);
-	else
-		e = elevator_get_by_features(q);
+	e = elevator_get_default(q);
 	if (!e)
 		return;
 
@@ -781,7 +745,7 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 	list_for_each_entry(e, &elv_list, list) {
 		if (e == cur)
 			len += sprintf(name+len, "[%s] ", e->elevator_name);
-		else if (elv_support_features(q, e))
+		else
 			len += sprintf(name+len, "%s ", e->elevator_name);
 	}
 	spin_unlock(&elv_list_lock);
diff --git a/block/elevator.h b/block/elevator.h
index 7ca3d7b6ed82..e9a050a96e53 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -74,7 +74,6 @@ struct elevator_type
 	struct elv_fs_entry *elevator_attrs;
 	const char *elevator_name;
 	const char *elevator_alias;
-	const unsigned int elevator_features;
 	struct module *elevator_owner;
 #ifdef CONFIG_BLK_DEBUG_FS
 	const struct blk_mq_debugfs_attr *queue_debugfs_attrs;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 186ba63ecc16..045579474ed4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -454,8 +454,6 @@ struct request_queue {
 
 	atomic_t		nr_active_requests_shared_tags;
 
-	unsigned int		required_elevator_features;
-
 	struct blk_mq_tags	*sched_shared_tags;
 
 	struct list_head	icq_list;
@@ -960,14 +958,6 @@ disk_alloc_independent_access_ranges(struct gendisk *disk, int nr_ia_ranges);
 void disk_set_independent_access_ranges(struct gendisk *disk,
 				struct blk_independent_access_ranges *iars);
 
-/*
- * Elevator features for blk_queue_required_elevator_features:
- */
-/* Supports zoned block devices sequential write constraint */
-#define ELEVATOR_F_ZBD_SEQ_WRITE	(1U << 0)
-
-extern void blk_queue_required_elevator_features(struct request_queue *q,
-						 unsigned int features);
 extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
 					      struct device *dev);
 
-- 
2.44.0


