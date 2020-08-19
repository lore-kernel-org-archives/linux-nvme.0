Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11D6C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:04:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5E720786
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B/fc2o8b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D7imtfyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5E720786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5nueu1r9nzmVFS7Hrzog5/fMFSadUmRRuUz8bGxa1iw=; b=B/fc2o8bAgMFbdxu+G9obCm8f
	vn4EECB3wshjJRIWZfj2xrk0jJWZrVsUDMvtZ2e3FwrluasQcS3qMuJ4wWJOHiu5arH0e4WA9BYKr
	xekk/0AZ4ctTHowVojGfL2/Q5+EfwS1soCwytNtBOpEs5Su6WJjTUIxUE+cn3KM9N3NB6QH8vDcFD
	W5rSriIFCsM98BzBiBemhwcRK5ZPrxE12G2uGZWjUuFlCjodbQdozSf/uaCwen1pVPVt2hVpibpID
	A7RYmDhQgxDCee6cuDlP1g/U7IZse05M8uIXLDkiNc26ESlh4jk1aWeYbNkYzFx3CGgp2yrfLzIUL
	uZENYPTdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8I9H-0000L5-HH; Wed, 19 Aug 2020 07:04:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1M-000529-SS; Wed, 19 Aug 2020 06:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Iqi9DC545gQ9g/f8jSVVhsHYzLAUQX784ygGs4ZRRGA=; b=D7imtfyJmxTmDyfgn+f/LPtdHL
 JFZyrzg4cAvUvkGLFi8hr63dDldNzvDvjdUfyKGi3rCKELJdsb/0ku9p330bHyqU7mDN25/UoKGQC
 6LlycBSAi/XryA293desvAT603BNGQXCefSTgvyP48l1Xuna09iOtPoh5V11H5m7rxNkmvaiK+58J
 LTIReZzMh7JVtZ/xDjqBJitk59Ky6y6ydtrtA9bniyP8j5wL7gfEINESidgPs2A1Qe+pSEFfTkI3j
 H16A3Wo77NIcudSUJb0dKatozTNv8uTjdMCRxhGt4KoM20trnSq8WcXP3gryV7oxhsJG60dlQHTPn
 MJ/Z5Ggg==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1I-0008PN-Re; Wed, 19 Aug 2020 06:56:25 +0000
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
Subject: [PATCH 14/28] dma-direct: use phys_to_dma_direct in dma_direct_alloc
Date: Wed, 19 Aug 2020 08:55:41 +0200
Message-Id: <20200819065555.1802761-15-hch@lst.de>
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

Replace the currently open code copy.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 01120510968fa1..2e280b9c063449 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -235,10 +235,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_encrypt_pages;
 	}
 done:
-	if (force_dma_unencrypted(dev))
-		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
-	else
-		*dma_handle = phys_to_dma(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return ret;
 
 out_encrypt_pages:
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
