Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04081E77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 06:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hYIGKa+u5CrjKCsU5VLCjtxrIvuPUmQYVIa7wbWXX1Y=; b=rMVRo4l+G/wU23E+qNI4+oobek
	v503I3FL7ByvRi2DoLXwvq2vsGIVNCTcxz9mRCp8MK5LTLxWxcp2Oa12FmSkSBMDWVMcoOETAbkOu
	JV92OUjLzm5VhJX4oPt+INtUNHax66dVxSaEPCqBw9NtcGX5GF8kODHq3ERGUUl1XmCVa0tZNH+dT
	wektG3nJSGgnV05QEuvt2kSjKmaqmjMWq1CwTY+x5ylasop6hUfJwR+CSCW7WOMLUahw8XaoLOfw/
	A8rp06kFNQjBzkYnK5BNzqrmU0i2gBqjQUmihCTefIZxgiO2oqtThJFBaKjTDFXfjNBenleCQWdA2
	FtU/FzoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVlaQ-0000000ArpM-3r4y;
	Thu, 09 Jan 2025 06:00:06 +0000
Received: from 2a02-8389-2341-5b80-ddeb-cdec-70b9-e2f0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ddeb:cdec:70b9:e2f0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVlZC-0000000Arc0-3b8P;
	Thu, 09 Jan 2025 05:58:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nbd@other.debian.org,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 10/11] loop: refactor queue limits updates
Date: Thu,  9 Jan 2025 06:57:31 +0100
Message-ID: <20250109055810.1402918-11-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250109055810.1402918-1-hch@lst.de>
References: <20250109055810.1402918-1-hch@lst.de>
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

Replace loop_reconfigure_limits with a slightly less encompassing
loop_update_limits that expects the aller to acquire and commit the
queue limits to prepare for sorting out the freeze vs limits lock
ordering.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/loop.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 836a53eef4b4..560d6d5879d6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -977,12 +977,12 @@ static unsigned int loop_default_blocksize(struct loop_device *lo,
 	return SECTOR_SIZE;
 }
 
-static int loop_reconfigure_limits(struct loop_device *lo, unsigned int bsize)
+static void loop_update_limits(struct loop_device *lo, struct queue_limits *lim,
+		unsigned int bsize)
 {
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct block_device *backing_bdev = NULL;
-	struct queue_limits lim;
 	u32 granularity = 0, max_discard_sectors = 0;
 
 	if (S_ISBLK(inode->i_mode))
@@ -995,22 +995,20 @@ static int loop_reconfigure_limits(struct loop_device *lo, unsigned int bsize)
 
 	loop_get_discard_config(lo, &granularity, &max_discard_sectors);
 
-	lim = queue_limits_start_update(lo->lo_queue);
-	lim.logical_block_size = bsize;
-	lim.physical_block_size = bsize;
-	lim.io_min = bsize;
-	lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_ROTATIONAL);
+	lim->logical_block_size = bsize;
+	lim->physical_block_size = bsize;
+	lim->io_min = bsize;
+	lim->features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_ROTATIONAL);
 	if (file->f_op->fsync && !(lo->lo_flags & LO_FLAGS_READ_ONLY))
-		lim.features |= BLK_FEAT_WRITE_CACHE;
+		lim->features |= BLK_FEAT_WRITE_CACHE;
 	if (backing_bdev && !bdev_nonrot(backing_bdev))
-		lim.features |= BLK_FEAT_ROTATIONAL;
-	lim.max_hw_discard_sectors = max_discard_sectors;
-	lim.max_write_zeroes_sectors = max_discard_sectors;
+		lim->features |= BLK_FEAT_ROTATIONAL;
+	lim->max_hw_discard_sectors = max_discard_sectors;
+	lim->max_write_zeroes_sectors = max_discard_sectors;
 	if (max_discard_sectors)
-		lim.discard_granularity = granularity;
+		lim->discard_granularity = granularity;
 	else
-		lim.discard_granularity = 0;
-	return queue_limits_commit_update(lo->lo_queue, &lim);
+		lim->discard_granularity = 0;
 }
 
 static int loop_configure(struct loop_device *lo, blk_mode_t mode,
@@ -1019,6 +1017,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 {
 	struct file *file = fget(config->fd);
 	struct address_space *mapping;
+	struct queue_limits lim;
 	int error;
 	loff_t size;
 	bool partscan;
@@ -1090,7 +1089,9 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
-	error = loop_reconfigure_limits(lo, config->block_size);
+	lim = queue_limits_start_update(lo->lo_queue);
+	loop_update_limits(lo, &lim, config->block_size);
+	error = queue_limits_commit_update(lo->lo_queue, &lim);
 	if (error)
 		goto out_unlock;
 
@@ -1458,6 +1459,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 
 static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
+	struct queue_limits lim;
 	int err = 0;
 
 	if (lo->lo_state != Lo_bound)
@@ -1470,7 +1472,9 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	invalidate_bdev(lo->lo_device);
 
 	blk_mq_freeze_queue(lo->lo_queue);
-	err = loop_reconfigure_limits(lo, arg);
+	lim = queue_limits_start_update(lo->lo_queue);
+	loop_update_limits(lo, &lim, arg);
+	err = queue_limits_commit_update(lo->lo_queue, &lim);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-- 
2.45.2


