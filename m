Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21F7C54E5D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Naseq0Wthv0thDdBSJ3JbI1Kt4lTFJ0xfpQrsvbeLw=; b=V4h7YvBzdklZUswTm3S+NPCL9M
	pfm1TPW4XEUVWFfjL+kLAI4Q2311cwgQCBe+DyzX/4tGD4OWsGuTbuJ/ld5sEQQz+voZ5qcbs2RNQ
	G44EVeTJYz+whL8iZLMNAABrUxkz1axaPmgrwClOBRyvcKqaA7EFS6+JhgVI0fe9dbEzeGyPgEL8n
	DlFVzO2w3my9haGW0vn0V7C90zWjKjHYMJR4juK6j6okxQvxc8oGaXQNP2+wdxfnBDZLhcyChJxKH
	h1Oi3wV61JHRw2A+aV1GDoGY55RkqOM1NuSPCSCrY4xI59gaP2TvssbvAZvT1dOqYtdd+R3DLVZcb
	GYPtj77Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Qf-00000006DA0-16LL;
	Tue, 12 Mar 2024 14:48:33 +0000
Received: from [50.226.187.238] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Qb-00000006D7b-2DRa;
	Tue, 12 Mar 2024 14:48:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 3/5] block: add a blk_alloc_discard_bio helper
Date: Tue, 12 Mar 2024 08:48:24 -0600
Message-Id: <20240312144826.1045212-4-hch@lst.de>
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

Factor out a helper from __blkdev_issue_discard that chews off as much as
possible from a discard range and allocates a bio for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c     | 58 ++++++++++++++++++++++++++-------------------
 include/linux/bio.h |  3 +++
 2 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 50923508a32466..fd97f4dd34e7f4 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -55,36 +55,46 @@ static void await_bio_chain(struct bio *bio)
 	blk_wait_io(&done);
 }
 
+struct bio *blk_alloc_discard_bio(struct block_device *bdev,
+		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask)
+{
+	sector_t bio_sects = min(*nr_sects, bio_discard_limit(bdev, *sector));
+	struct bio *bio;
+
+	if (WARN_ON_ONCE(!(gfp_mask & __GFP_RECLAIM)))
+		return NULL;
+	if (!bio_sects)
+		return NULL;
+
+	bio = bio_alloc(bdev, 0, REQ_OP_DISCARD, gfp_mask);
+	bio->bi_iter.bi_sector = *sector;
+	bio->bi_iter.bi_size = bio_sects << SECTOR_SHIFT;
+	*sector += bio_sects;
+	*nr_sects -= bio_sects;
+	/*
+	 * We can loop for a long time in here if someone does full device
+	 * discards (like mkfs).  Be nice and allow us to schedule out to avoid
+	 * softlocking if preempt is disabled.
+	 */
+	cond_resched();
+	return bio;
+}
+
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
 {
-	struct bio *bio = *biop;
-
-	while (nr_sects) {
-		sector_t req_sects =
-			min(nr_sects, bio_discard_limit(bdev, sector));
+	struct bio *bio;
 
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
-		if (fatal_signal_pending(current)) {
-			await_bio_chain(bio);
-			return -EINTR;
-		}
+	while (!fatal_signal_pending(current)) {
+		bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects, gfp_mask);
+		if (!bio)
+			return 0;
+		*biop = bio_chain_and_submit(*biop, bio);
 	}
 
-	*biop = bio;
-	return 0;
+	if (*biop)
+		await_bio_chain(*biop);
+	return -EINTR;
 }
 EXPORT_SYMBOL(__blkdev_issue_discard);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 643d61b7cb82f7..74138c815657fd 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -826,4 +826,7 @@ struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp);
 struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new);
 
+struct bio *blk_alloc_discard_bio(struct block_device *bdev,
+		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask);
+
 #endif /* __LINUX_BIO_H */
-- 
2.39.2


