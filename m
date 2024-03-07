Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620DFC54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pIAa/RpvHRZ8f5i+wX7BbspmDNldfs7/UxcWBp02Rkc=; b=PHEsQzI/8OFe0tN4gweQ6u5ia5
	R/ZS/3zPjz9489grOpABfanTqnretYbuER46aH/EJ+5cfZYm22Sk9rCuTSCiEd6Fesoh1iXXYkURN
	ICWBfwqc+9JRpQasVHzz2eZSH++hkURTGbLaTFh7nYQifcPVOFLq4PnR4lgYhDTdyi2Dlg+coVpMb
	WK0yvxsF2RZz6t9jSPHgBk9FdY8j0ce5Od2rfMu5Ul1BjUAYA12uTOcJP1UI2UFbmAu13ZgytlECQ
	LLFUlzWje97BZBXeP/uohocR5CgI2qAeiZNEAbA7NOsFzgIs45Hrcv+roAuWIX093FIYSgNsmZVUW
	tAnPijcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPj-00000005DAz-2YAy;
	Thu, 07 Mar 2024 15:12:07 +0000
Received: from [66.60.99.14] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPe-00000005D89-3Qh7;
	Thu, 07 Mar 2024 15:12:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 03/10] block: add a blk_next_discard_bio helper
Date: Thu,  7 Mar 2024 08:11:50 -0700
Message-Id: <20240307151157.466013-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307151157.466013-1-hch@lst.de>
References: <20240307151157.466013-1-hch@lst.de>
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

This factors the guts of __blkdev_issue_discard into a helper that can
be used by callers avoid the fatal_signal_pending check and to generally
simplify the bio handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c        | 41 ++++++++++++++++++++++++-----------------
 include/linux/blkdev.h |  2 ++
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 50923508a32466..4f2d52210b129c 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -55,28 +55,35 @@ static void await_bio_chain(struct bio *bio)
 	blk_wait_io(&done);
 }
 
+bool blk_next_discard_bio(struct block_device *bdev, struct bio **biop,
+		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask)
+{
+	sector_t bio_sects = min(*nr_sects, bio_discard_limit(bdev, *sector));
+
+	if (!bio_sects)
+		return false;
+
+	*biop = blk_next_bio(*biop, bdev, 0, REQ_OP_DISCARD, gfp_mask);
+	(*biop)->bi_iter.bi_sector = *sector;
+	(*biop)->bi_iter.bi_size = bio_sects << SECTOR_SHIFT;
+	*sector += bio_sects;
+	*nr_sects -= bio_sects;
+	/*
+	 * We can loop for a long time in here if someone does full device
+	 * discards (like mkfs).  Be nice and allow us to schedule out to avoid
+	 * softlocking if preempt is disabled.
+	 */
+	cond_resched();
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_next_discard_bio);
+
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
 {
 	struct bio *bio = *biop;
 
-	while (nr_sects) {
-		sector_t req_sects =
-			min(nr_sects, bio_discard_limit(bdev, sector));
-
-		bio = blk_next_bio(bio, bdev, 0, REQ_OP_DISCARD, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio->bi_iter.bi_size = req_sects << 9;
-		sector += req_sects;
-		nr_sects -= req_sects;
-
-		/*
-		 * We can loop for a long time in here, if someone does
-		 * full device discards (like mkfs). Be nice and allow
-		 * us to schedule out to avoid softlocking if preempt
-		 * is disabled.
-		 */
-		cond_resched();
+	while (blk_next_discard_bio(bdev, &bio, &sector, &nr_sects, gfp_mask)) {
 		if (fatal_signal_pending(current)) {
 			await_bio_chain(bio);
 			return -EINTR;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a9a0bd6cac4aff..b87cd889008291 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1059,6 +1059,8 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask);
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
+bool blk_next_discard_bio(struct block_device *bdev, struct bio **biop,
+		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
 
-- 
2.39.2


