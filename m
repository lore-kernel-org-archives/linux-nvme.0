Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF291CCF9EE
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 06:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ceFZydNkDEyhCVQKbcj1IbYnRZdrI4q9n+Zosusnkj4=; b=mLLm7pkVLCCRpYs7Jdj5oXFHLr
	xKLb5P/xnxrmRPtBCLfzgNunmeQHXvahlhpVl4G5i71tks/ROLxovXQvuElqzKa8/OgD8C9NcYEao
	7YlAZUDoeJU9kiHJz/Zt8RI1PZdrn4BOzJqV9+sLuUTL09I3pfDqDr3VVpu5L4tmNlQ1SJ7pgm5Fh
	g2mPjEc7eY4IRXMhUJFKIEDl6YN5uPQ1iSTsA55ApGmjKEHx3X6X7DKHa0bptaA8H2+TOWGyr1Kk3
	7TTOy0dGHyvmLDO/DbPRU+iA13mi008L39QyoybzV8cdxLUTSOA1k5uOOvPneiGrlaCHwVlAdfMy8
	Oml5F3Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRw-00000005RuZ-17gu;
	Fri, 31 Oct 2025 06:17:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRj-00000005Rjr-1dwa
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 06:17:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C81844E29;
	Fri, 31 Oct 2025 06:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C61C4CEE7;
	Fri, 31 Oct 2025 06:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891431;
	bh=DD+PrcIg0n8KIsWDaBJFYDbK5o/tWYCqQv+7JEyGiQM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LUhyQ7MpwSY8s5zcyZRXUmEbpXVRM31VSjZ9WXi4HZdg6Sg2ODQwQCZ/uVaOhM/Kx
	 wFvqUkddobPR/daWljL9QpP4zDsKsMrOIYHJVm3EgfwvGuZ/TJdg2P3L1HQGdwo9Jo
	 cI3sRSrhbEpbApwqCdHoDV32biX3L+FVHo0smnZOvzwVM8/vQT56CJKGgbysR7zrcX
	 iRnKZmmLuAX8yFg56OFpLJLvGSz1JamdXXOVr888g3eGsA3g2NfntyEekdzAUuEKDy
	 pj/WECS6SlUiKDtPepEM9+zmLx5W5RnV5wFeRKp16GJJw70xNw5GAJbbF04be8nqRV
	 3E4TeJUATUeJw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 09/13] block: introduce blkdev_report_zones_cached()
Date: Fri, 31 Oct 2025 15:13:03 +0900
Message-ID: <20251031061307.185513-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_231711_512871_46B28C37 
X-CRM114-Status: GOOD (  18.61  )
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

Introduce the function blkdev_report_zones_cached() to provide a fast
report zone built using the blkdev_get_zone_info() function, which gets
zone information from a disk zones_cond array or zone write plugs.
For a large capacity SMR drive, such fast report zone can be completed
in a few millioseconds compared to several seconds completion times
when the report zone is obtained from the device.

The zone report is built in the same manner as with the regular
blkdev_report_zones() function, that is, the first zone reported is the
one containing the specified start sector and the report is limited to
the specified number of zones (nr_zones argument). The information for
each zone in the report is obtained using blkdev_get_zone_info().

For zoned device that do not use zone write plug resources,
using blkdev_get_zone_info() is inefficient as the zone report would
be very slow, generated one zone at a time. To avoid this,
blkdev_report_zones_cached() falls back to calling
blkdev_do_report_zones() to execute a regular zone report. In this case,
the .report_active field of struct blk_report_zones_args is set to true
to report zone conditions using the BLK_ZONE_COND_ACTIVE condition in
place of the implicit open, explicit open and closed conditions.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 88 +++++++++++++++++++++++++++++++++++-------
 include/linux/blkdev.h |  2 +
 2 files changed, 77 insertions(+), 13 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 03394e38645f..0234bb7f41b3 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -73,6 +73,19 @@ struct blk_zone_wplug {
 	enum blk_zone_cond	cond;
 };
 
+static inline bool disk_need_zone_resources(struct gendisk *disk)
+{
+	/*
+	 * All mq zoned devices need zone resources so that the block layer
+	 * can automatically handle write BIO plugging. BIO-based device drivers
+	 * (e.g. DM devices) are normally responsible for handling zone write
+	 * ordering and do not need zone resources, unless the driver requires
+	 * zone append emulation.
+	 */
+	return queue_is_mq(disk->queue) ||
+		queue_emulates_zone_append(disk->queue);
+}
+
 static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
 {
 	return 1U << disk->zone_wplugs_hash_bits;
@@ -962,6 +975,68 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL_GPL(blkdev_get_zone_info);
 
+/**
+ * blkdev_report_zones_cached - Get cached zones information
+ * @bdev:     Target block device
+ * @sector:   Sector from which to report zones
+ * @nr_zones: Maximum number of zones to report
+ * @cb:       Callback function called for each reported zone
+ * @data:     Private data for the callback function
+ *
+ * Description:
+ *    Similar to blkdev_report_zones() but instead of calling into the low level
+ *    device driver to get the zone report from the device, use
+ *    blkdev_get_zone_info() to generate the report from the disk zone write
+ *    plugs and zones condition array. Since calling this function without a
+ *    callback does not make sense, @cb must be specified.
+ */
+int blkdev_report_zones_cached(struct block_device *bdev, sector_t sector,
+			unsigned int nr_zones, report_zones_cb cb, void *data)
+{
+	struct gendisk *disk = bdev->bd_disk;
+	sector_t capacity = get_capacity(disk);
+	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	unsigned int idx = 0;
+	struct blk_zone zone;
+	int ret;
+
+	if (!cb || !bdev_is_zoned(bdev) ||
+	    WARN_ON_ONCE(!disk->fops->report_zones))
+		return -EOPNOTSUPP;
+
+	if (!nr_zones || sector >= capacity)
+		return 0;
+
+	/*
+	 * If we do not have any zone write plug resources, fallback to using
+	 * the regular zone report.
+	 */
+	if (!disk_need_zone_resources(disk)) {
+		struct blk_report_zones_args args = {
+			.cb = cb,
+			.data = data,
+			.report_active = true,
+		};
+
+		return blkdev_do_report_zones(bdev, sector, nr_zones, &args);
+	}
+
+	for (sector = ALIGN(sector, zone_sectors);
+	     sector < capacity && idx < nr_zones;
+	     sector += zone_sectors, idx++) {
+		ret = blkdev_get_zone_info(bdev, sector, &zone);
+		if (ret)
+			return ret;
+
+		ret = cb(&zone, idx, data);
+		if (ret)
+			return ret;
+	}
+
+	return idx;
+}
+EXPORT_SYMBOL_GPL(blkdev_report_zones_cached);
+
 static void blk_zone_reset_bio_endio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
@@ -1771,19 +1846,6 @@ void disk_free_zone_resources(struct gendisk *disk)
 	disk->nr_zones = 0;
 }
 
-static inline bool disk_need_zone_resources(struct gendisk *disk)
-{
-	/*
-	 * All mq zoned devices need zone resources so that the block layer
-	 * can automatically handle write BIO plugging. BIO-based device drivers
-	 * (e.g. DM devices) are normally responsible for handling zone write
-	 * ordering and do not need zone resources, unless the driver requires
-	 * zone append emulation.
-	 */
-	return queue_is_mq(disk->queue) ||
-		queue_emulates_zone_append(disk->queue);
-}
-
 struct blk_revalidate_zone_args {
 	struct gendisk	*disk;
 	u8		*zones_cond;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 98a0ed989d21..787eae461797 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -442,6 +442,8 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 #define BLK_ALL_ZONES  ((unsigned int)-1)
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
+int blkdev_report_zones_cached(struct block_device *bdev, sector_t sector,
+		unsigned int nr_zones, report_zones_cb cb, void *data);
 int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		sector_t sectors, sector_t nr_sectors);
 int blk_revalidate_disk_zones(struct gendisk *disk);
-- 
2.51.0


