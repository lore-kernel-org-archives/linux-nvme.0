Return-Path: <SRS0=UNTL=CP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE3CC433E2
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2020 01:10:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DDE2078D
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2020 01:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bVw2e6Po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DDE2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IrBO/V2vI2kE76zygCEAR5vZDZISQw8y6G7cFnuKlLs=; b=bVw2e6PomjcHwWZyIMPy6VppW
	X7neTYByP++t6pxbabvmZLXjN0PJdb/O7kgq3b480arLKUbeMOh6TmPa0N+o4xUG3ZH/yKWzAwlBm
	iRHX/Q688e5sanFNGtvRdYkQwJaO78dVFLzSZgP+rAJmyBmlGpMaKsBpmcP9sUp9KL3/uLz8W7bmH
	MhFmyfmgqpdkcicydIthQ9IeccrSI5S1tzwRZ6gZin+Kyw5Ugaim4RZXwzk9GR8DI7vFdwXPCbBHt
	vq8yZEUqFFWwDDPGr1P8DqmbJk0WqrJSvKndC48GAj2m0GZUsfUzEzs/kuc36iOjdLUPeN4Y0uza2
	Ur7r8jEQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEjCD-0008PX-LT; Sun, 06 Sep 2020 01:10:17 +0000
Received: from mail3-162.sinamail.sina.com.cn ([202.108.3.162])
 by merlin.infradead.org with smtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEjC9-0008P5-B3
 for linux-nvme@lists.infradead.org; Sun, 06 Sep 2020 01:10:15 +0000
Received: from unknown (HELO localhost.localdomain)([123.115.164.148])
 by sina.com with ESMTP
 id 5F5436EB00025AAB; Sun, 6 Sep 2020 09:10:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 29429749283316
From: Hillf Danton <hdanton@sina.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] dma-direct: zero out DMA_ATTR_NO_KERNEL_MAPPING buf
Date: Sun,  6 Sep 2020 09:09:54 +0800
Message-Id: <20200906010954.15976-1-hdanton@sina.com>
In-Reply-To: <1599321042.11726.6.camel@HansenPartnership.com>
References: <20200904152550.17964-1-hdanton@sina.com>
 <20200905073528.9464-1-hdanton@sina.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200905_211013_697378_3D193736 
X-CRM114-Status: GOOD (  21.83  )
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
Cc: linux-arch@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
 Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On Sat, 05 Sep 2020 08:50:42 -0700 James Bottomley wrote:
> [resend with correct linux-arch address]
> On Sat, 2020-09-05 at 15:35 +0800, Hillf Danton wrote:
> > On Fri, 04 Sep 2020 08:34:39 -0700 James Bottomley wrote:
[...]
> > Hi James
> > > 
> > > This is massively expensive on PARISC and likely other VIPT/VIVT
> > > architectures.
> > 
> > Correct.
> > 
> > > What's the reason for clearing it?  This could also be
> > 
> > 	/* we always manually zero the memory once we are done: */
> > 	gfp &= ~__GFP_ZERO;
> > 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
> > 					   &phys_limit);
> 
> That's not a reason ... that comment was put in for coherent mappings. 

It's quite likely that I misread it.

> What is the reason we should incur all this expense for clearing pages
> which aren't unmapped in the kernel, because we can update the comment?

A tough question.

> The usual rationale for kernel mapped pages is security, because they
> may leak information but unmapped pages shouldn't have this problem.

We can turn to Marek for some more light on the concerns you have
about security, particularly linked to DMA_ATTR_NO_KERNEL_MAPPING,
after the patch [1] fails to answer your question.

[1] Subject: [PATCH 1/3] common: DMA-mapping: add DMA_ATTR_NO_KERNEL_MAPPING attribute
https://lore.kernel.org/lkml/1337273586-11089-2-git-send-email-m.szyprowski@samsung.com/

> 
> > > really inefficient even on PIPT architectures if the memory is
> > > device remote.
> > > 
> > > If we really have to do this, it should likely be done in the arch
> > > or driver hooks because there are potentially more efficient ways
> > > we can do this knowing how the architecture behaves.
> > 
> > I'm open to any vintage ideas in your mind wrt clearing dma buf e.g
> > on platforms like PARISC. Or feel free to offload me the work if it
> > makes sense to you who are rich of PARISC knowledge.
> 
> OK, I've cc'd linux-arch because this is a problem for more than just
> parisc.  However, not having to do it is the best solution ... sort of
> the doctor, doctor it hurts when I do this answer.
> 
> James


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
