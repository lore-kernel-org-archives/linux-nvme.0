Return-Path: <SRS0=yzsN=CB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7BDC433E3
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2020 09:11:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE5B20768
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2020 09:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GIrKIxbK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jd2+lONk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE5B20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YOJGBkrH1s3uhlacLJUsaJcVLISzUF+aBNq/ioT94hI=; b=GIrKIxbK3gnzCMer7OEH9bkZo
	AEzWUKBIJSj+OLaiUmDUoddtOqysW3wwU9umskByOtSDckrCphbqU3Y6e4LNdPo+KeHBkPIA1e3L8
	oXC67/Yx+Z6qHdk1G+ioKO9iQW7eRdYc+vGVBteAQpgQr3159m4/ptLPqOqtZ99pXtCFeiIu9sv3X
	xr7ZoH90Jcuwi6REu5eAGGpR/yXeU1S72GZvKywen2tVdVq3uHLzCxby6xpRj5X67k1uyontzj4fW
	8aw4pt32kBkZDHrqQW9D/UesD/Wgw0KsF6DDaZ1wTenxkbTUpJUYRvFMDyEbY/PnxDoZtHrQrPSbf
	eaX/yDA/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k9m1m-0008An-EQ; Sun, 23 Aug 2020 09:11:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9m1g-00089D-BC
 for linux-nvme@merlin.infradead.org; Sun, 23 Aug 2020 09:10:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=cLc8UFh8Zn6w+mLuoS0pkRz+kyaYfh0fJF4FT3u1x/M=; b=Jd2+lONkz5bk6PvfkHn1D/V7qV
 Vlyk1nLSCtExUzPZkfp3rBQN8FGPdpX+Dc8Qh9vAHJn5B58Ga8x8AMMYpOa3TvzdEmVEKcpxoTHnu
 MLLmvRK0jttZWXRBgkaA3irYPQfnRLZ6GcYL/CMHRdfkorYw/m1RKbBo5/+kTHdV59RaC8Pd8wTOi
 jo7G3URqxr5MEa/A0sGGBefAFTMrljyB2t0TGRiRnHxFeLadzpsnYn1IXU+AOep6iankq8A3pFaMm
 RP63WcgsCe3jtesgABCd8bNh/Yzk6NUjfZAB48atObBn68zJElrVuLfF5/tyY05ixQmv5umrKt3+i
 5yixz6Aw==;
Received: from 171.168.43.195.cust.ip.kpnqwest.it ([195.43.168.171]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9m1V-0003Kk-Dx; Sun, 23 Aug 2020 09:10:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] block: replace bd_set_size with bd_set_nr_sectors
Date: Sun, 23 Aug 2020 11:10:41 +0200
Message-Id: <20200823091043.2600261-2-hch@lst.de>
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
 Stefan Haberland <sth@linux.ibm.com>, nbd@other.debian.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Replace bd_set_size with a version that takes the number of sectors
instead, as that fits most of the current and future callers much better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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
