Return-Path: <SRS0=rLKq=CO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7260EC43461
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 07:36:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7468520760
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 07:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nGjJIJ2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7468520760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Sk0kAqsjir1gHPbKsqYJ/Ph4c0y3ijSRX9oVxyNjcBc=; b=nGjJIJ2dZevJ3AHAU2mMTrK+K
	YSrRkNn20LJ2IWLSsOAv2V5uXDNNkMJ6V35gODdCoqf1k2jH5nTnrPWqEXeXwrQxmjkgKLEBancXS
	cnadD+MuTZu9PkZiF4H9/vUzTv18qSqoVL6/8SXY5BhN3+8Kt5fqdqOCzPjgItBIV8D9AnRzEk2Fz
	dh92ZsGBbCH/Dg4nABzCy1W9VC/Q28R6RVcsLL/OK72NljevjwPamU04t5xO7BLNS6IMZOTpRGhA5
	4wIX2KWNoCW9NIk4hReRz/P4Z9AtwWydT6HuXHtY0bKJO/LZpfqXvuNeE3FN0buFpD9b9lLTylC5Q
	TmtsQsMwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kESju-000533-GX; Sat, 05 Sep 2020 07:35:58 +0000
Received: from mail3-164.sinamail.sina.com.cn ([202.108.3.164])
 by merlin.infradead.org with smtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kESjq-00051u-Sb
 for linux-nvme@lists.infradead.org; Sat, 05 Sep 2020 07:35:57 +0000
Received: from unknown (HELO localhost.localdomain)([123.115.164.148])
 by sina.com with ESMTP
 id 5F533FC90002C119; Sat, 5 Sep 2020 15:35:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 38811115073530
From: Hillf Danton <hdanton@sina.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] dma-direct: zero out DMA_ATTR_NO_KERNEL_MAPPING buf
Date: Sat,  5 Sep 2020 15:35:28 +0800
Message-Id: <20200905073528.9464-1-hdanton@sina.com>
In-Reply-To: <1599233679.5231.4.camel@HansenPartnership.com>
References: <20200904152550.17964-1-hdanton@sina.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200905_033556_013954_C9EFE831 
X-CRM114-Status: GOOD (  17.03  )
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
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On Fri, 04 Sep 2020 08:34:39 -0700 James Bottomley wrote:
> On Fri, 2020-09-04 at 23:25 +0800, Hillf Danton wrote:
> > The DMA buffer allocated is always cleared in DMA core and this is
> > making DMA_ATTR_NO_KERNEL_MAPPING non-special.
> > 
> > Fixes: d98849aff879 ("dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING
> > in common code")
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Signed-off-by: Hillf Danton <hdanton@sina.com>
> > ---
> > 
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -178,9 +178,17 @@ void *dma_direct_alloc_pages(struct devi
> >  
> >  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> >  	    !force_dma_unencrypted(dev)) {
> > +		int i;
> > +
> >  		/* remove any dirty cache lines on the kernel alias
> > */
> >  		if (!PageHighMem(page))
> >  			arch_dma_prep_coherent(page, size);
> > +
> > +		for (i = 0; i < size/PAGE_SIZE; i++) {
> > +			ret = kmap_atomic(page + i);
> > +			memset(ret, 0, PAGE_SIZE);
> > +			kunmap_atomic(ret);

Hi James
> 
> This is massively expensive on PARISC and likely other VIPT/VIVT
> architectures.

Correct.

> What's the reason for clearing it?  This could also be

	/* we always manually zero the memory once we are done: */
	gfp &= ~__GFP_ZERO;
	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
					   &phys_limit);

> really inefficient even on PIPT architectures if the memory is device
> remote.
> 
> If we really have to do this, it should likely be done in the arch or
> driver hooks because there are potentially more efficient ways we can
> do this knowing how the architecture behaves.

I'm open to any vintage ideas in your mind wrt clearing dma buf e.g
on platforms like PARISC. Or feel free to offload me the work if it
makes sense to you who are rich of PARISC knowledge.

Hillf


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
