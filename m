Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D197CD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 02:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p4OoIr8vJbCJkeJSQKVGJkwXkegrrBQky25LIu8eBtg=; b=zlk66L0tsMB+ul+QWd59ZHDEGf
	AlCXDEAflBrQPsE86/2nzME8Pd4SzNklbfcf5OFMXTpHnadGMRkGN+wQYypBVq5tdBP1escvxVQxB
	Pu56Y970isAI6T9898rSH0tq/bS4miNMV4rw0X70ioZ7ZWG4vz3pgxnTegDt8XNxnRLaWINs0f8hC
	4lGWzGaH+aXB3+X8uBzlhH35Zlhspp9ZviDqZValdOkZd7A3pfqsofh+ASvAyXHERJf7KLeXG69+e
	Pgo9OZQAVzUwjRP/C+13IajbR0XWPkCYUnMTxKU55sdnHSJulwNcRDhT8DFcaHBz563CL5SGkcSuz
	AADBR25w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtf1Q-0000000E5m0-0sU1;
	Mon, 08 Apr 2024 02:46:12 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1f-0000000Dvrz-2fST
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:42:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B4563CE0BA6;
	Mon,  8 Apr 2024 01:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2980EC433C7;
	Mon,  8 Apr 2024 01:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540541;
	bh=3y3AIFCWmQJZyRx6bAOAqRiitZ1cZsMk131FC6ehd+I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oSa0fvIJU7SejvJ21APGAhpfanQu8md6P8LezG+f6qTBoLttBc9G3VJnNrA7F9y8z
	 REJ8GCQD0tCuh9DJx2KJe4DN0eOXRTirA7YQ7jC6UsKpb6xhr1RDXaDIbdVnYs36RG
	 y2KV1MZhrNjUBvoDn4JQizPDCNLOVe3laAVj99T0URbibALHLNA1j8N0oRSsdAUHQ2
	 qZ69oy3NLUdwdJUpdmo+V/+RkCdV/ODvfc24o1R4ypJdvgU8VEtcibNjddcK6YE20s
	 hZxQbhJ7pQxtgjGjIwyp0txHAgo3oFn8WP+fpOwZK/4Dyg540XQafThZlFij58IK6I
	 Tx22gCLS8o+4w==
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
Subject: [PATCH v7 28/28] block: Do not special-case plugging of zone write operations
Date: Mon,  8 Apr 2024 10:41:28 +0900
Message-ID: <20240408014128.205141-29-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184224_544754_0043009B 
X-CRM114-Status: GOOD (  24.77  )
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
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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
index 7f8a808b74c1..f64115d72f3d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1113,10 +1113,9 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
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
index 9f2d9970eeba..434d45219e23 100644
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
index 5a6e05df2554..c62536c78a46 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1299,18 +1299,6 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
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


