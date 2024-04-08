Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99EACD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 02:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQkeNLa6lQqESlUqDn8TVgkRKtTx7+mOjQYFKStyeMA=; b=Jk97TanoYrbhRv6sYlcvKj4Bnt
	gZqPtFchq0nDPxvk1klcLkeq+Si3u39eXN4Fim6+4Kozfbj3U3tUU3PW/blgeF9GIyvY1VkE6lyTf
	WXlFkJKeYCK2Tqs0ROCNYw0s5594BzPziN1HcHmBPbkJQCAFpRmW6CuRZhM6ioQHkviXd0m6g6vSx
	VSgn/6DPSuy6c+o78XFWS6TkHTTpgRDCMMvHZM45dsGX39s2iq3Gw0UQpXoz4/qxxRed1SMDJ8BgG
	HMPJ6BY5hccJw1LZYAAtRqlA/TwEQxf2GKU+zCkvRBAIDX0dSzvqCDzWXGZ5ktXp9l9KxY3wQtQec
	qsoQIUUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtf11-0000000E5RW-2UUh;
	Mon, 08 Apr 2024 02:45:47 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1T-0000000DvgH-0fl0
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:42:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 91385CE0B9F;
	Mon,  8 Apr 2024 01:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8B2C43394;
	Mon,  8 Apr 2024 01:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540528;
	bh=q7M65sQtQJ4mE/opwKVzA4OsxZFAouimm/kXT3cZGyE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sAq+QyHgkRO9OukSjfCpi9kuGeF7TQ0n4B8Hf9dg59qIlIHrqdbjgzxVrCe55Te1i
	 UwceWP4n2MKvVXkhlF8asVFp9rYkXhM0fzF78n32kmX7qR/x47oX40gE6AS4exx4P/
	 iezWaVqVvTT1m1WlYmeHGIlu8znfp9fzQMYUfJ+HtmcuBsHaoAzj+CFtCFEr6MjEkI
	 HUgMESxNBanCc6IevYc+Vd2IX1LKwxBn6pkO+pdvnRE566vl0krI1tzOUyJoRKSLBB
	 7hUZBaAssv3DKUH+b/Zt6KR9/OMJ3K7KrjECsRHsG2stc9PGB4TekQTrD8TtW8XEKV
	 +0QC1NCkBbRew==
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
Subject: [PATCH v7 20/28] block: Simplify blk_revalidate_disk_zones() interface
Date: Mon,  8 Apr 2024 10:41:20 +0900
Message-ID: <20240408014128.205141-21-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184211_997283_1E9DED76 
X-CRM114-Status: GOOD (  22.75  )
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

The only user of blk_revalidate_disk_zones() second argument was the
SCSI disk driver (sd). Now that this driver does not require this
update_driver_data argument, remove it to simplify the interface of
blk_revalidate_disk_zones(). Also update the function kdoc comment to
be more accurate (i.e. there is no gendisk ->revalidate method).

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-zoned.c              | 21 +++++++--------------
 drivers/block/null_blk/zoned.c |  2 +-
 drivers/block/ublk_drv.c       |  2 +-
 drivers/block/virtio_blk.c     |  2 +-
 drivers/md/dm-zone.c           |  2 +-
 drivers/nvme/host/core.c       |  2 +-
 drivers/scsi/sd_zbc.c          |  2 +-
 include/linux/blkdev.h         |  3 +--
 8 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index da0fc7e2d00a..e46d23ad2fa9 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1713,21 +1713,17 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 /**
  * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
  * @disk:	Target disk
- * @update_driver_data:	Callback to update driver data on the frozen disk
  *
- * Helper function for low-level device drivers to check and (re) allocate and
- * initialize a disk request queue zone bitmaps. This functions should normally
- * be called within the disk ->revalidate method for blk-mq based drivers.
+ * Helper function for low-level device drivers to check, (re) allocate and
+ * initialize resources used for managing zoned disks. This function should
+ * normally be called by blk-mq based drivers when a zoned gendisk is probed
+ * and when the zone configuration of the gendisk changes (e.g. after a format).
  * Before calling this function, the device driver must already have set the
  * device zone size (chunk_sector limit) and the max zone append limit.
  * BIO based drivers can also use this function as long as the device queue
  * can be safely frozen.
- * If the @update_driver_data callback function is not NULL, the callback is
- * executed with the device request queue frozen after all zones have been
- * checked.
  */
-int blk_revalidate_disk_zones(struct gendisk *disk,
-			      void (*update_driver_data)(struct gendisk *disk))
+int blk_revalidate_disk_zones(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	sector_t zone_sectors = q->limits.chunk_sectors;
@@ -1794,13 +1790,10 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	 * referencing the bitmaps).
 	 */
 	blk_mq_freeze_queue(q);
-	if (ret > 0) {
+	if (ret > 0)
 		ret = disk_update_zone_resources(disk, &args);
-		if (update_driver_data)
-			update_driver_data(disk);
-	} else {
+	else
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
-	}
 	if (ret)
 		disk_free_zone_resources(disk);
 	blk_mq_unfreeze_queue(q);
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 0b2af273adaf..4ddd84752557 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -177,7 +177,7 @@ int null_register_zoned_dev(struct nullb *nullb)
 		disk->disk_name,
 		queue_emulates_zone_append(q) ? "emulated" : "native");
 
-	return blk_revalidate_disk_zones(disk, NULL);
+	return blk_revalidate_disk_zones(disk);
 }
 
 void null_free_zoned_dev(struct nullb_device *dev)
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ab6af84e327c..851c78913de2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -221,7 +221,7 @@ static int ublk_get_nr_zones(const struct ublk_device *ub)
 
 static int ublk_revalidate_disk_zones(struct ublk_device *ub)
 {
-	return blk_revalidate_disk_zones(ub->ub_disk, NULL);
+	return blk_revalidate_disk_zones(ub->ub_disk);
 }
 
 static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 42dea7601d87..c1af0a7d56c8 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1543,7 +1543,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	 */
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && lim.zoned) {
 		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, vblk->disk->queue);
-		err = blk_revalidate_disk_zones(vblk->disk, NULL);
+		err = blk_revalidate_disk_zones(vblk->disk);
 		if (err)
 			goto out_cleanup_disk;
 	}
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 34769f3e3175..d17ae4486a6a 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -169,7 +169,7 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
 	 * our table for dm_blk_report_zones() to use directly.
 	 */
 	md->zone_revalidate_map = t;
-	ret = blk_revalidate_disk_zones(disk, NULL);
+	ret = blk_revalidate_disk_zones(disk);
 	md->zone_revalidate_map = NULL;
 
 	if (ret) {
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 27281a9a8951..8ae0a2dc5eda 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2153,7 +2153,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
 	if (blk_queue_is_zoned(ns->queue)) {
-		ret = blk_revalidate_disk_zones(ns->disk, NULL);
+		ret = blk_revalidate_disk_zones(ns->disk);
 		if (ret && !nvme_first_scan(ns->disk))
 			goto out;
 	}
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index d0ead9858954..806036e48abe 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -572,7 +572,7 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	blk_queue_max_zone_append_sectors(q, 0);
 
 	flags = memalloc_noio_save();
-	ret = blk_revalidate_disk_zones(disk, NULL);
+	ret = blk_revalidate_disk_zones(disk);
 	memalloc_noio_restore(flags);
 	if (ret) {
 		sdkp->zone_info = (struct zoned_disk_info){ };
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0b69027e1713..359e2b7d27fa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -336,8 +336,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
 int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		sector_t sectors, sector_t nr_sectors);
-int blk_revalidate_disk_zones(struct gendisk *disk,
-		void (*update_driver_data)(struct gendisk *disk));
+int blk_revalidate_disk_zones(struct gendisk *disk);
 
 /*
  * Independent access ranges: struct blk_independent_access_range describes
-- 
2.44.0


