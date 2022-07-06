Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DC2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 07:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lbcR7xScrQBbM/M7Onk92pBquOkxA9lxlNUV20FvRgo=; b=K9ePFGLtnTWsi2pudO7oTMhcwg
	9IWzFA29LJzLK0w2xKq2Ty3sFFj7xRId/cBBNXzkTmeJ1fCFCeNcVr3UMedcHsGX4vMSquqzHXuIb
	jQt2hovXtq3iBtW39EctwqHl349AxxBfGE8qnbbGuVsQ5BHDSWIzdtKBM2upzzlrHKmqU0kjD6qaH
	69HgW3Mf9g8NKVCKKHA/M6RYHYqAwg3Epk6NFblSgdboTeys+2v8ZkvFAY+oo2SHD2FDHhibu6wAn
	q89q6pbGvbh6xTfIuNJOl63uaIY4V9w072pgZOEu3ntGJO5N4jVfNcBPjpNgKH77jzpS7PbomRTuF
	4JYqrvvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z6u-006wgf-Hu; Wed, 06 Jul 2022 07:06:08 +0000
Received: from [2001:4bb8:189:3c4a:f22c:c36a:4e84:c723] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z5J-006vGt-S3; Wed, 06 Jul 2022 07:04:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 14/16] dm-zoned: cleanup dmz_fixup_devices
Date: Wed,  6 Jul 2022 09:03:48 +0200
Message-Id: <20220706070350.1703384-15-hch@lst.de>
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

Use the bdev based helpers where applicable and move the zoned_dev
into the scope where it is actually used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-zoned-target.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 6ba6ef44b00e2..95b132b52f332 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -764,8 +764,7 @@ static void dmz_put_zoned_device(struct dm_target *ti)
 static int dmz_fixup_devices(struct dm_target *ti)
 {
 	struct dmz_target *dmz = ti->private;
-	struct dmz_dev *reg_dev, *zoned_dev;
-	struct request_queue *q;
+	struct dmz_dev *reg_dev = NULL;
 	sector_t zone_nr_sectors = 0;
 	int i;
 
@@ -780,31 +779,32 @@ static int dmz_fixup_devices(struct dm_target *ti)
 			return -EINVAL;
 		}
 		for (i = 1; i < dmz->nr_ddevs; i++) {
-			zoned_dev = &dmz->dev[i];
+			struct dmz_dev *zoned_dev = &dmz->dev[i];
+			struct block_device *bdev = zoned_dev->bdev;
+
 			if (zoned_dev->flags & DMZ_BDEV_REGULAR) {
 				ti->error = "Secondary disk is not a zoned device";
 				return -EINVAL;
 			}
-			q = bdev_get_queue(zoned_dev->bdev);
 			if (zone_nr_sectors &&
-			    zone_nr_sectors != blk_queue_zone_sectors(q)) {
+			    zone_nr_sectors != bdev_zone_sectors(bdev)) {
 				ti->error = "Zone nr sectors mismatch";
 				return -EINVAL;
 			}
-			zone_nr_sectors = blk_queue_zone_sectors(q);
+			zone_nr_sectors = bdev_zone_sectors(bdev);
 			zoned_dev->zone_nr_sectors = zone_nr_sectors;
-			zoned_dev->nr_zones = bdev_nr_zones(zoned_dev->bdev);
+			zoned_dev->nr_zones = bdev_nr_zones(bdev);
 		}
 	} else {
-		reg_dev = NULL;
-		zoned_dev = &dmz->dev[0];
+		struct dmz_dev *zoned_dev = &dmz->dev[0];
+		struct block_device *bdev = zoned_dev->bdev;
+
 		if (zoned_dev->flags & DMZ_BDEV_REGULAR) {
 			ti->error = "Disk is not a zoned device";
 			return -EINVAL;
 		}
-		q = bdev_get_queue(zoned_dev->bdev);
-		zoned_dev->zone_nr_sectors = blk_queue_zone_sectors(q);
-		zoned_dev->nr_zones = bdev_nr_zones(zoned_dev->bdev);
+		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
+		zoned_dev->nr_zones = bdev_nr_zones(bdev);
 	}
 
 	if (reg_dev) {
-- 
2.30.2


