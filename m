Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8719C7EE2A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 07:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yxIRWZa8a4c10jlD/hxxOaC/39H/36XgCLysJAxK/Uc=; b=tw7hcYCNSV4iLg+4Rg5vp1Kn5V
	ydBq2hxfVleRe4WqVKGOFcRkGgNu/blnNUTAeDeeCMIi+frQ5R+0F5BtyQX35OcRiM7UvUwVPMNV2
	1nEZ3Nc/QWYoDN+wigjLjLTXGrVsjtCnSfec59zAfhNkK6/S3SQDnisGkakBqllbeessREMPQSGkO
	iYha5LEAqNioz7G++uxmSJyHslo8TyYN4lsCxu71FYlu/jK59XYcKtei04DjoUDZu1kc7lqfyvUu5
	Na/EALAQhFPwCVlOAgrJQBTy7gaHtFUBolqsVca/dU/8+IoW+Hm5nWYq1d8exsuZGHc8R2Ttttudb
	IUcd2Feg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RMG-000coU-1O;
	Tue, 06 Jun 2023 07:44:00 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RJg-000Zye-0A;
	Tue, 06 Jun 2023 07:41:20 +0000
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
	linux-pm@vger.kernel.org
Subject: [PATCH 27/31] block: remove unused fmode_t arguments from ioctl handlers
Date: Tue,  6 Jun 2023 09:39:46 +0200
Message-Id: <20230606073950.225178-28-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
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

A few ioctl handlers have fmode_t arguments that are entirely unused,
remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c |  4 ++--
 block/blk.h       |  6 +++---
 block/ioctl.c     | 14 +++++++-------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 096b6b47561f83..02cc2c629ac9be 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -323,8 +323,8 @@ static int blkdev_copy_zone_to_user(struct blk_zone *zone, unsigned int idx,
  * BLKREPORTZONE ioctl processing.
  * Called from blkdev_ioctl.
  */
-int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
-			      unsigned int cmd, unsigned long arg)
+int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
+		unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	struct zone_report_args args;
diff --git a/block/blk.h b/block/blk.h
index 6910220aa030f1..e28d5d67d31a28 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -394,15 +394,15 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
 #ifdef CONFIG_BLK_DEV_ZONED
 void disk_free_zone_bitmaps(struct gendisk *disk);
 void disk_clear_zone_settings(struct gendisk *disk);
-int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg);
+int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
+		unsigned long arg);
 int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline void disk_free_zone_bitmaps(struct gendisk *disk) {}
 static inline void disk_clear_zone_settings(struct gendisk *disk) {}
 static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
-		fmode_t mode, unsigned int cmd, unsigned long arg)
+		unsigned int cmd, unsigned long arg)
 {
 	return -ENOTTY;
 }
diff --git a/block/ioctl.c b/block/ioctl.c
index b39bd5b41ee492..3a10c34b8ef6d3 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -344,8 +344,8 @@ static int blkdev_pr_clear(struct block_device *bdev,
 	return ops->pr_clear(bdev, c.key);
 }
 
-static int blkdev_flushbuf(struct block_device *bdev, fmode_t mode,
-		unsigned cmd, unsigned long arg)
+static int blkdev_flushbuf(struct block_device *bdev, unsigned cmd,
+		unsigned long arg)
 {
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -354,8 +354,8 @@ static int blkdev_flushbuf(struct block_device *bdev, fmode_t mode,
 	return 0;
 }
 
-static int blkdev_roset(struct block_device *bdev, fmode_t mode,
-		unsigned cmd, unsigned long arg)
+static int blkdev_roset(struct block_device *bdev, unsigned cmd,
+		unsigned long arg)
 {
 	int ret, n;
 
@@ -475,9 +475,9 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch (cmd) {
 	case BLKFLSBUF:
-		return blkdev_flushbuf(bdev, mode, cmd, arg);
+		return blkdev_flushbuf(bdev, cmd, arg);
 	case BLKROSET:
-		return blkdev_roset(bdev, mode, cmd, arg);
+		return blkdev_roset(bdev, cmd, arg);
 	case BLKDISCARD:
 		return blk_ioctl_discard(bdev, mode, arg);
 	case BLKSECDISCARD:
@@ -487,7 +487,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKGETDISKSEQ:
 		return put_u64(argp, bdev->bd_disk->diskseq);
 	case BLKREPORTZONE:
-		return blkdev_report_zones_ioctl(bdev, mode, cmd, arg);
+		return blkdev_report_zones_ioctl(bdev, cmd, arg);
 	case BLKRESETZONE:
 	case BLKOPENZONE:
 	case BLKCLOSEZONE:
-- 
2.39.2


