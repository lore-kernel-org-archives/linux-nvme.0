Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BA9C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:00:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDBB20738
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zZYeyMoX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FfmYzkf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDBB20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E4mt7MK9bHmZzvqDpzCs/ysH/6UfuX29BPeHfJJrkuk=; b=zZYeyMoXRE/8zsnvsYT49QDPu
	9+wvYX16BPjpBO3c2/irE4R5fnl0tRUqg9dDOE8PncbI+/zH8zHdD1qL5wyPgL+er4NRNQqUenSmo
	ujLAijtK38SVZ575NHokU/04Or+yFi3H6+UdsFYduVqTVAFTLwMr9w74bKcpPJSEGl/jh9aFPMxlP
	d7ub12IJs1vOty5F55lUo55hLd6LnCqN6RSHAzdDRCEIu6pytYqHsjlvuw6DIaw4Qx7WuHZwrLqZp
	ZL+dcTQwZHW86UIuX2DEzDCuxex3kmaksq7kXXYkz603bF7GFTcH+ccQw86PVsTbKE5Jsd/NsQWJW
	wK3IW6jEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8I4y-0006m6-AG; Wed, 19 Aug 2020 07:00:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1C-0004xQ-FW; Wed, 19 Aug 2020 06:56:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=3H4NansDDN6m4kLuhIk/kp+Z4N3mSn8cpB0zE9ycnQw=; b=FfmYzkf9G6zwFUNNR629I5LzS3
 sycbpl6XBJNQxWdPFjivtYFvAIE2BLJ2qzBGSbrb4qsZMMfJP9/eHP8S4mQZ2+1Qp/sFoX35RiYzA
 HkdgOwz29iCkQAeMrmvVDYWraKQlEbIhijWnbLTMYghTv+7s9PA7sbl0esYUqgLYg5nrbhp5tTocC
 MkluoLqBfAzc4H5hViUIudDFe/lF5vGUx/dU2cLYx7jpBj8d8QnwTRzaMwN5nNPDKwz3V69GXE5aG
 zl6z181fqk4Jsg3atxLUAO9BbSDDhHAHpg0t5QmSPP39kziJBaZbtnr9s/ut+FwVdfRsInPqqIqLh
 2U/MY4HQ==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1A-0008Nq-7N; Wed, 19 Aug 2020 06:56:16 +0000
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
Subject: [PATCH 10/28] MIPS/jazzdma: decouple from dma-direct
Date: Wed, 19 Aug 2020 08:55:37 +0200
Message-Id: <20200819065555.1802761-11-hch@lst.de>
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

The jazzdma ops implement support for a very basic IOMMU.  Thus we really
should not use the dma-direct code that takes physical address limits
into account.  This survived through the great MIPS DMA ops cleanup mostly
because I was lazy, but now it is time to fully split the implementations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/jazz/jazzdma.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index fe40dbed04c1d6..d0b5a2ba2b1a8a 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -16,7 +16,6 @@
 #include <linux/memblock.h>
 #include <linux/spinlock.h>
 #include <linux/gfp.h>
-#include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
 #include <asm/mipsregs.h>
 #include <asm/jazz.h>
@@ -492,26 +491,38 @@ int vdma_get_enable(int channel)
 static void *jazz_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	struct page *page;
 	void *ret;
 
-	ret = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
-	if (!ret)
-		return NULL;
+	if (attrs & DMA_ATTR_NO_WARN)
+		gfp |= __GFP_NOWARN;
 
-	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
-	if (*dma_handle == DMA_MAPPING_ERROR) {
-		dma_direct_free_pages(dev, size, ret, *dma_handle, attrs);
+	size = PAGE_ALIGN(size);
+	page = alloc_pages(gfp, get_order(size));
+	if (!page)
 		return NULL;
-	}
+	ret = page_address(page);
+	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
+	if (*dma_handle == DMA_MAPPING_ERROR)
+		goto out_free_pages;
+
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
+		return ret;
+	arch_dma_prep_coherent(page, size);
+	return (void *)(UNCAC_BASE + __pa(ret));
 
-	return ret;
+out_free_pages:
+	__free_pages(page, get_order(size));
+	return NULL;
 }
 
 static void jazz_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	vdma_free(dma_handle);
-	dma_direct_free_pages(dev, size, vaddr, dma_handle, attrs);
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
+		vaddr = __va(vaddr - UNCAC_BASE);
+	__free_pages(virt_to_page(vaddr), get_order(size));
 }
 
 static dma_addr_t jazz_dma_map_page(struct device *dev, struct page *page,
@@ -608,7 +619,6 @@ const struct dma_map_ops jazz_dma_ops = {
 	.sync_single_for_device	= jazz_dma_sync_single_for_device,
 	.sync_sg_for_cpu	= jazz_dma_sync_sg_for_cpu,
 	.sync_sg_for_device	= jazz_dma_sync_sg_for_device,
-	.dma_supported		= dma_direct_supported,
 	.cache_sync		= arch_dma_cache_sync,
 	.mmap			= dma_common_mmap,
 	.get_sgtable		= dma_common_get_sgtable,
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
