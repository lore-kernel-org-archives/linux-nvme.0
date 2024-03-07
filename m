Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83EEC54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TW6U45LMqo70ibxXeynwYboB+abUkfYEFYwo0rLd1po=; b=qK+BPllboYea7sMG0g+jRjEG/5
	crrlASOayrRWk71HM3x71vR7vKmlPsJJ66U1PSL83pttfvFG8bw26V6aaeeTfBQPEnmb9v6A9zIV+
	xDzTcADNSIU+EUUSbtMiLf5FJ1EQg8f6Vss55qud2xqxgDRt1d8QbUUVqglO98jSe4EcLuicy4SDE
	x/28BpStRK99GIcwJh1ZBSowRHgSf3BZoKLQdQ2JK1Lcvh01xOdsgeuqeHqHBJta/oMSY9clVzt6u
	4WGnwm8kvWBhyYRHXSxqzPhV4GSS4JWphzUqpVpTTlfwYpRb1xqIODDbJdFXYCFbo6lLZj7bw+9LM
	igfhIWfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPo-00000005DEa-1C2U;
	Thu, 07 Mar 2024 15:12:12 +0000
Received: from [66.60.99.14] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPg-00000005D9H-2yQH;
	Thu, 07 Mar 2024 15:12:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 05/10] f2fs: switch to using blk_next_discard_bio directly
Date: Thu,  7 Mar 2024 08:11:52 -0700
Message-Id: <20240307151157.466013-6-hch@lst.de>
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

This fixes fatal signals getting into the way and corrupting the bio
chain and removes the need to handle synchronous errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/segment.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e1065ba7020761..c131e138d74f94 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1305,10 +1305,12 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		if (time_to_inject(sbi, FAULT_DISCARD)) {
 			err = -EIO;
 		} else {
-			err = __blkdev_issue_discard(bdev,
-					SECTOR_FROM_BLOCK(start),
-					SECTOR_FROM_BLOCK(len),
-					GFP_NOFS, &bio);
+			sector_t sector = SECTOR_FROM_BLOCK(start);
+			sector_t nr_sects = SECTOR_FROM_BLOCK(len);
+
+			while (blk_next_discard_bio(bdev, &bio, &sector,
+					&nr_sects, GFP_NOFS))
+				;
 		}
 		if (err) {
 			spin_lock_irqsave(&dc->lock, flags);
-- 
2.39.2


