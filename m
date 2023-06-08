Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBC4C7EE29
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jun 2023 11:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5LAvcRPWNtme+VneyJJGFak9XRRAUZ1PtAJwwpA666I=; b=CbTbQV7GMjdtRULA55Hfuy/1+k
	neMRCcOYJozcDB4XXU0+BTGCq0nCZl+Pr4UVlstufitE9qFRHQWB0gdGyNizbALnbQ7lyui+XwbQM
	jftAvPrqBaFJw1m2sPE53JLbyE49B9qHRxwypH2knq4g3gXV6y7XsEoEy+ZebktsmwowKAxRw8NUV
	Rfj+LfeS9IHEik5mBK5NI7DrawXbor6lrVu9Stf7Vl64V5T2PaVuPO2f+S+KzBdmepZF1G0Z4ouij
	v6dQyRdm6ow6P4PSFxNM4bGWNzN0v3OeTFSCJ4U9rU560OvMvIujl01Vfbfzlim7KmDWYZKijCZdA
	Zz1gMIKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DT4-0094vL-3B;
	Thu, 08 Jun 2023 11:06:15 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DR7-0092nK-2n;
	Thu, 08 Jun 2023 11:04:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>,
	Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 25/30] block: move a few internal definitions out of blkdev.h
Date: Thu,  8 Jun 2023 13:02:53 +0200
Message-Id: <20230608110258.189493-26-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

All these helpers are only used in core block code, so move them out of
the public header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 block/blk.h            | 23 +++++++++++++++++++++--
 include/linux/blkdev.h | 27 ---------------------------
 2 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 9582fcd0df4123..6910220aa030f1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -394,10 +394,27 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
 #ifdef CONFIG_BLK_DEV_ZONED
 void disk_free_zone_bitmaps(struct gendisk *disk);
 void disk_clear_zone_settings(struct gendisk *disk);
-#else
+int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg);
+int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg);
+#else /* CONFIG_BLK_DEV_ZONED */
 static inline void disk_free_zone_bitmaps(struct gendisk *disk) {}
 static inline void disk_clear_zone_settings(struct gendisk *disk) {}
-#endif
+static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
+		fmode_t mode, unsigned int cmd, unsigned long arg)
+{
+	return -ENOTTY;
+}
+static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
+		fmode_t mode, unsigned int cmd, unsigned long arg)
+{
+	return -ENOTTY;
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
+struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
+void bdev_add(struct block_device *bdev, dev_t dev);
 
 int blk_alloc_ext_minor(void);
 void blk_free_ext_minor(unsigned int minor);
@@ -449,6 +466,8 @@ extern struct device_attribute dev_attr_events_poll_msecs;
 
 extern struct attribute_group blk_trace_attr_group;
 
+int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
+		loff_t lend);
 long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 97803603902076..6b65623e447c02 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -318,7 +318,6 @@ typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-
 #define BLK_ALL_ZONES  ((unsigned int)-1)
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
@@ -328,33 +327,11 @@ extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 			    gfp_t gfp_mask);
 int blk_revalidate_disk_zones(struct gendisk *disk,
 			      void (*update_driver_data)(struct gendisk *disk));
-
-extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
-				     unsigned int cmd, unsigned long arg);
-extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
-				  unsigned int cmd, unsigned long arg);
-
 #else /* CONFIG_BLK_DEV_ZONED */
-
 static inline unsigned int bdev_nr_zones(struct block_device *bdev)
 {
 	return 0;
 }
-
-static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
-					    fmode_t mode, unsigned int cmd,
-					    unsigned long arg)
-{
-	return -ENOTTY;
-}
-
-static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
-					 fmode_t mode, unsigned int cmd,
-					 unsigned long arg)
-{
-	return -ENOTTY;
-}
-
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 /*
@@ -1493,11 +1470,7 @@ void blkdev_put(struct block_device *bdev, void *holder);
 struct block_device *blkdev_get_no_open(dev_t dev);
 void blkdev_put_no_open(struct block_device *bdev);
 
-struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
-void bdev_add(struct block_device *bdev, dev_t dev);
 struct block_device *I_BDEV(struct inode *inode);
-int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
-		loff_t lend);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
-- 
2.39.2


