Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCDEC47DD9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 01:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKyGkVyNXW+OgVf7lHwNldVFNTMQbJOX9RSzed+pCIA=; b=LZCtqsfzpqzHF6N9ZWm8RRCGuT
	BolD46fcyco04/+amsNiwuNiNC4os1Qdl2BCQJrXStH4cccNxekiQWfEmsG60ZpX1DQZj9FsjiiYs
	9FXiqPB6xazHww8ighhGZ0EEFmuNTyPE+rhar5S4E/9zB0Sr0NOYPq0Af8nP8PCbZnSY5w88r/8eE
	1L1cKMKStADbJbhXnD0SI5xeM5zumyxjKLnSCah49oPnDMa+LCtCRmf9xvOSMRb1xjUVKH0VXBR+y
	qOFxsO594oB9suRPms2GrTWHN1FhuSbnwhtNniVxVlf5VuLdtwQ5Ebs+FM1lzV0EoiNfqB4/CabG9
	hKX9OgWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpesn-0000000BzXY-0YY1;
	Thu, 28 Mar 2024 01:48:45 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsz-0000000Bngq-1neQ
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:45:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 54CA2CE28FC;
	Thu, 28 Mar 2024 00:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E257C43390;
	Thu, 28 Mar 2024 00:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586690;
	bh=Hy27yHhpeNDOcoQKr89VbQH+opbsY+GQcKtmaVsv5Eg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dvpT+4V7c77ynEfm2pCXibJYEq4/sHbmXhKVR1ttoABN7zFzTTqwwc//la5OAsNcn
	 9NvuEijGt2rmrfeyNbpwla18sumCP85a+5vMV3ROTIu12fC5vzge3ddD4wbtnRi7BT
	 Bi8k6txF2XemLaic8ANa3NAX8DUB2Jl/5MPRq6s+c1Gn+/I6n3ufzFGjdt04s130Cd
	 Q7HBbxxC9BQZYIKk4IZ31x0SspYc6EPe8HRLwGyodPkXOnjDf7s+wNjwj2fh4v4U+I
	 nikmKOs5R3Fk59gD2/iHqUbJJWIRrLI6NsZCZjcVTXMFzUX7sVxtHnOcqgzzL0A/tx
	 Jle4XPBbTH9nw==
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
Subject: [PATCH v3 22/30] block: Simplify blk_revalidate_disk_zones() interface
Date: Thu, 28 Mar 2024 09:44:01 +0900
Message-ID: <20240328004409.594888-23-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174454_653928_6EFB300C 
X-CRM114-Status: GOOD (  20.96  )
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
---
 block/blk-zoned.c              | 16 +++++-----------
 drivers/block/null_blk/zoned.c |  2 +-
 drivers/block/ublk_drv.c       |  2 +-
 drivers/block/virtio_blk.c     |  2 +-
 drivers/md/dm-zone.c           |  2 +-
 drivers/nvme/host/core.c       |  2 +-
 drivers/scsi/sd_zbc.c          |  2 +-
 include/linux/blkdev.h         |  3 +--
 8 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c41ac1519818..d0549b85f281 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1795,21 +1795,17 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
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
@@ -1881,8 +1877,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 		disk->zone_capacity = args.zone_capacity;
 		swap(disk->seq_zones_wlock, args.seq_zones_wlock);
 		swap(disk->conv_zones_bitmap, args.conv_zones_bitmap);
-		if (update_driver_data)
-			update_driver_data(disk);
 		ret = 0;
 	} else {
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 159746b0661c..34f4d273df38 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -179,7 +179,7 @@ int null_register_zoned_dev(struct nullb *nullb)
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
index 174fda0a301c..99d27fba01d3 100644
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
index 943d72bdd794..c9955ecd1790 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2150,7 +2150,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
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
index 45def924f7c1..d93005ca59e8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -337,8 +337,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
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


