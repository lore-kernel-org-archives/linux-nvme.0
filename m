Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABF1E77199
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 10:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D+yK9qy9NNnaFD533w4Zsv3r3RJr0YbI4KOcgKyphos=; b=LKOx4lsY5qlI4ovwAYioceNQtq
	Yl8GDhNJ7xpgtMnO0QdcNeXY1ptk6OLv6zb47tO+YaLFC47W+DZONW3QcrffC/OivaoZY6AjO1zqj
	qCmrmoAmQR3yagCKdKy45gzC9A1vWiFWIEW5bqpREe/BwTW3d7sDih8dCQ4stHclMvV8RQ0zczDL9
	49+rFHFKdFij7/yYePSpqlwjurjWBYV9g/af5qFidCjKmWQMJyvVQ/W9pKtPWuuNU73O8KkWyEGF7
	l3PmkYTnntWt0PaDo8JC0imIOCyIoqTtlGi+kKDY1bGdxlGus+k+QOCSB+6VpyckoNMsOY7zURiYs
	GryiTlAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUk0l-00000000nXx-37BL;
	Mon, 06 Jan 2025 10:07:03 +0000
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUk0j-00000000nTW-2Q0m;
	Mon, 06 Jan 2025 10:07:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nbd@other.debian.org,
	virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH 05/10] block: don't update BLK_FEAT_POLL in __blk_mq_update_nr_hw_queues
Date: Mon,  6 Jan 2025 11:06:18 +0100
Message-ID: <20250106100645.850445-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250106100645.850445-1-hch@lst.de>
References: <20250106100645.850445-1-hch@lst.de>
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

When __blk_mq_update_nr_hw_queues changes the number of tag sets, it
might have to disable poll queues.  Currently it does so by adjusting
the BLK_FEAT_POLL, which is a bit against the intent of features that
describe hardware / driver capabilities, but more importantly causes
nasty lock order problems with the broadly held freeze when updating the
number of hardware queues and the limits lock.  Fix this by leaving
BLK_FEAT_POLL alone, and instead check for the number of sets and poll
queues in the bio submission and poll handler.  While this adds extra
work to the fast path, the variables are in cache lines used by these
operations anyway, so it should be cheap enough.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 14 +++++++++++---
 block/blk-mq.c   | 19 +------------------
 block/blk-mq.h   |  6 ++++++
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 666efe8fa202..483c14a50d9f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -753,6 +753,15 @@ static blk_status_t blk_validate_atomic_write_op_size(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
+static bool bdev_can_poll(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (queue_is_mq(q))
+		return blk_mq_can_poll(q->tag_set);
+	return q->limits.features & BLK_FEAT_POLL;
+}
+
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -805,8 +814,7 @@ void submit_bio_noacct(struct bio *bio)
 		}
 	}
 
-	if (!(q->limits.features & BLK_FEAT_POLL) &&
-			(bio->bi_opf & REQ_POLLED)) {
+	if ((bio->bi_opf & REQ_POLLED) && !bdev_can_poll(bdev)) {
 		bio_clear_polled(bio);
 		goto not_supported;
 	}
@@ -935,7 +943,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 		return 0;
 
 	q = bdev_get_queue(bdev);
-	if (cookie == BLK_QC_T_NONE || !(q->limits.features & BLK_FEAT_POLL))
+	if (cookie == BLK_QC_T_NONE || !bdev_can_poll(bdev))
 		return 0;
 
 	blk_flush_plug(current->plug, false);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 17f10683d640..0a7f059735fa 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4321,12 +4321,6 @@ void blk_mq_release(struct request_queue *q)
 	blk_mq_sysfs_deinit(q);
 }
 
-static bool blk_mq_can_poll(struct blk_mq_tag_set *set)
-{
-	return set->nr_maps > HCTX_TYPE_POLL &&
-		set->map[HCTX_TYPE_POLL].nr_queues;
-}
-
 struct request_queue *blk_mq_alloc_queue(struct blk_mq_tag_set *set,
 		struct queue_limits *lim, void *queuedata)
 {
@@ -4336,9 +4330,7 @@ struct request_queue *blk_mq_alloc_queue(struct blk_mq_tag_set *set,
 
 	if (!lim)
 		lim = &default_lim;
-	lim->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT;
-	if (blk_mq_can_poll(set))
-		lim->features |= BLK_FEAT_POLL;
+	lim->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
 
 	q = blk_alloc_queue(lim, set->numa_node);
 	if (IS_ERR(q))
@@ -5025,8 +5017,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		struct queue_limits lim;
-
 		blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
@@ -5040,13 +5030,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 			set->nr_hw_queues = prev_nr_hw_queues;
 			goto fallback;
 		}
-		lim = queue_limits_start_update(q);
-		if (blk_mq_can_poll(set))
-			lim.features |= BLK_FEAT_POLL;
-		else
-			lim.features &= ~BLK_FEAT_POLL;
-		if (queue_limits_commit_update(q, &lim) < 0)
-			pr_warn("updating the poll flag failed\n");
 		blk_mq_map_swqueue(q);
 	}
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 89a20fffa4b1..ecd7bd7ec609 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -111,6 +111,12 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 	return ctx->hctxs[blk_mq_get_hctx_type(opf)];
 }
 
+static inline bool blk_mq_can_poll(struct blk_mq_tag_set *set)
+{
+	return set->nr_maps > HCTX_TYPE_POLL &&
+		set->map[HCTX_TYPE_POLL].nr_queues;
+}
+
 /*
  * sysfs helpers
  */
-- 
2.45.2


