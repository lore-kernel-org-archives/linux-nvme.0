Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC0EC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=21fX9Gy5zvQsI495qmSlpVuI+exSTES9Ynq5330qoqE=; b=TrDHIR5G6FSGWBXoeyRTs8EpGo
	lZY/mK311fsm8Kp4lFm6BB6ZFiPd1qTaSiN/EZU1rzfsMSm1EYA37QZlcNZ0cH4GQU4IYYWE0K2Op
	dfLCWCCx24IsV+a/Bi5cUhneXewkcODxl+nuVXlZNUt9+hZ69XgcOIMZU1qJ9NdVMi32y9Psv5j9p
	NX45mbjPZfYH3QAuCin14X/kXrn5Vx1SrU45Lf+RvD1o6YaioDGKezrd3SqVfBm2KbDsJqIDMW4Z4
	WObpmSRjUmuM518VXXo5PQVXJI+8XxITMucvQpzp5Of2kQI4zum1SrVjhXmd6L3IHwSG6+taX++1p
	x3Nm3YAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPe-00000005D7c-0CBl;
	Thu, 07 Mar 2024 15:12:02 +0000
Received: from [66.60.99.14] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPd-00000005D7C-0zCe;
	Thu, 07 Mar 2024 15:12:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 01/10] block: remove the discard_granularity check in __blkdev_issue_discard
Date: Thu,  7 Mar 2024 08:11:48 -0700
Message-Id: <20240307151157.466013-2-hch@lst.de>
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

We now set a default granularity in the queue limits API, so don't
bother with this extra check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index dc8e35d0a51d6d..f873eb9a886f63 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -66,13 +66,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	if (!bdev_max_discard_sectors(bdev))
 		return -EOPNOTSUPP;
 
-	/* In case the discard granularity isn't set by buggy device driver */
-	if (WARN_ON_ONCE(!bdev_discard_granularity(bdev))) {
-		pr_err_ratelimited("%pg: Error: discard_granularity is 0.\n",
-				   bdev);
-		return -EOPNOTSUPP;
-	}
-
 	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
-- 
2.39.2


