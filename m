Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF5CC54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jU4QlnWtPYtUMHg2kw7ZYLYWKsDbWmqawf6KHDiM9lA=; b=ZdYsEpLVCke9l22H3pWAS1+7o4
	sGii3X6Eah/AHCfmgOyCRm/zkxzbUriG/iAi/3EMCDErj04JgS6+dseJyho+9sAMmH7bqwXl56kSh
	rq2XQW5vjxbHtHXxdjO+K1JJQgj0ikcGK0A5pJj+V9Y4RscFMzKm/k4XsbAjfoZRoK0/iiYnlExbj
	eXvfJ/KIdypdbQl6oCLEzdoh7bZwSuo6BL6q3UbuCMPgln4vJ1hE9IFCpBxn8kQZDU6qCd0m+4YBz
	1WJbmpJa55pdfpIOjmWmfN46X1sl/tPWCMvi/pMeeNVEReFIpal/ozG516yHm4qonW86SdaEnDMC0
	Getc4ZMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPy-00000005DO9-2b5U;
	Thu, 07 Mar 2024 15:12:22 +0000
Received: from [66.60.99.14] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPk-00000005DBr-3wFH;
	Thu, 07 Mar 2024 15:12:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 10/10] block: remove __blkdev_issue_discard
Date: Thu,  7 Mar 2024 08:11:57 -0700
Message-Id: <20240307151157.466013-11-hch@lst.de>
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

Fold what is left of __blkdev_issue_discard into blkdev_issue_discard and
simplify the error handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c        | 29 +++++++++--------------------
 include/linux/blkdev.h |  2 --
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4f2d52210b129c..39e6e21eb2982d 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -78,23 +78,6 @@ bool blk_next_discard_bio(struct block_device *bdev, struct bio **biop,
 }
 EXPORT_SYMBOL_GPL(blk_next_discard_bio);
 
-int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
-{
-	struct bio *bio = *biop;
-
-	while (blk_next_discard_bio(bdev, &bio, &sector, &nr_sects, gfp_mask)) {
-		if (fatal_signal_pending(current)) {
-			await_bio_chain(bio);
-			return -EINTR;
-		}
-	}
-
-	*biop = bio;
-	return 0;
-}
-EXPORT_SYMBOL(__blkdev_issue_discard);
-
 /**
  * blkdev_issue_discard - queue a discard
  * @bdev:	blockdev to issue discard for
@@ -113,16 +96,22 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	int ret;
 
 	blk_start_plug(&plug);
-	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
-	if (!ret && bio) {
+	while (blk_next_discard_bio(bdev, &bio, &sector, &nr_sects, gfp_mask))
+		if (fatal_signal_pending(current))
+			goto fatal_signal;
+	if (bio) {
 		ret = submit_bio_wait(bio);
 		if (ret == -EOPNOTSUPP)
 			ret = 0;
 		bio_put(bio);
 	}
 	blk_finish_plug(&plug);
-
 	return ret;
+
+fatal_signal:
+	blk_finish_plug(&plug);
+	await_bio_chain(bio);
+	return -EINTR;
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b87cd889008291..a1e638fb90fa77 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1057,8 +1057,6 @@ extern void blk_io_schedule(void);
 
 int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask);
-int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 bool blk_next_discard_bio(struct block_device *bdev, struct bio **biop,
 		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
-- 
2.39.2


