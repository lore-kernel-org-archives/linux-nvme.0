Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B82CC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4VSfcLnPjPfU7j//JLAYFJ37MiZvdmoWhgvI49ISqsc=; b=MccZSh17R0zyLfgESrHTj7ftGS
	VsWOj+RbVSG9gtBEpqwbJxOvdVN4OiN4F4h5bL62JFz2r0iZEVktkQeVuz2yUyBmrOAwTiLMDhVzi
	TwYgolGOHhXKaGEqlFq2hZNS4Lp2PcJ3vlOn+8abdcc1zcZ883TzVFh6E3tc5R96LmB2TLklkLwHI
	Ta/xLAZwguFQhh+XbV5JrVsLVoBE93YdeQUgmbSFNLeuJru3kHy+xFaDxkKdFDm8LjnbA4N5pgiOp
	XxuKl8Clgw+eM+s+eeVyzp4N0csp7QaQuIAyYket9ESwP64a7unWrJ225XiTelTBltsh9n9p5FVP4
	KNry3xJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z79-006wrc-GP; Wed, 06 Jul 2022 07:06:23 +0000
Received: from [2001:4bb8:189:3c4a:f22c:c36a:4e84:c723] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z5M-006vJc-JN; Wed, 06 Jul 2022 07:04:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 15/16] block: remove blk_queue_zone_sectors
Date: Wed,  6 Jul 2022 09:03:49 +0200
Message-Id: <20220706070350.1703384-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706070350.1703384-1-hch@lst.de>
References: <20220706070350.1703384-1-hch@lst.de>
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

Always use bdev_zone_sectors instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-table.c  |  4 +---
 drivers/md/dm-zone.c   | 10 ++++++----
 include/linux/blkdev.h | 11 +++--------
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index b36b528e56cff..df904b7e95ce3 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1620,13 +1620,11 @@ static bool dm_table_supports_zoned_model(struct dm_table *t,
 static int device_not_matches_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
 					   sector_t start, sector_t len, void *data)
 {
-	struct request_queue *q = bdev_get_queue(dev->bdev);
 	unsigned int *zone_sectors = data;
 
 	if (!bdev_is_zoned(dev->bdev))
 		return 0;
-
-	return blk_queue_zone_sectors(q) != *zone_sectors;
+	return bdev_zone_sectors(dev->bdev) != *zone_sectors;
 }
 
 /*
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 6d105abe12415..842c31019b513 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -334,7 +334,7 @@ static int dm_update_zone_wp_offset_cb(struct blk_zone *zone, unsigned int idx,
 static int dm_update_zone_wp_offset(struct mapped_device *md, unsigned int zno,
 				    unsigned int *wp_ofst)
 {
-	sector_t sector = zno * blk_queue_zone_sectors(md->queue);
+	sector_t sector = zno * bdev_zone_sectors(md->disk->part0);
 	unsigned int noio_flag;
 	struct dm_table *t;
 	int srcu_idx, ret;
@@ -373,7 +373,7 @@ struct orig_bio_details {
 static bool dm_zone_map_bio_begin(struct mapped_device *md,
 				  unsigned int zno, struct bio *clone)
 {
-	sector_t zsectors = blk_queue_zone_sectors(md->queue);
+	sector_t zsectors = bdev_zone_sectors(md->disk->part0);
 	unsigned int zwp_offset = READ_ONCE(md->zwp_offset[zno]);
 
 	/*
@@ -443,7 +443,7 @@ static blk_status_t dm_zone_map_bio_end(struct mapped_device *md, unsigned int z
 		return BLK_STS_OK;
 	case REQ_OP_ZONE_FINISH:
 		WRITE_ONCE(md->zwp_offset[zno],
-			   blk_queue_zone_sectors(md->queue));
+			   bdev_zone_sectors(md->disk->part0));
 		return BLK_STS_OK;
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE:
@@ -593,6 +593,7 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
 {
 	struct mapped_device *md = io->md;
 	struct request_queue *q = md->queue;
+	struct gendisk *disk = md->disk;
 	struct bio *orig_bio = io->orig_bio;
 	unsigned int zwp_offset;
 	unsigned int zno;
@@ -608,7 +609,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
 		 */
 		if (clone->bi_status == BLK_STS_OK &&
 		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
-			sector_t mask = (sector_t)blk_queue_zone_sectors(q) - 1;
+			sector_t mask =
+				(sector_t)bdev_zone_sectors(disk->part0) - 1;
 
 			orig_bio->bi_iter.bi_sector +=
 				clone->bi_iter.bi_sector & mask;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fa2757ef4a846..21b97f7115dcb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -667,11 +667,6 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 	}
 }
 
-static inline sector_t blk_queue_zone_sectors(struct request_queue *q)
-{
-	return blk_queue_is_zoned(q) ? q->limits.chunk_sectors : 0;
-}
-
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 {
@@ -1310,9 +1305,9 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	if (q)
-		return blk_queue_zone_sectors(q);
-	return 0;
+	if (!blk_queue_is_zoned(q))
+		return 0;
+	return q->limits.chunk_sectors;
 }
 
 static inline int queue_dma_alignment(const struct request_queue *q)
-- 
2.30.2


