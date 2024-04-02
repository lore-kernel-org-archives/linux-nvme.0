Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ED8C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h3QJjnozlgpXNyzj3ktQjhDox3vvnRbUhXG/bE5u0DQ=; b=k75Eq8MOVfbJ1H/k/qfhswQrI+
	b5d8NYE/GOIcQZ67jsaTR602NWM+x/OW+5mz7P8v1XT0gyKvQxC9AOhd6BcekaGPWqglBRpCyjqMU
	uNkhlVgWYtUrp7n48HIGEjypBanNff6t1XSNMv5by6U9OWTc6TelM95wGF4zIYcMWak602wgUKUe2
	Fhu+1ID2Oe6aAr2mVipqHknNEbbCi/pPnqveeV4wMVOOx18tUBimt414mG2VN7yPr09dxBvs1G8Rh
	vC+4SmGFaKfk42bncu/f+EyhedZnaLufkK4iYdl7kjB+9IMUFfhW8AE9WqotvilANOWj0WnGhPo39
	7y1asKYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rreVK-0000000BQUD-3YhZ;
	Tue, 02 Apr 2024 13:48:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQU-0000000B6Vr-0O6l
	for linux-nvme@bombadil.infradead.org;
	Tue, 02 Apr 2024 12:39:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=h3QJjnozlgpXNyzj3ktQjhDox3vvnRbUhXG/bE5u0DQ=; b=dxyjAQAVRfxBeLKjfMqESvQeTf
	nF+ChOj/FWTHB2xBa3RubmWFLAH9lFFW5IU6jgEUAKlT+CBBx0C4REbP/d8h4ldT41kFYzW82X3sX
	snBmIL8fR5gkODBCdM0YoazrJw1YwrGwEJ/ChMq8oC/WbWCvTAYSR5SPdBxlwP/lZzh1BSfdWulWo
	MJ1/3Ws4hArSP2Zc1ZQOoRjdY3qGwb7o2HNacN4A0D35JEptod/FkyiQzuOV11imlktitqprMI/SD
	odaVqjCfjQehMfduGgt1ox+b2pI+mbvIV4jwoTeONl2NAdiVmOKHRovKd6PJyr8stMgarbxOXd4o4
	Z3uXiwIg==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQJ-00000003cIF-3Joy
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:39:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5EC26CE1B63;
	Tue,  2 Apr 2024 12:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB148C433A6;
	Tue,  2 Apr 2024 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061566;
	bh=YPIaKOsrO+7gwz/y1sPBiG/bsfl7X2bIvwwSf9PGBzA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WSQEDo1gTwR3WLl53qaMTWNMEBrmWO5q8fawDc0MwSfPwh6MwTjuVP2DzVci0NziC
	 CeRNyZbnp9N+3hIfz9fWK+3v95bS59HRhJCshtE9fIKM/SclcKzQ8cE4awetxCeuD8
	 LWnhsZIGHDwTKkmDzLzXBMx/vF40fWVVSjQqXPBpAbVlbthW9Inc3P+98VRRS4G4AK
	 RBfesZvAJac7y+7qZsE0jn7zPplhy7ENGg5dQYVP+W3lPXmsge8LZBskFrLipPjBdZ
	 uh5dQA85KqTir1CyzqBuu6YZEN6Z7d+W2FBPCyO/8U8HWBEbLzH7HdDaTqYhi5dw6u
	 oJWzy3CbW40AQ==
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
Subject: [PATCH v4 11/28] block: Allow BIO-based drivers to use blk_revalidate_disk_zones()
Date: Tue,  2 Apr 2024 21:38:50 +0900
Message-ID: <20240402123907.512027-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_133933_256546_737CABD6 
X-CRM114-Status: GOOD (  24.90  )
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
---
 block/blk-zoned.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 71d692d9d851..c60d5f074585 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1527,12 +1527,28 @@ void disk_free_zone_resources(struct gendisk *disk)
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
@@ -1650,6 +1666,9 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 				disk->disk_name);
 			return -ENODEV;
 		}
+
+		if (!disk_need_zone_resources(disk))
+			break;
 		if (!args->conv_zones_bitmap) {
 			args->conv_zones_bitmap =
 				blk_alloc_zone_bitmap(q->node, args->nr_zones);
@@ -1681,10 +1700,11 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
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
@@ -1715,8 +1735,8 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
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
@@ -1733,8 +1753,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
 		return -EIO;
-	if (WARN_ON_ONCE(!queue_is_mq(q)))
-		return -EIO;
 
 	if (!capacity)
 		return -ENODEV;
-- 
2.44.0


