Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E19C54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vSsMfJD3f2N5FqYGaSXx227O7Ol0Kb1Bq+IO61l8gLU=; b=AgTvaarL1xcXaEvFiTsdvTZ8BX
	7qIWRvVpjWZxAik+SEZCpd98hDU8Jlpzxmo+3v2cyR+QHkdFHhTXNiyyV3rAGZY1wAnRMF2dC48C2
	M31AvEcTOl1UZNW7+77rajWGrijP2PrstUimrAO67YtdabnqFyR/OnrZDJCSlQlBHcWEtTr3Yza/t
	FYF9A6a0D/pdUJn3G+2Ha/x7P3SbeCAJo95uzRUH3GBNtclHwaqCwy1AJk8TK952NkMPE6fJFzZUN
	8lcG97XF6EGN5zPiT5I1lpkv5n5ZQ1IZLir9nQ5y5LrhFJe4ZZzvvSzR8wjVbbdrn0HYa521nOcj4
	lEHgtdLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Qc-00000006D81-0v3a;
	Tue, 12 Mar 2024 14:48:30 +0000
Received: from [50.226.187.238] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Qa-00000006D6j-0e89;
	Tue, 12 Mar 2024 14:48:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 1/5] block: move discard checks into the ioctl handler
Date: Tue, 12 Mar 2024 08:48:22 -0600
Message-Id: <20240312144826.1045212-2-hch@lst.de>
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

Most bio operations get basic sanity checking in submit_bio and anything
more complicated than that is done in the callers.  Discards are a bit
different from that in that a lot of checking is done in
__blkdev_issue_discard, and the specific errnos for that are returned
to userspace.  Move the checks that require specific errnos to the ioctl
handler instead and replace the existing kernel sector alignment check
with the actual alignment check based on the logical block size. This
leaves jut the basic sanity checking in submit_bio for the other
submitters of discards and introduces two changes in behavior:

 1) the logical block size alignment check of the start and len is lost
    for non-ioctl callers.
    This matches what is done for other operations including reads and
    writes.  We should probably verify this for all bios, but for now
    make discards match the normal flow.
 2) for non-ioctl callers all errors are reported on I/O completion now
    instead of synchronously.  Callers in general mostly ignore or log
    errors so this will actually simplify the code once cleaned up

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 20 --------------------
 block/ioctl.c   | 13 +++++++++----
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index dc8e35d0a51d6d..50923508a32466 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -59,26 +59,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
 {
 	struct bio *bio = *biop;
-	sector_t bs_mask;
-
-	if (bdev_read_only(bdev))
-		return -EPERM;
-	if (!bdev_max_discard_sectors(bdev))
-		return -EOPNOTSUPP;
-
-	/* In case the discard granularity isn't set by buggy device driver */
-	if (WARN_ON_ONCE(!bdev_discard_granularity(bdev))) {
-		pr_err_ratelimited("%pg: Error: discard_granularity is 0.\n",
-				   bdev);
-		return -EOPNOTSUPP;
-	}
-
-	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
-	if ((sector | nr_sects) & bs_mask)
-		return -EINVAL;
-
-	if (!nr_sects)
-		return -EINVAL;
 
 	while (nr_sects) {
 		sector_t req_sects =
diff --git a/block/ioctl.c b/block/ioctl.c
index 0c76137adcaaa5..57c8171fda93c5 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -95,6 +95,8 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
 static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
+	sector_t bs_mask = (bdev_logical_block_size(bdev) >> SECTOR_SHIFT) - 1;
+	sector_t sector, nr_sects;
 	uint64_t range[2];
 	uint64_t start, len;
 	struct inode *inode = bdev->bd_inode;
@@ -105,18 +107,21 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 
 	if (!bdev_max_discard_sectors(bdev))
 		return -EOPNOTSUPP;
+	if (bdev_read_only(bdev))
+		return -EPERM;
 
 	if (copy_from_user(range, (void __user *)arg, sizeof(range)))
 		return -EFAULT;
 
 	start = range[0];
 	len = range[1];
+	sector = start >> SECTOR_SHIFT;
+	nr_sects = len >> SECTOR_SHIFT;
 
-	if (start & 511)
+	if (!nr_sects)
 		return -EINVAL;
-	if (len & 511)
+	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
-
 	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
@@ -124,7 +129,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
 		goto fail;
-	err = blkdev_issue_discard(bdev, start >> 9, len >> 9, GFP_KERNEL);
+	err = blkdev_issue_discard(bdev, sector, nr_sects, GFP_KERNEL);
 fail:
 	filemap_invalidate_unlock(inode->i_mapping);
 	return err;
-- 
2.39.2


