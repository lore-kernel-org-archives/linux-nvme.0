Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA46CC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ve/vSVtU1ouGfANFy/XRVyCgEc2TdovLRI20CqB7Pzs=; b=BU4QT1Qwte2/0xtrc8jRfLwtYK
	QV6/3iOaeFRxMKMOy/gDIHDGcxhj9x5bLAm7bEW+hwfgM62by57kwyV08dfgsVOmja/wKjPMic8LD
	A4UcG/B2NXStJ+lyo6MIgWdRDw2Dkd1JuNtQruv1+PbvPg86xFKhW+X1rc/6Mes8r+oSlptp+y8vg
	p5WmwngTRXovEzKSRcut2427Mwzi47r3RgTr3slmncImNcJyXTnZbVgOa1Z5eCGdss/NS0P1LxruF
	0/BMy3jz6HriSjuE08B0h419XXJeg/lFF4GQJuK+oLjm4LULgC8E6AUZqCD/+MV/lpsAlp+qzoJnE
	2EwjVlDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPx-00000005DMz-1C8R;
	Thu, 07 Mar 2024 15:12:21 +0000
Received: from [66.60.99.14] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPk-00000005DB9-0889;
	Thu, 07 Mar 2024 15:12:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 09/10] dm-thin: switch to using blk_next_discard_bio directly
Date: Thu,  7 Mar 2024 08:11:56 -0700
Message-Id: <20240307151157.466013-10-hch@lst.de>
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
 drivers/md/dm-thin.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 07c7f9795b107b..becf1b66262d34 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -398,10 +398,13 @@ static void begin_discard(struct discard_op *op, struct thin_c *tc, struct bio *
 static int issue_discard(struct discard_op *op, dm_block_t data_b, dm_block_t data_e)
 {
 	struct thin_c *tc = op->tc;
+	struct block_device *bdev = tc->pool_dev->bdev;
 	sector_t s = block_to_sectors(tc->pool, data_b);
 	sector_t len = block_to_sectors(tc->pool, data_e - data_b);
 
-	return __blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op->bio);
+	while (blk_next_discard_bio(bdev, &op->bio, &s, &len, GFP_NOIO))
+		;
+	return 0;
 }
 
 static void end_discard(struct discard_op *op, int r)
-- 
2.39.2


