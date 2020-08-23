Return-Path: <SRS0=yzsN=CB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749B2C433DF
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2020 09:11:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418332072D
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2020 09:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xMSxBRdp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XYgGjibG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418332072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mZ4DqNpGL9mmopKo3M8xSNxCw1fKcuovsICU4DW/rPw=; b=xMSxBRdpd4y8b9+A1ETGMKkNr
	V3eIlgCh8azZecDm/ongsbno+QW0lFg8caTuU1eL37kUH38QJHvg860Jfp4M1a2Z+mVopfShldX0B
	JC75niFKrKRfffIs6V9F8IV5A9xYQOGy4nLsSVvosxTSYY61VDTe57pNAH7nqtdzddJItz1ePEWsY
	LoJ5VMWFaJvdEuRUkBWt6IA4lwIBAgG+yAxM3koKab1C47xvIc3OMCvEahOcvIuHJ64tTfxVOhMK5
	xLffuKFGXgc7TyrwYOsxkbfJeRf2e3yc0U2QHz0BJo6C64c527IusBqbsksxLw8PWa+AsvVYG5tTP
	v+Y2L1czQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k9m1l-0008AQ-6b; Sun, 23 Aug 2020 09:11:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9m1f-00088r-GW
 for linux-nvme@merlin.infradead.org; Sun, 23 Aug 2020 09:10:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=WHEcibrKl8+wKi1ybgFSp3MWjJrWDe8r3xn83RKWybI=; b=XYgGjibGrOrNXNu5NInJV3tM1l
 GDXIb/vauCjirhxRO8Zvz8tD07xErusBxgqcAP5Hzv+I00VB7hXtfvazberNfBbHsBVTOQjE0vx/Y
 9OZcOlpRByyxkCHw+UZRosOTY3VNQERAs42aUzMkT0slrWk0/ZlQnY8c/7IVliKP10nim5ITF5FEB
 Cu1p+RgLamVHFfHEddz8gODhrAS1oLFoOJWaiM7D6ktW2wutM5AJ3c8+D78jAI92Yj1MrmbB/Vell
 ctX6XRtN9y8czd+yQ9eBhGQiy305avdCNs0wMA9B4WEY6ngVue+pcbFZ0q5f4BzBts9j2+2aRM8WD
 KrZ6nvPw==;
Received: from 171.168.43.195.cust.ip.kpnqwest.it ([195.43.168.171]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9m1Z-0003L8-Bx; Sun, 23 Aug 2020 09:10:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] block: fix locking for struct block_device size updates
Date: Sun, 23 Aug 2020 11:10:42 +0200
Message-Id: <20200823091043.2600261-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200823091043.2600261-1-hch@lst.de>
References: <20200823091043.2600261-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
 Justin Sanders <justin@coraid.com>, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, Xianting Tian <xianting_tian@126.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com,
 Stefan Haberland <sth@linux.ibm.com>, nbd@other.debian.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Two different callers use two different mutexes for updating the
block device size, which obviously doesn't help to actually protect
against concurrent updates from the different callers.  In addition
one of the locks, bd_mutex is rather prone to deadlocks with other
parts of the block stack that use it for high level synchronization.

Switch to using a new spinlock protecting just the size updates, as
that is all we need, and make sure everyone does the update through
the proper helper.

This fixes a bug reported with the nvme revalidating disks during a
hot removal operation, which can currently deadlock on bd_mutex.

Reported-by: Xianting Tian <xianting_tian@126.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c         |  4 ++--
 drivers/block/aoe/aoecmd.c      |  4 +---
 drivers/md/dm.c                 | 15 ++-------------
 drivers/s390/block/dasd_ioctl.c |  9 ++-------
 fs/block_dev.c                  | 25 ++++++++++++++-----------
 include/linux/blk_types.h       |  1 +
 6 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index e62a98a8eeb750..328a2cb7875ba1 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -585,8 +585,8 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 	if (partition_overlaps(bdev->bd_disk, start, length, partno))
 		goto out_unlock;
 
-	part_nr_sects_write(part, (sector_t)length);
-	i_size_write(bdevp->bd_inode, length << SECTOR_SHIFT);
+	part_nr_sects_write(part, length);
+	bd_set_nr_sectors(bdevp, length);
 
 	ret = 0;
 out_unlock:
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 3cf9bc5d8d9599..6ad73fe730bede 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -900,9 +900,7 @@ aoecmd_sleepwork(struct work_struct *work)
 		ssize = get_capacity(d->gd);
 		bd = bdget_disk(d->gd, 0);
 		if (bd) {
-			inode_lock(bd->bd_inode);
-			i_size_write(bd->bd_inode, (loff_t)ssize<<9);
-			inode_unlock(bd->bd_inode);
+			bd_set_nr_sectors(bd, ssize);
 			bdput(bd);
 		}
 		spin_lock_irq(&d->lock);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 32fa6499739fb9..6b21e5104e3e08 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2097,18 +2097,6 @@ static void event_callback(void *context)
 	dm_issue_global_event();
 }
 
-/*
- * Protected by md->suspend_lock obtained by dm_swap_table().
- */
-static void __set_size(struct mapped_device *md, sector_t size)
-{
-	lockdep_assert_held(&md->suspend_lock);
-
-	set_capacity(md->disk, size);
-
-	i_size_write(md->bdev->bd_inode, (loff_t)size << SECTOR_SHIFT);
-}
-
 /*
  * Returns old map, which caller must destroy.
  */
@@ -2131,7 +2119,8 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 	if (size != dm_get_size(md))
 		memset(&md->geometry, 0, sizeof(md->geometry));
 
-	__set_size(md, size);
+	set_capacity(md->disk, size);
+	bd_set_nr_sectors(md->bdev, size);
 
 	dm_table_event_callback(t, event_callback, md);
 
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 777734d1b4e58c..faaf5596e31c12 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -55,10 +55,7 @@ dasd_ioctl_enable(struct block_device *bdev)
 
 	dasd_enable_device(base);
 	/* Formatting the dasd device can change the capacity. */
-	mutex_lock(&bdev->bd_mutex);
-	i_size_write(bdev->bd_inode,
-		     (loff_t)get_capacity(base->block->gdp) << 9);
-	mutex_unlock(&bdev->bd_mutex);
+	bd_set_nr_sectors(bdev, get_capacity(base->block->gdp));
 	dasd_put_device(base);
 	return 0;
 }
@@ -91,9 +88,7 @@ dasd_ioctl_disable(struct block_device *bdev)
 	 * Set i_size to zero, since read, write, etc. check against this
 	 * value.
 	 */
-	mutex_lock(&bdev->bd_mutex);
-	i_size_write(bdev->bd_inode, 0);
-	mutex_unlock(&bdev->bd_mutex);
+	bd_set_nr_sectors(bdev, 0);
 	dasd_put_device(base);
 	return 0;
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index f52597172c8b79..08158bb2e76c85 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -876,6 +876,7 @@ struct block_device *bdget(dev_t dev)
 	bdev = &BDEV_I(inode)->bdev;
 
 	if (inode->i_state & I_NEW) {
+		spin_lock_init(&bdev->bd_size_lock);
 		bdev->bd_contains = NULL;
 		bdev->bd_super = NULL;
 		bdev->bd_inode = inode;
@@ -1290,6 +1291,7 @@ static void check_disk_size_change(struct gendisk *disk,
 {
 	loff_t disk_size, bdev_size;
 
+	spin_lock(&bdev->bd_size_lock);
 	disk_size = (loff_t)get_capacity(disk) << 9;
 	bdev_size = i_size_read(bdev->bd_inode);
 	if (disk_size != bdev_size) {
@@ -1299,11 +1301,15 @@ static void check_disk_size_change(struct gendisk *disk,
 			       disk->disk_name, bdev_size, disk_size);
 		}
 		i_size_write(bdev->bd_inode, disk_size);
-		if (bdev_size > disk_size && __invalidate_device(bdev, false))
+	}
+	bdev->bd_invalidated = 0;
+	spin_unlock(&bdev->bd_size_lock);
+
+	if (bdev_size > disk_size) {
+		if (__invalidate_device(bdev, false))
 			pr_warn("VFS: busy inodes on resized disk %s\n",
 				disk->disk_name);
 	}
-	bdev->bd_invalidated = 0;
 }
 
 /**
@@ -1328,13 +1334,10 @@ int revalidate_disk(struct gendisk *disk)
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		struct block_device *bdev = bdget_disk(disk, 0);
 
-		if (!bdev)
-			return ret;
-
-		mutex_lock(&bdev->bd_mutex);
-		check_disk_size_change(disk, bdev, ret == 0);
-		mutex_unlock(&bdev->bd_mutex);
-		bdput(bdev);
+		if (bdev) {
+			check_disk_size_change(disk, bdev, ret == 0);
+			bdput(bdev);
+		}
 	}
 	return ret;
 }
@@ -1373,9 +1376,9 @@ EXPORT_SYMBOL(check_disk_change);
 
 void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
-	inode_lock(bdev->bd_inode);
+	spin_lock(&bdev->bd_size_lock);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	inode_unlock(bdev->bd_inode);
+	spin_unlock(&bdev->bd_size_lock);
 }
 EXPORT_SYMBOL(bd_set_nr_sectors);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4ecf4fed171f0d..5accc2549d2259 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -38,6 +38,7 @@ struct block_device {
 	/* number of times partitions within this device have been opened. */
 	unsigned		bd_part_count;
 	int			bd_invalidated;
+	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct gendisk *	bd_disk;
 	struct backing_dev_info *bd_bdi;
 
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
