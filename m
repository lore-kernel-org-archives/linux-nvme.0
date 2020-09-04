Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550D7C2D0A7
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0D62074D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WAsvWNV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0D62074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wIAhyUkOS0GcUQc1XsLV/3LIdWEjyU08cxVneE8DRSA=; b=WAsvWNV2mcFKrA5jpAqXQbp12p
	SWhJwI3Jn93QiAi0H48YganVsjsov8ghGxEN3pcuAGuy4/C9dTdPPyqIHcDzuVZcbXxDh+5Wsk3mJ
	x44cC8lYL7KWuPE8M8BIqgnlkcfRQ8QlIWPm9pTmBTo3Oa0KMSaG5SrbRgEp+nQumRVZlfNT3XHML
	ESzIUYJsWSCt804mKIv7wmG+86sGKp/aFmhZC1bW2IqeEfTZuA4FV60VdhVo8ArffE6f/bXY+UBtz
	MCJFXeMTFojn5L3uQoUSDWrjO4J6QZQknvkOFHFGGCJuWSKuC0KjiTVhPz2V9LhwztTiFLZ1vMspF
	viSlL5Bg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEDhJ-0003Nc-95; Fri, 04 Sep 2020 15:32:17 +0000
Received: from mail3-162.sinamail.sina.com.cn ([202.108.3.162])
 by merlin.infradead.org with smtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEDdo-0001Fp-8K
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 15:28:42 +0000
Received: from unknown (HELO localhost.localdomain)([123.115.164.148])
 by sina.com with ESMTP
 id 5F525C880001F4A3; Fri, 4 Sep 2020 23:26:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 10550049283211
From: Hillf Danton <hdanton@sina.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] dma-direct: zero out DMA_ATTR_NO_KERNEL_MAPPING buf
Date: Fri,  4 Sep 2020 23:25:49 +0800
Message-Id: <20200904152550.17964-1-hdanton@sina.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200904_112841_546421_B762DCE6 
X-CRM114-Status: UNSURE (   8.27  )
X-CRM114-Notice: Please train this message.
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
Cc: Hillf Danton <hdanton@sina.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-nvme@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


The DMA buffer allocated is always cleared in DMA core and this is
making DMA_ATTR_NO_KERNEL_MAPPING non-special.

Fixes: d98849aff879 ("dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING in common code")
Cc: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
---

--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -178,9 +178,17 @@ void *dma_direct_alloc_pages(struct devi
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
 	    !force_dma_unencrypted(dev)) {
+		int i;
+
 		/* remove any dirty cache lines on the kernel alias */
 		if (!PageHighMem(page))
 			arch_dma_prep_coherent(page, size);
+
+		for (i = 0; i < size/PAGE_SIZE; i++) {
+			ret = kmap_atomic(page + i);
+			memset(ret, 0, PAGE_SIZE);
+			kunmap_atomic(ret);
+		}
 		/* return the page pointer as the opaque cookie */
 		ret = page;
 		goto done;
--


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
