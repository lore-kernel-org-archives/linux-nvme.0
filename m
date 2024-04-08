Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C18ACD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 01:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HDrUzHOoe7NjyW1vk2FzS7X6HOlmqq5JE81N6KnwVZo=; b=A1mTwfl1wrAT6N+UHROoN9sK5e
	rKiOx3alHSJAGF2wM5YvCc+Bz3GR/ytueT3e21m4b4M8igQwSELT4WZYuuiFcGzNdLxk8AsnWypZH
	zQ3yo9hh4JyJ8g91/bIIPhgJeOMg8oJCWgOGb7XB63WOtK0sfvZ/3VJ8KR5VvwjOgtO6hb8B3Ng8c
	kKNclKTIsgOQ3tP6xmhnx9aT5VkHeu0VC9B+KNaRLMZtj5o55ykKoDIrj5Oz3Qyk+O6HdGPnqU6Tv
	SYm7rHI4or/DFHzdtFT7lubXva/cXLbNisf+qbuQ8phxeND7FzukAQIQJ/hWFP1sHahCTMHFbbj1q
	LNoRwhMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1c-0000000Dvqd-38bg;
	Mon, 08 Apr 2024 01:42:20 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1D-0000000DvRh-02a6
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:41:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1885DCE0B8C;
	Mon,  8 Apr 2024 01:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945FAC43399;
	Mon,  8 Apr 2024 01:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540512;
	bh=EYoOyXtGNsUhbIpXqm9CFYw9V+FR75APfh8P7nxHMHs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jtxj8+LUGeMTVBzpF2DaaRefeYHNvIGz/3ZUMpuXMEMJx1xzVdINPWDIXGNmUIlp8
	 pYzNr7x4QdDod/wfo/bn7YYe0toKDTUrV8b+0nq1JPD832WznPk5lqIjr58VPDNFOh
	 QL9PVf/mlBcAkhppSs1e5qZ2pWl0eDUFKvWhMJ4gvPMp08+5FwgcO+SinGgPDRsWUf
	 Oo00xOybGRr1IWKxAEMNDUaRA54m91qQhDiJWQPmr1INK7h3fuqLX42+mNUaL+wbL0
	 Bcc5SWieO1T5/1sVU0JbOFKrfz9PceXSRCm6ULrDUdZZExR68/z1hNy6L55zYAj0zx
	 m8c0DILrWeKig==
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
Subject: [PATCH v7 11/28] block: Allow BIO-based drivers to use blk_revalidate_disk_zones()
Date: Mon,  8 Apr 2024 10:41:11 +0900
Message-ID: <20240408014128.205141-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184156_392437_DAA8ECF6 
X-CRM114-Status: GOOD (  24.86  )
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

In preparation for allowing BIO based device drivers to use zone write
plugging and its zone append emulation, allow these drivers to call
blk_revalidate_disk_zones() so that all zone resources necessary to zone
write plugging can be initialized.

To do so, remove the check in blk_revalidate_disk_zones() restricting
the use of this function to mq request-based drivers to allow also
BIO-based drivers to use it. This is safe to do as long as the
BIO-based block device queue is already setup and usable, as it should,
and can be safely frozen.

The helper function disk_need_zone_resources() is added to control the
allocation and initialization of the zone write plug hash table and
of the conventional zone bitmap only for mq devices and for BIO-based
devices that require zone append emulation.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-zoned.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a60ac5b3e637..da0fc7e2d00a 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1512,12 +1512,28 @@ void disk_free_zone_resources(struct gendisk *disk)
 	disk->nr_zones = 0;
 }
 
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
 static int disk_revalidate_zone_resources(struct gendisk *disk,
 					  unsigned int nr_zones)
 {
 	struct queue_limits *lim = &disk->queue->limits;
 	unsigned int pool_size;
 
+	if (!disk_need_zone_resources(disk))
+		return 0;
+
 	/*
 	 * If the device has no limit on the maximum number of open and active
 	 * zones, use BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE.
@@ -1635,6 +1651,9 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 				disk->disk_name);
 			return -ENODEV;
 		}
+
+		if (!disk_need_zone_resources(disk))
+			break;
 		if (!args->conv_zones_bitmap) {
 			args->conv_zones_bitmap =
 				blk_alloc_zone_bitmap(q->node, args->nr_zones);
@@ -1666,10 +1685,11 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		/*
 		 * We need to track the write pointer of all zones that are not
 		 * empty nor full. So make sure we have a zone write plug for
-		 * such zone.
+		 * such zone if the device has a zone write plug hash table.
 		 */
 		wp_offset = blk_zone_wp_offset(zone);
-		if (wp_offset && wp_offset < zone_sectors) {
+		if (disk->zone_wplugs_hash &&
+		    wp_offset && wp_offset < zone_sectors) {
 			zwplug = disk_get_and_lock_zone_wplug(disk, zone->start,
 							      GFP_NOIO, &flags);
 			if (!zwplug)
@@ -1700,8 +1720,8 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
  * be called within the disk ->revalidate method for blk-mq based drivers.
  * Before calling this function, the device driver must already have set the
  * device zone size (chunk_sector limit) and the max zone append limit.
- * For BIO based drivers, this function cannot be used. BIO based device drivers
- * only need to set disk->nr_zones so that the sysfs exposed value is correct.
+ * BIO based drivers can also use this function as long as the device queue
+ * can be safely frozen.
  * If the @update_driver_data callback function is not NULL, the callback is
  * executed with the device request queue frozen after all zones have been
  * checked.
@@ -1718,8 +1738,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
 		return -EIO;
-	if (WARN_ON_ONCE(!queue_is_mq(q)))
-		return -EIO;
 
 	if (!capacity)
 		return -ENODEV;
-- 
2.44.0


