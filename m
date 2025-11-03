Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D28CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dWwMVmmNoZtOfkddlKRcqKB7RVvIjAgH/UWmPYpAFjU=; b=CPCMH6WWMyB3Lcp2VG8gBD0wFz
	yMP1ZzVdujU5VJ2dipP7JY4SOS60Nwm6CN7wJngF1SmI8Ae3fuN5HT5CClNKRJQ5QR/1KYda3oLox
	cJYGEdJ1nozH9xDbKVuLvOj9UxS5RuHYaFcFhr9WuorX7PXSVZm0SIJke2FW5IrVqR64SIdKHQPfR
	7+ZSvEiNZ6mWOJp5J/kCDCvEHZAnYTlQzDJQq9bZVC85RLhlvXHDaYyjOFtHswxWOAl05KC+FwxYD
	M/tJ33yNeLpKs2CdLVomdLMOTXuXYhi/cJVfT12cJEjQMhOPc0Xquwf22nzlft393E10XMUN8y/Sx
	/sNImYXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuid-00000009uJ0-0MAD;
	Mon, 03 Nov 2025 13:35:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuiZ-00000009uEb-2pUO
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 13:35:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5E34743897;
	Mon,  3 Nov 2025 13:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C1AC116B1;
	Mon,  3 Nov 2025 13:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176931;
	bh=WyW+bpnTmlcPaemerxBrRCCpDX4Uy/eglLSDwXkJlSk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YXp1BqFdgWpa6L49EAw8Jve4Ak1bVgI2PipQOiv2nL/IC9CuwJ9WMFafjXHDgeQC2
	 g5o+zrxiqe5uhSB1bduizwixXgOTKeuREZc5QbPjP3kPeYz6s0qDwZmZO4tyxCLFQt
	 NVKEfb9UL+LJr8UAgmkGZP+B1moQ/NBFvzvpM/XJKCMDWrgDGhDD/gMmAgkpzEbdY0
	 J2X5d+RnqTH7ZI9hF+/X+BUDXzXazLDixd+z4d56DUvEMiriHq3K2INghpi0lkzbB/
	 mYVaV5FxUT2jZlNkI11EfOiKi1Jj458ykQ3Px8qoZg125LZx6Nht/SlD3T7uWBZZVk
	 v0INv8LfkAluw==
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
Subject: [PATCH v2 09/15] block: introduce blkdev_get_zone_info()
Date: Mon,  3 Nov 2025 22:31:17 +0900
Message-ID: <20251103133123.645038-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_053531_764652_6435488C 
X-CRM114-Status: GOOD (  27.02  )
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

Introduce the function blkdev_get_zone_info() to obtain a single zone
information from cached zone data, that is, either from the zone write
plug for the target zone if it exists and from the disk zones_cond
array otherwise.

Since sequential zones that do not have a zone write plug are either
full, empty or in a bad state (read-only or offline), the zone write
pointer can be inferred from the zone condition cached in the disk
zones_cond array. For sequential zones that have a zone write plug, the
zone condition and zone write pointer are obtained from the condition
and write pointer offset managed with the zone write plug. This allows
obtaining the information for a zone much more quickly than having to
execute a report zones command on the device.

blkdev_get_zone_info() falls back to using a regular zone report if the
target zone is flagged as needing an update with the
BLK_ZONE_WPLUG_NEED_WP_UPDATE flag, or if the target device does not
use zone write plugs (i.e. a device mapper device). In this case, the
new function blkdev_report_zone_fallback() is used and the zone
condition is reported consistantly with the cahced report, that is, the
BLK_ZONE_COND_ACTIVE condition is used in place of the implicit open,
explicit open and closed conditions. This is achieved by adding the
.report_active field to struct blk_report_zones_args and by having
disk_report_zone() sets the correct zone condition if .report_active is
true.

In preparation for using blkdev_get_zone_info() in upcoming file systems
changes, also export this function as a GPL symbol.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c      | 141 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   3 +
 2 files changed, 144 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6b4639f11896..8d75c9ef53a0 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -202,6 +202,7 @@ EXPORT_SYMBOL_GPL(bdev_zone_is_seq);
 struct blk_report_zones_args {
 	report_zones_cb cb;
 	void		*data;
+	bool		report_active;
 };
 
 static int blkdev_do_report_zones(struct block_device *bdev, sector_t sector,
@@ -811,6 +812,23 @@ static void disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
 int disk_report_zone(struct gendisk *disk, struct blk_zone *zone,
 		     unsigned int idx, struct blk_report_zones_args *args)
 {
+	if (args->report_active) {
+		/*
+		 * If we come here, then this is a report zones as a fallback
+		 * for a cached report. So collapse the implicit open, explicit
+		 * open and closed conditions into the active zone condition.
+		 */
+		switch (zone->cond) {
+		case BLK_ZONE_COND_IMP_OPEN:
+		case BLK_ZONE_COND_EXP_OPEN:
+		case BLK_ZONE_COND_CLOSED:
+			zone->cond = BLK_ZONE_COND_ACTIVE;
+			break;
+		default:
+			break;
+		}
+	}
+
 	if (disk->zone_wplugs_hash)
 		disk_zone_wplug_sync_wp_offset(disk, zone);
 
@@ -821,6 +839,129 @@ int disk_report_zone(struct gendisk *disk, struct blk_zone *zone,
 }
 EXPORT_SYMBOL_GPL(disk_report_zone);
 
+static int blkdev_report_zone_cb(struct blk_zone *zone, unsigned int idx,
+				 void *data)
+{
+	memcpy(data, zone, sizeof(struct blk_zone));
+	return 0;
+}
+
+static int blkdev_report_zone_fallback(struct block_device *bdev,
+				       sector_t sector, struct blk_zone *zone)
+{
+	struct blk_report_zones_args args = {
+		.cb = blkdev_report_zone_cb,
+		.data = zone,
+		.report_active = true,
+	};
+
+	return blkdev_do_report_zones(bdev, sector, 1, &args);
+}
+
+/**
+ * blkdev_get_zone_info - Get a single zone information from cached data
+ * @bdev:   Target block device
+ * @sector: Sector contained by the target zone
+ * @zone:   zone structure to return the zone information
+ *
+ * Description:
+ *    Get the zone information for the zone containing @sector using the zone
+ *    write plug of the target zone, if one exist, or the disk zone condition
+ *    array otherwise. The zone condition may be reported as being
+ *    the BLK_ZONE_COND_ACTIVE condition for a zone that is in the implicit
+ *    open, explicit open or closed condition.
+ *
+ *    Returns 0 on success and a negative error code on failure.
+ */
+int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
+			 struct blk_zone *zone)
+{
+	struct gendisk *disk = bdev->bd_disk;
+	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	struct blk_zone_wplug *zwplug;
+	unsigned long flags;
+	u8 *zones_cond;
+
+	if (!bdev_is_zoned(bdev))
+		return -EOPNOTSUPP;
+
+	if (sector >= get_capacity(disk))
+		return -EINVAL;
+
+	memset(zone, 0, sizeof(*zone));
+	sector = ALIGN_DOWN(sector, zone_sectors);
+
+	rcu_read_lock();
+	zones_cond = rcu_dereference(disk->zones_cond);
+	if (!disk->zone_wplugs_hash || !zones_cond) {
+		rcu_read_unlock();
+		return blkdev_report_zone_fallback(bdev, sector, zone);
+	}
+	zone->cond = zones_cond[disk_zone_no(disk, sector)];
+	rcu_read_unlock();
+
+	zone->start = sector;
+	zone->len = zone_sectors;
+
+	/*
+	 * If this is a conventional zone, we do not have a zone write plug and
+	 * can report the zone immediately.
+	 */
+	if (zone->cond == BLK_ZONE_COND_NOT_WP) {
+		zone->type = BLK_ZONE_TYPE_CONVENTIONAL;
+		zone->capacity = zone_sectors;
+		zone->wp = ULLONG_MAX;
+		return 0;
+	}
+
+	/*
+	 * This is a sequential write required zone. If the zone is read-only or
+	 * offline, only set the zone write pointer to an invalid value and
+	 * report the zone.
+	 */
+	zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
+	if (disk_zone_is_last(disk, zone))
+		zone->capacity = disk->last_zone_capacity;
+	else
+		zone->capacity = disk->zone_capacity;
+
+	if (zone->cond == BLK_ZONE_COND_READONLY ||
+	    zone->cond == BLK_ZONE_COND_OFFLINE) {
+		zone->wp = ULLONG_MAX;
+		return 0;
+	}
+
+	/*
+	 * If the zone does not have a zone write plug, it is either full or
+	 * empty, as we otherwise would have a zone write plug for it. In this
+	 * case, set the write pointer accordingly and report the zone.
+	 * Otherwise, if we have a zone write plug, use it.
+	 */
+	zwplug = disk_get_zone_wplug(disk, sector);
+	if (!zwplug) {
+		if (zone->cond == BLK_ZONE_COND_FULL)
+			zone->wp = ULLONG_MAX;
+		else
+			zone->wp = sector;
+		return 0;
+	}
+
+	spin_lock_irqsave(&zwplug->lock, flags);
+	if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE) {
+		spin_unlock_irqrestore(&zwplug->lock, flags);
+		disk_put_zone_wplug(zwplug);
+		return blkdev_report_zone_fallback(bdev, sector, zone);
+	}
+	zone->cond = zwplug->cond;
+	zone->wp = sector + zwplug->wp_offset;
+	spin_unlock_irqrestore(&zwplug->lock, flags);
+
+	disk_put_zone_wplug(zwplug);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blkdev_get_zone_info);
+
 static void blk_zone_reset_bio_endio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 53bcfbc2f68f..03a594b4dfbc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -436,6 +436,9 @@ typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 int disk_report_zone(struct gendisk *disk, struct blk_zone *zone,
 		     unsigned int idx, struct blk_report_zones_args *args);
 
+int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
+			 struct blk_zone *zone);
+
 #define BLK_ALL_ZONES  ((unsigned int)-1)
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
-- 
2.51.0


