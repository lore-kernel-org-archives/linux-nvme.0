Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E456CC5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:12:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891C9204FD
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qFTncF/B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uzx32xbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891C9204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wy1lJpK2KkRPJOO3gCdQmt5OpgJYZ2pYGxnNZwIrths=; b=qFTncF/Bj4KSM77AYDfulDvcB
	kV6Irh6IlP9y4R1gk0vX4zcCR2TvKtDC48C2+ahGUjEhVIwfC/1k7W8mHFNKfheu+4mS4GHOQI1g6
	HjQusdPyEHIQVKMfpEEBN5aaQbHCcVjWqk4FK7qQ/5L1BHLzMB++iFbho7QbgdLEtRfyOEvAtP4LT
	p2T4lpGvTTlmz3E3rFFEKmlEMZkRjnvYv32o0OAXWehhTaClaiKwAkYIBG4SpKBwPLTinZDW7rVN1
	bcqrTGjgX8WRKEGxltsoP4ObEzdSSP8FqRU1AFw64qMpD1vh/pQ5ZIXrnAGki66MJTOXFfC245+c2
	KC6WQzqEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kegBZ-0003AN-Oh; Mon, 16 Nov 2020 15:12:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyv-00045V-2j
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=GDdahn/aHFPgbq/Tch1XnIWDhbuP0LNShW0kbWCU2DI=; b=uzx32xbEXDeOyc3BQeMYzcMEP+
 VpcFJj/mppjMWyEpC2f1TAGdERyyKZRFPMS6LQb/FLhD/jkr9TUTULDzsay+mncANq4u7ucvLomnp
 Kww7QziQHj9SrxdP5uPA+fxQzCqelMZmiy+dj6oy7m0yAUJH/x3Enl5GkdSBQ3vLRg56BDDTvBg5b
 /6VF20e7eXN/eur5CKoLa0f/4Y9uesPi5j923mPMuLXs+nJmuwvB4GqU9KGScPD2A37u2GF4wHIxT
 bXUovXGeQ3icRQ7sRczYatscyuMTybV1WBblJX+wktL3ld8Vx/0lixyLEk8QqnbHMtclj/KTJswjw
 cojmMX0g==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyt-0004FO-7Z; Mon, 16 Nov 2020 14:59:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 67/78] block: simplify the block device claiming interface
Date: Mon, 16 Nov 2020 15:57:58 +0100
Message-Id: <20201116145809.410558-68-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
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
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Stop passing the whole device as a separate argument given that it
can be trivially deducted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c   | 12 +++-----
 fs/block_dev.c         | 69 +++++++++++++++++++-----------------------
 include/linux/blkdev.h |  6 ++--
 3 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b42c728620c9e4..599e94a7e69259 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1071,7 +1071,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	struct file	*file;
 	struct inode	*inode;
 	struct address_space *mapping;
-	struct block_device *claimed_bdev = NULL;
 	int		error;
 	loff_t		size;
 	bool		partscan;
@@ -1090,8 +1089,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bdev->bd_contains;
-		error = bd_prepare_to_claim(bdev, claimed_bdev, loop_configure);
+		error = bd_prepare_to_claim(bdev, loop_configure);
 		if (error)
 			goto out_putf;
 	}
@@ -1178,15 +1176,15 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
-	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
+	if (!(mode & FMODE_EXCL))
+		bd_abort_claiming(bdev, loop_configure);
 	return 0;
 
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 out_bdev:
-	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
+	if (!(mode & FMODE_EXCL))
+		bd_abort_claiming(bdev, loop_configure);
 out_putf:
 	fput(file);
 out:
diff --git a/fs/block_dev.c b/fs/block_dev.c
index f36788d7699302..fd4df132a97590 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -110,24 +110,20 @@ EXPORT_SYMBOL(invalidate_bdev);
 int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
 			loff_t lstart, loff_t lend)
 {
-	struct block_device *claimed_bdev = NULL;
-	int err;
-
 	/*
 	 * If we don't hold exclusive handle for the device, upgrade to it
 	 * while we discard the buffer cache to avoid discarding buffers
 	 * under live filesystem.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bdev->bd_contains;
-		err = bd_prepare_to_claim(bdev, claimed_bdev,
-					  truncate_bdev_range);
+		int err = bd_prepare_to_claim(bdev, truncate_bdev_range);
 		if (err)
 			return err;
 	}
+
 	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
-	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, truncate_bdev_range);
+	if (!(mode & FMODE_EXCL))
+		bd_abort_claiming(bdev, truncate_bdev_range);
 	return 0;
 }
 EXPORT_SYMBOL(truncate_bdev_range);
@@ -1055,7 +1051,6 @@ static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
 /**
  * bd_prepare_to_claim - claim a block device
  * @bdev: block device of interest
- * @whole: the whole device containing @bdev, may equal @bdev
  * @holder: holder trying to claim @bdev
  *
  * Claim @bdev.  This function fails if @bdev is already claimed by another
@@ -1065,9 +1060,10 @@ static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
  * RETURNS:
  * 0 if @bdev can be claimed, -EBUSY otherwise.
  */
-int bd_prepare_to_claim(struct block_device *bdev, struct block_device *whole,
-		void *holder)
+int bd_prepare_to_claim(struct block_device *bdev, void *holder)
 {
+	struct block_device *whole = bdev->bd_contains;
+
 retry:
 	spin_lock(&bdev_lock);
 	/* if someone else claimed, fail */
@@ -1107,15 +1103,15 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
 /**
  * bd_finish_claiming - finish claiming of a block device
  * @bdev: block device of interest
- * @whole: whole block device
  * @holder: holder that has claimed @bdev
  *
  * Finish exclusive open of a block device. Mark the device as exlusively
  * open by the holder and wake up all waiters for exclusive open to finish.
  */
-static void bd_finish_claiming(struct block_device *bdev,
-		struct block_device *whole, void *holder)
+static void bd_finish_claiming(struct block_device *bdev, void *holder)
 {
+	struct block_device *whole = bdev->bd_contains;
+
 	spin_lock(&bdev_lock);
 	BUG_ON(!bd_may_claim(bdev, whole, holder));
 	/*
@@ -1140,11 +1136,10 @@ static void bd_finish_claiming(struct block_device *bdev,
  * also used when exclusive open is not actually desired and we just needed
  * to block other exclusive openers for a while.
  */
-void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
-		       void *holder)
+void bd_abort_claiming(struct block_device *bdev, void *holder)
 {
 	spin_lock(&bdev_lock);
-	bd_clear_claiming(whole, holder);
+	bd_clear_claiming(bdev->bd_contains, holder);
 	spin_unlock(&bdev_lock);
 }
 EXPORT_SYMBOL(bd_abort_claiming);
@@ -1439,7 +1434,7 @@ static int bdev_get_gendisk(struct gendisk *disk)
 static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		int for_part)
 {
-	struct block_device *whole = NULL, *claiming = NULL;
+	struct block_device *whole = NULL;
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 	bool first_open = false, unblock_events = true, need_restart;
@@ -1460,11 +1455,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 
 	if (!for_part && (mode & FMODE_EXCL)) {
 		WARN_ON_ONCE(!holder);
-		if (whole)
-			claiming = whole;
-		else
-			claiming = bdev;
-		ret = bd_prepare_to_claim(bdev, claiming, holder);
+		ret = bd_prepare_to_claim(bdev, holder);
 		if (ret)
 			goto out_put_whole;
 	}
@@ -1541,21 +1532,23 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		}
 	}
 	bdev->bd_openers++;
-	if (for_part)
+	if (for_part) {
 		bdev->bd_part_count++;
-	if (claiming)
-		bd_finish_claiming(bdev, claiming, holder);
+	} else if (mode & FMODE_EXCL) {
+		bd_finish_claiming(bdev, holder);
 
-	/*
-	 * Block event polling for write claims if requested.  Any write holder
-	 * makes the write_holder state stick until all are released.  This is
-	 * good enough and tracking individual writeable reference is too
-	 * fragile given the way @mode is used in blkdev_get/put().
-	 */
-	if (claiming && (mode & FMODE_WRITE) && !bdev->bd_write_holder &&
-	    (disk->flags & GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE)) {
-		bdev->bd_write_holder = true;
-		unblock_events = false;
+		/*
+		 * Block event polling for write claims if requested.  Any write
+		 * holder makes the write_holder state stick until all are
+		 * released.  This is good enough and tracking individual
+		 * writeable reference is too fragile given the way @mode is
+		 * used in blkdev_get/put().
+		 */
+		if ((mode & FMODE_WRITE) && !bdev->bd_write_holder &&
+		    (disk->flags & GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE)) {
+			bdev->bd_write_holder = true;
+			unblock_events = false;
+		}
 	}
 	mutex_unlock(&bdev->bd_mutex);
 
@@ -1576,8 +1569,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		__blkdev_put(bdev->bd_contains, mode, 1);
 	bdev->bd_contains = NULL;
  out_unlock_bdev:
-	if (claiming)
-		bd_abort_claiming(bdev, claiming, holder);
+	if (!for_part && (mode & FMODE_EXCL))
+		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
  out_put_whole:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 044d9dd159d882..696b2f9c5529d8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1988,10 +1988,8 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
 struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 		void *holder);
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder);
-int bd_prepare_to_claim(struct block_device *bdev, struct block_device *whole,
-		void *holder);
-void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
-		void *holder);
+int bd_prepare_to_claim(struct block_device *bdev, void *holder);
+void bd_abort_claiming(struct block_device *bdev, void *holder);
 void blkdev_put(struct block_device *bdev, fmode_t mode);
 
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
