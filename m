Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC29C433E5
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 08:56:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29679207DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 08:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mR3ytP0w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VGlK22TF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29679207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IY/RzRSqllalBN0a1UA8caFHTWPRwZ3ihRIVxGcl11U=; b=mR3ytP0wEMSwn7ag2gLE5lU7b
	tL//dYQW02yEMVsYoPiH4YrBryv8AbgV5rY5hohKL1GQp9Y1CbL9BlXwUiD1BoiefAhr9VL2SVpyU
	69zGJAMnFLjyyqyter34G9+L5qZUPYENuTt/yBz3dmhFXDF6eMM2gwxkV1TTAGn0t3BnOkM2PURbG
	XAtjGRocc4TAxWmweHhFya47AWzI/2yFS9OfCVbMwIawjbzZuy+KNiFWyI+bdfP4iR+xERxesHr9a
	ceaql7I/a1tYp0QmUnBDQquQEoEUWu0eDztCmyQdu8VPgCASyWsUiEL6xnK1cdBTBNlNA4n8r5zkC
	pKKmfQdyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k92qy-0000Tp-Ae; Fri, 21 Aug 2020 08:56:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k92qu-0000Rc-A3
 for linux-nvme@merlin.infradead.org; Fri, 21 Aug 2020 08:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=qnhv8iYHAvUTE/7CFzUHZuKNCiy/aV6RSD2K0k6RE/I=; b=VGlK22TFQ43z+zqnc6T7CIKRZa
 7vKFed5EW0wEXRUGlLIyXKioi8CVgOBlYcWHAnqfuu5TWNhINW7TtAWeVZqUuNlouA9/qhsRrqUDT
 LCJghbOrhnfYVA9xrJqsdDcgP86Cx4l9jOd3gdi7KYTzX5UD7TAsqYAeN5S7VYCzGOUH4Ic20BE+u
 TOxcjaGkRnPKdtQnE32OD6lsVrDv56r4IOsiRIKTfEbcV569sv0ta0JisbOiTbVE15iilpVKFMOlo
 wkIZ4P6dz2/7GVXuF+WO+fkvsZpC7LocgkFZ5YJOweI2VV16tZqdPKrc2XVJdbIOa1yxtR4pCIlZz
 q6UIyDHw==;
Received: from [2001:4bb8:198:f3b2:a2b:85ba:fb78:c253] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k92qM-0007g0-RC; Fri, 21 Aug 2020 08:56:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: replace bd_set_size with bd_set_nr_sectors
Date: Fri, 21 Aug 2020 10:55:59 +0200
Message-Id: <20200821085600.2395666-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821085600.2395666-1-hch@lst.de>
References: <20200821085600.2395666-1-hch@lst.de>
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

Replace bd_set_size with a version that takes the number of sectors
instead, as that fits most of the current and future callers much better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c     |  4 ++--
 drivers/block/nbd.c      |  7 ++++---
 drivers/block/pktcdvd.c  |  2 +-
 drivers/nvme/host/nvme.h |  2 +-
 fs/block_dev.c           | 10 +++++-----
 include/linux/genhd.h    |  2 +-
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2f137d6ce169d5..7069899a94903e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -253,7 +253,7 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 {
 	struct block_device *bdev = lo->lo_device;
 
-	bd_set_size(bdev, size << SECTOR_SHIFT);
+	bd_set_nr_sectors(bdev, size);
 
 	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
 }
@@ -1248,7 +1248,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	set_capacity(lo->lo_disk, 0);
 	loop_sysfs_exit(lo);
 	if (bdev) {
-		bd_set_size(bdev, 0);
+		bd_set_nr_sectors(bdev, 0);
 		/* let user-space know about this change */
 		kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
 	}
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3ff4054d6834d2..f07243335472a4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -300,6 +300,7 @@ static void nbd_size_update(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
 	struct block_device *bdev = bdget_disk(nbd->disk, 0);
+	sector_t nr_sectors = config->bytesize >> 9;
 
 	if (config->flags & NBD_FLAG_SEND_TRIM) {
 		nbd->disk->queue->limits.discard_granularity = config->blksize;
@@ -308,10 +309,10 @@ static void nbd_size_update(struct nbd_device *nbd)
 	}
 	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
-	set_capacity(nbd->disk, config->bytesize >> 9);
+	set_capacity(nbd->disk, nr_sectors);
 	if (bdev) {
 		if (bdev->bd_disk) {
-			bd_set_size(bdev, config->bytesize);
+			bd_set_nr_sectors(bdev, nr_sectors);
 			set_blocksize(bdev, config->blksize);
 		} else
 			bdev->bd_invalidated = 1;
@@ -1138,7 +1139,7 @@ static void nbd_bdev_reset(struct block_device *bdev)
 {
 	if (bdev->bd_openers > 1)
 		return;
-	bd_set_size(bdev, 0);
+	bd_set_nr_sectors(bdev, 0);
 }
 
 static void nbd_parse_flags(struct nbd_device *nbd)
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 4becc1efe775fc..015fe128fa8a35 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2192,7 +2192,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 
 	set_capacity(pd->disk, lba << 2);
 	set_capacity(pd->bdev->bd_disk, lba << 2);
-	bd_set_size(pd->bdev, (loff_t)lba << 11);
+	bd_set_nr_sectors(pd->bdev, lba << 2);
 
 	q = bdev_get_queue(pd->bdev);
 	if (write) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ebb8c3ed388554..ae5cad5a08f411 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -664,7 +664,7 @@ static inline void nvme_mpath_update_disk_size(struct gendisk *disk)
 	struct block_device *bdev = bdget_disk(disk, 0);
 
 	if (bdev) {
-		bd_set_size(bdev, get_capacity(disk) << SECTOR_SHIFT);
+		bd_set_nr_sectors(bdev, get_capacity(disk));
 		bdput(bdev);
 	}
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8ae833e004439b..f52597172c8b79 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1371,13 +1371,13 @@ int check_disk_change(struct block_device *bdev)
 
 EXPORT_SYMBOL(check_disk_change);
 
-void bd_set_size(struct block_device *bdev, loff_t size)
+void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
 	inode_lock(bdev->bd_inode);
-	i_size_write(bdev->bd_inode, size);
+	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
 	inode_unlock(bdev->bd_inode);
 }
-EXPORT_SYMBOL(bd_set_size);
+EXPORT_SYMBOL(bd_set_nr_sectors);
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
@@ -1514,7 +1514,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 			}
 
 			if (!ret) {
-				bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
+				bd_set_nr_sectors(bdev, get_capacity(disk));
 				set_init_blocksize(bdev);
 			}
 
@@ -1542,7 +1542,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 				ret = -ENXIO;
 				goto out_clear;
 			}
-			bd_set_size(bdev, (loff_t)bdev->bd_part->nr_sects << 9);
+			bd_set_nr_sectors(bdev, bdev->bd_part->nr_sects);
 			set_init_blocksize(bdev);
 		}
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4ab853461dff25..39025dc0397c04 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -375,7 +375,7 @@ void unregister_blkdev(unsigned int major, const char *name);
 int revalidate_disk(struct gendisk *disk);
 int check_disk_change(struct block_device *bdev);
 int __invalidate_device(struct block_device *bdev, bool kill_dirty);
-void bd_set_size(struct block_device *bdev, loff_t size);
+void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors);
 
 /* for drivers/char/raw.c: */
 int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
