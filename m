Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC37C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 05:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LA03+v2RMrt5LLwAfTBpcNFXpYhSXKyM/LEXrkZN1Tc=; b=ZQ2NQzkWXkqE7q9rdmuMgl8pZj
	SCObAr0D38cnVPFQubL7t0Is1BsiGqk36PVH1B2ZeKyyFfT0h/EP9RoghfplcBf096V6WyAX3KNf/
	Gj+n7JgvQ5+lxjrMBzW851B6GxQpykXi69p5+3AEd/bPi/XtRf2+7hc/wTmbFnxIHLngMyVV+2hFq
	I1jWKciwRX4BejZtpibwTc3Q5rzsuf3Y7bcK5k4aX8eG3X98fO8mUIRZm5ksM/h2W2N4suoMr5Wls
	dm9/BYzqvcddzbpUN71e5pqHNXkmRWz7XoyWtZGoBXbuWxa6h9nxUXt1AeYXiCXlyvsF2qKFeJcFl
	xY97vSoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfE42-008Uug-N3; Fri, 15 Apr 2022 05:00:10 +0000
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfDy3-008PQw-Ke; Fri, 15 Apr 2022 04:54:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 18/27] block: move bdev_alignment_offset and
 queue_limit_alignment_offset out of line
Date: Fri, 15 Apr 2022 06:52:49 +0200
Message-Id: <20220415045258.199825-19-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415045258.199825-1-hch@lst.de>
References: <20220415045258.199825-1-hch@lst.de>
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

No need to inline these fairly larger helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-settings.c   | 23 +++++++++++++++++++++++
 include/linux/blkdev.h | 21 +--------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index b83df3d2eebca..94410a13c0dee 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -468,6 +468,16 @@ void blk_queue_io_opt(struct request_queue *q, unsigned int opt)
 }
 EXPORT_SYMBOL(blk_queue_io_opt);
 
+static int queue_limit_alignment_offset(struct queue_limits *lim,
+		sector_t sector)
+{
+	unsigned int granularity = max(lim->physical_block_size, lim->io_min);
+	unsigned int alignment = sector_div(sector, granularity >> SECTOR_SHIFT)
+		<< SECTOR_SHIFT;
+
+	return (granularity + lim->alignment_offset - alignment) % granularity;
+}
+
 static unsigned int blk_round_down_sectors(unsigned int sectors, unsigned int lbs)
 {
 	sectors = round_down(sectors, lbs >> SECTOR_SHIFT);
@@ -901,3 +911,16 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 	}
 }
 EXPORT_SYMBOL_GPL(blk_queue_set_zoned);
+
+int bdev_alignment_offset(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (q->limits.misaligned)
+		return -1;
+	if (bdev_is_partition(bdev))
+		return queue_limit_alignment_offset(&q->limits,
+				bdev->bd_start_sect);
+	return q->limits.alignment_offset;
+}
+EXPORT_SYMBOL_GPL(bdev_alignment_offset);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d5346e72e3645..0a1795ac26275 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1251,26 +1251,7 @@ bdev_zone_write_granularity(struct block_device *bdev)
 	return queue_zone_write_granularity(bdev_get_queue(bdev));
 }
 
-static inline int queue_limit_alignment_offset(struct queue_limits *lim, sector_t sector)
-{
-	unsigned int granularity = max(lim->physical_block_size, lim->io_min);
-	unsigned int alignment = sector_div(sector, granularity >> SECTOR_SHIFT)
-		<< SECTOR_SHIFT;
-
-	return (granularity + lim->alignment_offset - alignment) % granularity;
-}
-
-static inline int bdev_alignment_offset(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q->limits.misaligned)
-		return -1;
-	if (bdev_is_partition(bdev))
-		return queue_limit_alignment_offset(&q->limits,
-				bdev->bd_start_sect);
-	return q->limits.alignment_offset;
-}
+int bdev_alignment_offset(struct block_device *bdev);
 
 static inline int queue_discard_alignment(const struct request_queue *q)
 {
-- 
2.30.2


