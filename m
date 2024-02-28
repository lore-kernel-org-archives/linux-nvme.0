Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DCDC47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BgRNaIwjHujMzOoPtisXH78aw/jURoq8krZi1GdG5lY=; b=1lv/NAk/gglXOpRJpklP8mBji3
	7ouVSvWq+dYvq33Trxsc6SXwDWCsykHuUY0U1pU4+w/HtdhDmy9wa67lcz8UqW9WqA93+6Gukgl2c
	MzObik6B2YOJ63I8O+HA8XJPA1ILWCPDq9twohZZQAQIx+WKcvpdvBepQNmwMIg4OfbhohHw3mt+r
	+r8jrVILcQhZO5c74QT/hT4koOpWGbrX4xl0TehKPsf76o0lnSgbJCn+ur6BXCuX/Ii02rM1oj2DR
	NI/vOn5hG4u3xm+rVVESvxcvHt9xY/f5izAwvaf0GVxRw4kaOcPHkXtIvu7BkonswBJecumEK9oF1
	jcTMi3jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOQe-0000000ARw5-00Po;
	Wed, 28 Feb 2024 18:13:16 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPq-0000000ARIb-0vRa;
	Wed, 28 Feb 2024 18:12:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 19/21] nvme-apple: initialize max_hw_sectors earlier
Date: Wed, 28 Feb 2024 10:12:13 -0800
Message-Id: <20240228181215.873854-20-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228181215.873854-1-hch@lst.de>
References: <20240228181215.873854-1-hch@lst.de>
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

Initialize max_hw_sectors and max_sectors a little earlier so they
can be passed directly to blk_mq_alloc_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/apple.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index a480cdeac2883c..12281fc6932d40 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1046,14 +1046,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
 	dev_dbg(anv->dev, "ANS booted successfully.");
 
-	/*
-	 * Limit the max command size to prevent iod->sg allocations going
-	 * over a single page.
-	 */
-	anv->ctrl.max_hw_sectors = min_t(u32, NVME_MAX_KB_SZ << 1,
-					 dma_max_mapping_size(anv->dev) >> 9);
-	anv->ctrl.max_segments = NVME_MAX_SEGS;
-
 	dma_set_max_seg_size(anv->dev, 0xffffffff);
 
 	/*
@@ -1516,6 +1508,14 @@ static int apple_nvme_probe(struct platform_device *pdev)
 		goto put_dev;
 	}
 
+	/*
+	 * Limit the max command size to prevent iod->sg allocations going
+	 * over a single page.
+	 */
+	anv->ctrl.max_hw_sectors = min_t(u32, NVME_MAX_KB_SZ << 1,
+					 dma_max_mapping_size(anv->dev) >> 9);
+	anv->ctrl.max_segments = NVME_MAX_SEGS;
+
 	anv->ctrl.admin_q = blk_mq_alloc_queue(&anv->admin_tagset, NULL, NULL);
 	if (IS_ERR(anv->ctrl.admin_q)) {
 		ret = -ENOMEM;
-- 
2.39.2


