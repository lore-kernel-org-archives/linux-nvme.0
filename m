Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8537C54E5D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YKaX8ERHDTkcm1Gf7rZWF74jjMOwqQulL6zhqTnYplQ=; b=mnLOj18MCu5ud7V5Uyqzs4uni5
	vsjRoABK1LYi95BHeVBXeg7errhQbN4a8rHHi1/6NVnYk4xBgMrQ+EHLNQkfBKypN21yy2aALgj9L
	ecS2qLw9xTh+O60DXFav+/66xLoGzUyvTQFtEXjxM+A4DKUuHoVTzyCUZNRlJXbCDWyYntn6M4IGw
	fjX7x4zqyYsyCgTuB9nfsEyqsv7DdQnikf834ey4eqLZNDhouJrcBY+d/v54xzOQGgjwNB8ylH7o2
	G1mBzpZCfbHKrd3GkHon9NNOBrRevGaHpP0sgrs7Cqe6tckGEAg6tSJkp6YZXgKYhExvLfPlA3EE8
	eDyj4zLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Qi-00000006DCC-0mle;
	Tue, 12 Mar 2024 14:48:36 +0000
Received: from [50.226.187.238] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Qd-00000006D8j-1sNb;
	Tue, 12 Mar 2024 14:48:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 5/5] block: don't allow fatal signals to interrupt (__)blkdev_issue_discard
Date: Tue, 12 Mar 2024 08:48:26 -0600
Message-Id: <20240312144826.1045212-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312144826.1045212-1-hch@lst.de>
References: <20240312144826.1045212-1-hch@lst.de>
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

File system won't to handle fatal signals themselves and are generally
not prepared for EINTR errors from (__)blkdev_issue_discard.  Remove
the logic from the generic helpers and instead open code the discard
bio submission in the ioctl handler that wants it.

Fixes: 8a08c5fd89b4 ("blk-lib: check for kill signal")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 12 +++---------
 block/ioctl.c   | 24 ++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 8021bc3831d56a..90b75605299b9c 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -65,16 +65,10 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 {
 	struct bio *bio;
 
-	while (!fatal_signal_pending(current)) {
-		bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects, gfp_mask);
-		if (!bio)
-			return 0;
+	while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
+			gfp_mask)))
 		*biop = bio_chain_and_submit(*biop, bio);
-	}
-
-	if (*biop)
-		bio_await_chain(*biop);
-	return -EINTR;
+	return 0;
 }
 EXPORT_SYMBOL(__blkdev_issue_discard);
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 57c8171fda93c5..32bbdba77d6941 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -96,10 +96,12 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
 	sector_t bs_mask = (bdev_logical_block_size(bdev) >> SECTOR_SHIFT) - 1;
+	struct inode *inode = bdev->bd_inode;
 	sector_t sector, nr_sects;
+	struct bio *bio = NULL, *new;
+	struct blk_plug plug;
 	uint64_t range[2];
 	uint64_t start, len;
-	struct inode *inode = bdev->bd_inode;
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -129,7 +131,25 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
 		goto fail;
-	err = blkdev_issue_discard(bdev, sector, nr_sects, GFP_KERNEL);
+	blk_start_plug(&plug);
+	while (!fatal_signal_pending(current)) {
+		new = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
+				GFP_KERNEL);
+		if (!new)
+			break;
+		bio = bio_chain_and_submit(bio, new);
+	}
+	if (fatal_signal_pending(current)) {
+		if (bio)
+			bio_await_chain(bio);
+		err = -EINTR;
+	} else if (bio) {
+		err = submit_bio_wait(bio);
+		if (err == -EOPNOTSUPP)
+			err = 0;
+		bio_put(bio);
+	}
+	blk_finish_plug(&plug);
 fail:
 	filemap_invalidate_unlock(inode->i_mapping);
 	return err;
-- 
2.39.2


