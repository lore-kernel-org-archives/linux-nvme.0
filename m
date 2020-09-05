Return-Path: <SRS0=rLKq=CO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B87C433E2
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 15:51:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E1A206B8
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0baED0E2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="dAEp9IzG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="TthukJJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E1A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Er8WE3x836jdARrbNZ+rcWVJfD0QtaFwIqphYbzqWZA=; b=0baED0E2M4s4UJ4us2iclr1y4
	1Bkxeorat+NR/sc27/huLRSgqlSHEe0R2/eVUQTVdCfdk+FLicowOwolBqvOWXkx/jZRChYrY3ysW
	2Ty6H8M3kwi2YhrXUY3koEo3BbcvblHZnVneUy947pGwMjO4pQmtMS+m3KPhRh/R41t2AFV1NkpYS
	5f5SCfaEmAcBn1ZgTRzRtF8awCHOu5EgmMpqFIt2ghCS0nBrjlbQcl5/BE2SEypRU7SoQrZnZNzlD
	Q0Vy7rRnNLRvNBj8ZgWFYGs5MMCbZPJjUywwmGUeJA7/zmNolQ3AmZLukMyNJ0swlutZOCJHqTTar
	qfgn2AYlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEaSu-0006Oo-Id; Sat, 05 Sep 2020 15:50:56 +0000
Received: from bedivere.hansenpartnership.com ([66.63.167.143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEaSr-0006O4-Kx
 for linux-nvme@lists.infradead.org; Sat, 05 Sep 2020 15:50:54 +0000
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id A05BF8EE112;
 Sat,  5 Sep 2020 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
 s=20151216; t=1599321052;
 bh=7DqLMBAim3TLV7CCpapqN2oVi0HwtXEehiJyKhXCJ3Q=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=dAEp9IzGlRMMJN5Ba8HmPY5w6FRO2xbQp2r4JI6BbbqrFrq4RbUm5vm/tlyyMfcOx
 YbBZp5l74ktnzdRhMlu1eokeGXBBdeK0EAr99v3GdvMPA/QHOzDSODW0K8xM52LK53
 kytI/YmAIprdKwOzQcJnI60vJaC3E4nQ4kNerjk0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id zJ1denWn5qXV; Sat,  5 Sep 2020 08:50:48 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net
 [73.35.198.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E493B8EE100;
 Sat,  5 Sep 2020 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
 s=20151216; t=1599321044;
 bh=7DqLMBAim3TLV7CCpapqN2oVi0HwtXEehiJyKhXCJ3Q=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=TthukJJ15LDoRS0MfGU/WPdrtBcsG6PrF7Mc5VF1oTLIa5EBZnV93IpKgi+GMFp8K
 23UVNjYDfACS59OeZfC+9seFNvPhF3dg8wNdgIrs6qEn8X/RPyuXr6xuq84QrGSCQf
 LzQ7rvvAIj569qiFecC96bxFFxbtYFqEJ/9Eh0iY=
Message-ID: <1599321042.11726.6.camel@HansenPartnership.com>
Subject: Re: [PATCH] dma-direct: zero out DMA_ATTR_NO_KERNEL_MAPPING buf
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Hillf Danton <hdanton@sina.com>
Date: Sat, 05 Sep 2020 08:50:42 -0700
In-Reply-To: <20200905073528.9464-1-hdanton@sina.com>
References: <20200904152550.17964-1-hdanton@sina.com>
 <20200905073528.9464-1-hdanton@sina.com>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200905_115053_801171_BF5D56E9 
X-CRM114-Status: GOOD (  28.94  )
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
Cc: linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

[resend with correct linux-arch address]
On Sat, 2020-09-05 at 15:35 +0800, Hillf Danton wrote:
> On Fri, 04 Sep 2020 08:34:39 -0700 James Bottomley wrote:
> > On Fri, 2020-09-04 at 23:25 +0800, Hillf Danton wrote:
> > > The DMA buffer allocated is always cleared in DMA core and this
> > > is making DMA_ATTR_NO_KERNEL_MAPPING non-special.
> > > 
> > > Fixes: d98849aff879 ("dma-direct: handle
> > > DMA_ATTR_NO_KERNEL_MAPPING
> > > in common code")
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > Signed-off-by: Hillf Danton <hdanton@sina.com>
> > > ---
> > > 
> > > --- a/kernel/dma/direct.c
> > > +++ b/kernel/dma/direct.c
> > > @@ -178,9 +178,17 @@ void *dma_direct_alloc_pages(struct devi
> > >  
> > >  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> > >  	    !force_dma_unencrypted(dev)) {
> > > +		int i;
> > > +
> > >  		/* remove any dirty cache lines on the kernel
> > > alias
> > > */
> > >  		if (!PageHighMem(page))
> > >  			arch_dma_prep_coherent(page, size);
> > > +
> > > +		for (i = 0; i < size/PAGE_SIZE; i++) {
> > > +			ret = kmap_atomic(page + i);
> > > +			memset(ret, 0, PAGE_SIZE);
> > > +			kunmap_atomic(ret);
> 
> Hi James
> > 
> > This is massively expensive on PARISC and likely other VIPT/VIVT
> > architectures.
> 
> Correct.
> 
> > What's the reason for clearing it?  This could also be
> 
> 	/* we always manually zero the memory once we are done: */
> 	gfp &= ~__GFP_ZERO;
> 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
> 					   &phys_limit);

That's not a reason ... that comment was put in for coherent mappings. 
What is the reason we should incur all this expense for clearing pages
which aren't unmapped in the kernel, because we can update the comment?
 The usual rationale for kernel mapped pages is security, because they
may leak information but unmapped pages shouldn't have this problem.

> > really inefficient even on PIPT architectures if the memory is
> > device remote.
> > 
> > If we really have to do this, it should likely be done in the arch
> > or driver hooks because there are potentially more efficient ways
> > we can do this knowing how the architecture behaves.
> 
> I'm open to any vintage ideas in your mind wrt clearing dma buf e.g
> on platforms like PARISC. Or feel free to offload me the work if it
> makes sense to you who are rich of PARISC knowledge.

OK, I've cc'd linux-arch because this is a problem for more than just
parisc.  However, not having to do it is the best solution ... sort of
the doctor, doctor it hurts when I do this answer.

James


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
