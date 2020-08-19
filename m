Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B4CC433E4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:04:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301DA20786
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PGiKibO2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FjpJs1q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301DA20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=npuQilMPqc/gi72ZsB6j8+DVLU5Gp/au6WHc5HXDQUs=; b=PGiKibO2ITcFdpllQjyhCNVfq
	iIFEdSPsX/JmDSzqitYULxVzjUOr1YJPxN0zjuUrT+zzwA7+j8OBXBf7+zvNc3RK+W7i1um/jSQHV
	w9VGMB5Ui7M3dQ+XXND/kkjkhTOXaBx3UNerOKcXHrbWLmzc5OBWJTSG0+g90O963P+4nRmBNCG2m
	Fj1P4zVnouWXC05DplWE05QXMn0zU/VdJL2UQPxeQpU196teH4hFAEwZoB18tW/3xdTPhXeyc4PQ4
	PJ7ubX5u5Yn0eL7TW6odIwYWL0ca9He1mEuQL9o3w5E5fFHmHGj0JP/t2aU3H117QFqlAG4UoqbJs
	K4aAlMn0A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8I9D-0000KP-JK; Wed, 19 Aug 2020 07:04:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1J-00050Z-D2; Wed, 19 Aug 2020 06:56:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=gjKGhyixAeN99VD5Y9J4wAkwFSZBXIPb+5emgbxT41Q=; b=FjpJs1q6Y1lBqC7rkOykwKGmk4
 jBazOeHmmonZ9E/peW+NLv9Lx2BlZehfpM2DRRBB0RMHmZr/GqPJJcvFHiZKAAwTYVPSsnQ50LI+m
 Bu/U2WAdcWaIaZ6B5Y+fnBbU+XDBZyTv5kcCbbDigh3k4uaNsYKFoaE1XT651RmB061jQ3R2lEq/h
 hzk6lwe9o9XRUOTW2U9OJKTpjS/VsEBGE86tZB5jY45zMAWAnXdry3Tqwds8hZwv6z0Hxga1FHrno
 bssR18gkqfcz3Ua1iOftURBw2VyObut0Q/71HLKgNMs5OBxveAupyeYLotw63rsMM1/Us3GBeLTHK
 b//XcmfA==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1G-0008Oy-KM; Wed, 19 Aug 2020 06:56:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 13/28] dma-direct: lift gfp_t manipulation out
 of__dma_direct_alloc_pages
Date: Wed, 19 Aug 2020 08:55:40 +0200
Message-Id: <20200819065555.1802761-14-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819065555.1802761-1-hch@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Move the detailed gfp_t setup from __dma_direct_alloc_pages into the
caller to clean things up a little.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8da9a62dd9a72c..01120510968fa1 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -108,7 +108,7 @@ static inline bool dma_should_free_from_pool(struct device *dev,
 }
 
 static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
-		gfp_t gfp, unsigned long attrs)
+		gfp_t gfp)
 {
 	int node = dev_to_node(dev);
 	struct page *page = NULL;
@@ -116,11 +116,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
 
-	if (attrs & DMA_ATTR_NO_WARN)
-		gfp |= __GFP_NOWARN;
-
-	/* we always manually zero the memory once we are done: */
-	gfp &= ~__GFP_ZERO;
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
@@ -164,6 +159,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 
 	size = PAGE_ALIGN(size);
+	if (attrs & DMA_ATTR_NO_WARN)
+		gfp |= __GFP_NOWARN;
 
 	if (dma_should_alloc_from_pool(dev, gfp, attrs)) {
 		ret = dma_alloc_from_pool(dev, size, &page, gfp);
@@ -172,7 +169,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		goto done;
 	}
 
-	page = __dma_direct_alloc_pages(dev, size, gfp, attrs);
+	/* we always manually zero the memory once we are done */
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
 	if (!page)
 		return NULL;
 
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
