Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE388EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 06:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C7uWSY9rr3HNLhEbd15CCRBJxyeae+JoHxikSrCcpv4=; b=xxwHMlVRVi+n1ymLdxEmwbln8H
	VEy11X+JNbcpumHaLrZvMTAwhXLuxPijOZBSh+RcFRRyjv2+Y/6z2VU8CC9kuapw/YYxIF5L2uP/2
	fIEpo/Aq0PimCKpFMmzYbcZutL6AxO6PNiQEScTGZYBJd31SqfY3OzUFLK4csM6XMqG5GHowY+0F6
	IpTjhllybUEsCxhcr77HdAQI/0TFHI2jdurbGYSM0SQjDPvDbJEARRdda/L4qr0UITnEVmUN1+LcE
	1ZLOMVmoa+Agom4YgTuc8lBgCPMoZsDuKBRiEc2EanSqov1T6j5sqUwBrGZnuX2u8OtLZJ/kc5pOB
	6T47zxYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6g-0005yQ-02;
	Thu, 29 Jun 2023 06:26:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6Y-0005ug-3D
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 06:26:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8AEF1614CB;
	Thu, 29 Jun 2023 06:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FF3C433CA;
	Thu, 29 Jun 2023 06:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688019970;
	bh=x1DTWx8pERy08ntVPKA0QbOmKcrPMXFRoi+PQueOi7w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DIa417w9q3DrO2LVFx9m8bNWy0UzopFx6x+04p6CceJWdYSkh+JO5L01usgLLvNkM
	 U9D7XKGW0xCoQH3mq3/HbqaLY32nuIOtXmJfZciomgtiLhKdsoM60DbTWu0/Y1VIaG
	 ppaI2+gCViou3rQckS7oxEbavT2EEIK3446m/boFMWPc6pcey6PzwgAUbN1r4mQUxZ
	 lu1xTR0La8TDgkeNMcchc0ochxTkv8tIlJfWaTSzrApiEM6/WglGCiqlJsCax8ZOvr
	 YcwxmNS1Gom82p9gTb8Q4SMpwYiVuWG23dwDPQuS5QE/xhu3Kr2NxqEXnWkXFLPaEu
	 CDp7VIiXOpicw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5/5] block: improve checks in blk_revalidate_disk_zones()
Date: Thu, 29 Jun 2023 15:26:02 +0900
Message-ID: <20230629062602.234913-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629062602.234913-1-dlemoal@kernel.org>
References: <20230629062602.234913-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_232611_117102_48966701 
X-CRM114-Status: GOOD (  26.68  )
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

Modify blk_revalidate_disk_zones() to improves checks of a zoned block
device zones and of the device limits. In particular, make sure that the
device driver reported that the zoned device supports zone append
operation by defining a non-zero max_zone_append_sectors queue limit.

These changes rely on the constraint that when
blk_revalidate_disk_zones() is called, the device driver must have set
the device zone size (chunk_sectors queue limit) and the
max_zone_append_sectors queue limit. With this assumption, the zone
checks implemented in blk_revalidate_zone_cb() can be improved as the
zone size and the total number of zones of the device are already known
and can be verified against the zone report of the device.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 99 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 36 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0f9f97cdddd9..2807b4ada18b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -442,7 +442,7 @@ struct blk_revalidate_zone_args {
 	unsigned long	*conv_zones_bitmap;
 	unsigned long	*seq_zones_wlock;
 	unsigned int	nr_zones;
-	sector_t	zone_sectors;
+	unsigned int	reported_zones;
 	sector_t	sector;
 };
 
@@ -456,35 +456,40 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	struct gendisk *disk = args->disk;
 	struct request_queue *q = disk->queue;
 	sector_t capacity = get_capacity(disk);
+	sector_t zone_sectors = q->limits.chunk_sectors;
+	unsigned int nr_zones = args->nr_zones;
+
+	/* Check that the device is not reporting too many zones */
+	args->reported_zones++;
+	if (args->reported_zones > nr_zones) {
+		pr_warn("%s: Too many zones reported\n", disk->disk_name);
+		return -ENODEV;
+	}
+
+	/* Check that the zone is valid and within the disk capacity */
+	if (!zone->len || zone->start + zone->len > capacity) {
+		pr_warn("%s: Invalid zone start %llu, len %llu\n",
+			disk->disk_name, zone->start, zone->len);
+		return -ENODEV;
+	}
 
 	/*
 	 * All zones must have the same size, with the exception on an eventual
 	 * smaller last zone.
 	 */
-	if (zone->start == 0) {
-		if (zone->len == 0 || !is_power_of_2(zone->len)) {
-			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
-				disk->disk_name, zone->len);
-			return -ENODEV;
-		}
-
-		args->zone_sectors = zone->len;
-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
-	} else if (zone->start + args->zone_sectors < capacity) {
-		if (zone->len != args->zone_sectors) {
+	if (zone->start + zone_sectors < capacity) {
+		if (zone->len != zone_sectors) {
 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
 				disk->disk_name);
 			return -ENODEV;
 		}
-	} else {
-		if (zone->len > args->zone_sectors) {
-			pr_warn("%s: Invalid zoned device with larger last zone size\n",
-				disk->disk_name);
-			return -ENODEV;
-		}
+	} else if (zone->len > zone_sectors) {
+		pr_warn("%s: Invalid zoned device with larger last zone size\n",
+			disk->disk_name);
+		return -ENODEV;
 	}
 
-	/* Check for holes in the zone report */
+	/* Check for invalid zone start and holes in the zone report */
 	if (zone->start != args->sector) {
 		pr_warn("%s: Zone gap at sectors %llu..%llu\n",
 			disk->disk_name, args->sector, zone->start);
@@ -496,7 +501,7 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	case BLK_ZONE_TYPE_CONVENTIONAL:
 		if (!args->conv_zones_bitmap) {
 			args->conv_zones_bitmap =
-				blk_alloc_zone_bitmap(q->node, args->nr_zones);
+				blk_alloc_zone_bitmap(q->node, nr_zones);
 			if (!args->conv_zones_bitmap)
 				return -ENOMEM;
 		}
@@ -506,7 +511,7 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
 		if (!args->seq_zones_wlock) {
 			args->seq_zones_wlock =
-				blk_alloc_zone_bitmap(q->node, args->nr_zones);
+				blk_alloc_zone_bitmap(q->node, nr_zones);
 			if (!args->seq_zones_wlock)
 				return -ENOMEM;
 		}
@@ -518,6 +523,7 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	}
 
 	args->sector += zone->len;
+
 	return 0;
 }
 
@@ -526,11 +532,13 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
  * @disk:	Target disk
  * @update_driver_data:	Callback to update driver data on the frozen disk
  *
- * Helper function for low-level device drivers to (re) allocate and initialize
- * a disk request queue zone bitmaps. This functions should normally be called
- * within the disk ->revalidate method for blk-mq based drivers.  For BIO based
- * drivers only q->nr_zones needs to be updated so that the sysfs exposed value
- * is correct.
+ * Helper function for low-level device drivers to check and (re) allocate and
+ * initialize a disk request queue zone bitmaps. This functions should normally
+ * be called within the disk ->revalidate method for blk-mq based drivers.
+ * Before calling this function, the device driver must already have set the
+ * device zone size (chunk_sector limit) and the max zone append limit.
+ * For BIO based drivers, this function cannot be used. BIO based device drivers
+ * only need to set disk->nr_zones so that the sysfs exposed value is correct.
  * If the @update_driver_data callback function is not NULL, the callback is
  * executed with the device request queue frozen after all zones have been
  * checked.
@@ -539,9 +547,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 			      void (*update_driver_data)(struct gendisk *disk))
 {
 	struct request_queue *q = disk->queue;
-	struct blk_revalidate_zone_args args = {
-		.disk		= disk,
-	};
+	sector_t zone_sectors = q->limits.chunk_sectors;
+	sector_t capacity = get_capacity(disk);
+	struct blk_revalidate_zone_args args = { };
 	unsigned int noio_flag;
 	int ret;
 
@@ -550,13 +558,31 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	if (WARN_ON_ONCE(!queue_is_mq(q)))
 		return -EIO;
 
-	if (!get_capacity(disk))
-		return -EIO;
+	if (!capacity)
+		return -ENODEV;
+
+	/*
+	 * Checks that the device driver indicated a valid zone size and that
+	 * the max zone append limit is set.
+	 */
+	if (!zone_sectors || !is_power_of_2(zone_sectors)) {
+		pr_warn("%s: Invalid non power of two zone size (%llu)\n",
+			disk->disk_name, zone_sectors);
+		return -ENODEV;
+	}
+
+	if (!q->limits.max_zone_append_sectors) {
+		pr_warn("%s: Invalid 0 maximum zone append limit\n",
+			disk->disk_name);
+		return -ENODEV;
+	}
 
 	/*
 	 * Ensure that all memory allocations in this context are done as if
 	 * GFP_NOIO was specified.
 	 */
+	args.disk = disk;
+	args.nr_zones = (capacity + zone_sectors - 1) >> ilog2(zone_sectors);
 	noio_flag = memalloc_noio_save();
 	ret = disk->fops->report_zones(disk, 0, UINT_MAX,
 				       blk_revalidate_zone_cb, &args);
@@ -568,11 +594,13 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 
 	/*
 	 * If zones where reported, make sure that the entire disk capacity
-	 * has been checked.
+	 * has been checked and that the total number of reported zones matches
+	 * the number of zones of the device.
 	 */
-	if (ret > 0 && args.sector != get_capacity(disk)) {
-		pr_warn("%s: Missing zones from sector %llu\n",
-			disk->disk_name, args.sector);
+	if (ret > 0 &&
+	    (args.sector != capacity || args.reported_zones != args.nr_zones)) {
+		pr_warn("%s: Invalid zone report\n",
+			disk->disk_name);
 		ret = -ENODEV;
 	}
 
@@ -583,7 +611,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	 */
 	blk_mq_freeze_queue(q);
 	if (ret > 0) {
-		blk_queue_chunk_sectors(q, args.zone_sectors);
 		disk->nr_zones = args.nr_zones;
 		swap(disk->seq_zones_wlock, args.seq_zones_wlock);
 		swap(disk->conv_zones_bitmap, args.conv_zones_bitmap);
-- 
2.41.0


