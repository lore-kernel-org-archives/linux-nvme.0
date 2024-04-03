Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EC1CD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 08:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Q7AhrIV65vwRaN5TgkdPzZmmxocoJaKDikFNR3Z3g8=; b=y9RdPFr5h9P7rrNbCSnK3GZMm0
	RiTpUumA3412HKO4Rh2Q7hLhPTO8ewxGJeolOnRWXE5FCGR7cIPpisCLoKrqdfP3NhjeucdbIw0Vg
	9XRzn3cxcu7svJFMeHn8YZDvPcqbW93gk9h+k4rr2nfO39xUM/5FggLcOytAo13h1kfZCgibOFswa
	nUd/hY8Sy00WcDkuYIFbpEw15zpWndhps0RKSVvn8h+br+pLRADZ/Ka4saU7jDywLzMA0/s+tVgkA
	qDYX/3+PGUcynaxqQVx2R5ep1JCOhCX490eMIPguMKry4Ag5utcHpG9O/p6hyJV9BePOwpGXu1UAQ
	gHk0ajfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwEg-0000000EzsW-2KCT;
	Wed, 03 Apr 2024 08:44:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDh-0000000EzFl-00vf
	for linux-nvme@bombadil.infradead.org;
	Wed, 03 Apr 2024 08:43:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=9Q7AhrIV65vwRaN5TgkdPzZmmxocoJaKDikFNR3Z3g8=; b=f7shdS+Dc1pyLl7xtq3SIYBWbj
	jZ7p5DN0G8e3gZTXpJ8kz0PWS22me3nFsfw3TAD1QK9NDFNxKHNtUAc7PWet8hjcuJ0Q7I+ecr2Km
	H/sDVeWQcIwHoy8YMxM/MFwGA2rtkeWczETJjuOJB6Sf07fA2dTi1z1d48GUvZIax+/OeT8tigxao
	+oximiaX6yqSjvWywnQeFe0vl04a+AXSgBY/Cqoj+OnQsTN/wSCQD++JubGbJpNdqzazxeKqCMaZF
	Kqase6mdgs6kCIEE/qcJTPfx3LrGhL8WHnm1vbjbr6BoOHJICGwMJAsXPapOmPGO04NkQgIA0itm/
	OlSFNhXw==;
Received: from sin.source.kernel.org ([145.40.73.55])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDb-000000046Ta-1Bxl
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 08:43:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 51A12CE20A1;
	Wed,  3 Apr 2024 08:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A34EC43399;
	Wed,  3 Apr 2024 08:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133814;
	bh=hPHMUb1vA3c7mNoljCMpztbl/aa0WSEspPgXFo8VucY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dxMfY1EzYuqnHgAcrJpZ2naC+zRPiEjXr/+sY3UC2MVWR6RmHsbA2GUaXqEojfsL7
	 i2c2HE7W1egULkI4uqtZNhJ8A/U/IgDYNH/Qday+4jEaMjFTCa+U0Gb4CfXYElK9ed
	 zQXRlokC8ltnf60kQG+eaYDYfPN56hFor+N5h8tmgeJThGUwLuyinnSWZYTuQo+CLa
	 xjO8+lElDjhIOxS/AEVZTdlsehxiEjn9tihR4Rsb/9UAKByFVMfBc2cuU7TftRtPqm
	 cEV9BujjeEy+6KWH1eHOoiT0naUMrC5oWbP9rQqRt5Z9+9qj0wY6avuNdP3D/cig6w
	 XQ2PLnI+eX3Mw==
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
Subject: [PATCH v5 28/28] block: Do not special-case plugging of zone write operations
Date: Wed,  3 Apr 2024 17:42:47 +0900
Message-ID: <20240403084247.856481-29-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_094342_160956_C0BF2E52 
X-CRM114-Status: GOOD (  24.76  )
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

With the block layer zone write plugging being automatically done for
any write operation to a zone of a zoned block device, a regular request
plugging handled through current->plug can only ever see at most a
single write request per zone. In such case, any potential reordering
of the plugged requests will be harmless. We can thus remove the special
casing for write operations to zones and have these requests plugged as
well. This allows removing the function blk_mq_plug and instead directly
using current->plug where needed.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c       |  6 ------
 block/blk-merge.c      |  3 +--
 block/blk-mq.c         |  7 +------
 block/blk-mq.h         | 31 -------------------------------
 include/linux/blkdev.h | 12 ------------
 5 files changed, 2 insertions(+), 57 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e1a5344c2257..47400a4fe851 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -907,12 +907,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
-	/*
-	 * As the requests that require a zone lock are not plugged in the
-	 * first place, directly accessing the plug instead of using
-	 * blk_mq_plug() should not have any consequences during flushing for
-	 * zoned devices.
-	 */
 	blk_flush_plug(current->plug, false);
 
 	/*
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7a9f8187ea62..3228868283a4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1112,10 +1112,9 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
-	struct blk_plug *plug;
+	struct blk_plug *plug = current->plug;
 	struct request *rq;
 
-	plug = blk_mq_plug(bio);
 	if (!plug || rq_list_empty(plug->mq_list))
 		return false;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e1e13d755033..045b195faad4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1330,11 +1330,6 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 
 	blk_account_io_start(rq);
 
-	/*
-	 * As plugging can be enabled for passthrough requests on a zoned
-	 * device, directly accessing the plug instead of using blk_mq_plug()
-	 * should not have any consequences.
-	 */
 	if (current->plug && !at_head) {
 		blk_add_rq_to_plug(current->plug, rq);
 		return;
@@ -2932,7 +2927,7 @@ static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
 void blk_mq_submit_bio(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-	struct blk_plug *plug = blk_mq_plug(bio);
+	struct blk_plug *plug = current->plug;
 	const int is_sync = op_is_sync(bio->bi_opf);
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int nr_segs = 1;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f75a9ecfebde..260beea8e332 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -365,37 +365,6 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 		qmap->mq_map[cpu] = 0;
 }
 
-/*
- * blk_mq_plug() - Get caller context plug
- * @bio : the bio being submitted by the caller context
- *
- * Plugging, by design, may delay the insertion of BIOs into the elevator in
- * order to increase BIO merging opportunities. This however can cause BIO
- * insertion order to change from the order in which submit_bio() is being
- * executed in the case of multiple contexts concurrently issuing BIOs to a
- * device, even if these context are synchronized to tightly control BIO issuing
- * order. While this is not a problem with regular block devices, this ordering
- * change can cause write BIO failures with zoned block devices as these
- * require sequential write patterns to zones. Prevent this from happening by
- * ignoring the plug state of a BIO issuing context if it is for a zoned block
- * device and the BIO to plug is a write operation.
- *
- * Return current->plug if the bio can be plugged and NULL otherwise
- */
-static inline struct blk_plug *blk_mq_plug( struct bio *bio)
-{
-	/* Zoned block device write operation case: do not plug the BIO */
-	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
-		return NULL;
-
-	/*
-	 * For regular block devices or read operations, use the context plug
-	 * which may be NULL if blk_start_plug() was not executed.
-	 */
-	return current->plug;
-}
-
 /* Free all requests on the list */
 static inline void blk_mq_free_requests(struct list_head *list)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d8cc24a1635b..5b86af75a29f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1300,18 +1300,6 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
 	return disk_zone_no(bdev->bd_disk, sec);
 }
 
-/* Whether write serialization is required for @op on zoned devices. */
-static inline bool op_needs_zoned_write_locking(enum req_op op)
-{
-	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
-}
-
-static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
-					  enum req_op op)
-{
-	return bdev_is_zoned(bdev) && op_needs_zoned_write_locking(op);
-}
-
 static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.44.0


