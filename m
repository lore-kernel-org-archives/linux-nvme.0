Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DC9C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 07:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=59GwLk/57mAU/aV+lYrkyA68Pm/XES/YiUDw0OaPmaE=; b=GUhP8DHSbqUVg5+VT43W/b/+J0
	IOY5QMEQ2HjB9LBr8i3eJ5Xzliy8uG7C4HS0nPDkFeNirmy9QcYIDMu1Jynn5R27h/HXinIvlsO7m
	/dbvROJjT11FGSSNY6rlVorgClnHPohp7aL2jb7SVNz15oCYmMUwpg5dXxqRlAGTp52CQ2fP1Jei4
	a1KWHJc1wS8zsBmRFWiFxaaSvnLwiVWJEZ6nRdN0ChHk8zzDFQdo370Pt83H8IrFeT3p+6DhmjqMc
	hLbuX7zjJ2s0FNhA20QK8rd5hlZeUMUd8fVFkNA6Ri42a5yJ8CpfkSJCBuXTOR5CiYbhqzx+Npm1+
	D/0BQG7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z4o-006urv-Fx; Wed, 06 Jul 2022 07:03:58 +0000
Received: from [2001:4bb8:189:3c4a:f22c:c36a:4e84:c723] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z4l-006upM-J0; Wed, 06 Jul 2022 07:03:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/16] block: remove a superflous ifdef in blkdev.h
Date: Wed,  6 Jul 2022 09:03:35 +0200
Message-Id: <20220706070350.1703384-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706070350.1703384-1-hch@lst.de>
References: <20220706070350.1703384-1-hch@lst.de>
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

It doesn't hurt to always have the blk_zone_cond_str prototype, and the
two inlines can also be defined unconditionally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/blkdev.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b9a94c53c6cd3..270cd0c552924 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -899,8 +899,6 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 	return bdev->bd_queue;	/* this is never NULL */
 }
 
-#ifdef CONFIG_BLK_DEV_ZONED
-
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
 const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
 
@@ -915,7 +913,6 @@ static inline unsigned int bio_zone_is_seq(struct bio *bio)
 	return blk_queue_zone_is_seq(bdev_get_queue(bio->bi_bdev),
 				     bio->bi_iter.bi_sector);
 }
-#endif /* CONFIG_BLK_DEV_ZONED */
 
 /*
  * Return how much of the chunk is left to be used for I/O at a given offset.
-- 
2.30.2


