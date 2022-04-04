Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEF4C41535
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CJuWYKltsebJlR+iYJcx+89VT3YSFELwZ66eJZ0td+A=; b=eu4O9givl8+cwcgBFmFE3GwMKL
	1YHtOchrSXL0UzhsWe5Fl7ehoeCjhVygu1O/rhd7qshITcckWkBT6mtCmFNaaMrdTAH37u9XAjZ8F
	XJmbT+VIGZU3XQ9f6GjrZw55RV0Nj13Q85cBLG+M7lbCTSGV3pf7OCxq9RqDE41Gq5QTQyL+Jn8Ex
	rQQjdPTn2LF9RT9TJh27eslrPQbH01/2gOsfhjHI/qEZVtuy+DbCyb9IQ6x0mOSJRInc4U2iu4INE
	HOU3WYTcwdd96AdNa5K/mDH1Z8ugzsQjqn/cP0SUqK0dfD+gCMe+IprLFkQ64YqJ+v1OnsoyQ1nhe
	a0scMxpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbOAU-00FS1C-3e; Mon, 04 Apr 2022 14:58:58 +0000
Received: from mail-oi1-f174.google.com ([209.85.167.174])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbOAG-00FRyP-5I; Mon, 04 Apr 2022 14:58:45 +0000
Received: by mail-oi1-f174.google.com with SMTP id i7so10326585oie.7;
 Mon, 04 Apr 2022 07:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CJuWYKltsebJlR+iYJcx+89VT3YSFELwZ66eJZ0td+A=;
 b=itzj5vxbPLu0mwNyPHS1zwKVTzn7pFPhynNju8TekEDYo+q37U9w3eB0b8LLM+ReX4
 BnIOucsNPKnGyd4rhVnQ6LrwPCIOmvl7LJFp/l75uorwV4tWzlPQsxKvjy/WdppQgiC3
 f3UREu7VtJsumZirK8fLi7sQG+caqxgSU0sEW0b/4HQnfFy5VZXUgUO11dNaSdmMDMjy
 xEEKML8gxVYb8JwuEuLOB+VrafRMUDz/g3ER36+M0yVjRDEhVkqLpwklh1pnnyc8EOWm
 g/HxJzTWGwa3a8FPbe0l30Prqo229GqB4LdJVhdk+ig5WE/yKtSdlbWUrOp03Je/vuvf
 QZIA==
X-Gm-Message-State: AOAM531rIJSuukN4q1KF/DYW+rWGv+Lk5zdh+QFImAZZr/AAHHjZoqhy
 tScq4Cd+w4RkRv2sEtc8w6EwUe3Eew==
X-Google-Smtp-Source: ABdhPJy+knYz0FpBD+B/XqYTFDDly0IFKpeHzcuI/2tbLzaMUlojyFct1PO94CJWC8ERoCh+9DpPUQ==
X-Received: by 2002:a05:6808:2024:b0:2f9:6119:d6ec with SMTP id
 q36-20020a056808202400b002f96119d6ecmr97312oiw.203.1649084323010; 
 Mon, 04 Apr 2022 07:58:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 q83-20020aca5c56000000b002f94910a053sm4260942oib.56.2022.04.04.07.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Apr 2022 07:58:42 -0700 (PDT)
Received: (nullmailer pid 1315218 invoked by uid 1000);
 Mon, 04 Apr 2022 14:58:41 -0000
Date: Mon, 4 Apr 2022 09:58:41 -0500
From: Rob Herring <robh@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 DTML <devicetree@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
Message-ID: <YksHoQvDqXOK70EX@robh.at.kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-5-sven@svenpeter.dev>
 <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
 <f06576c8-76c6-41ae-874d-81ea0b5b5603@www.fastmail.com>
 <CAK8P3a3xioqJDb7hQ3dvxQyHPg2hgJbeJywEP+N4cDzpo=8VhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3xioqJDb7hQ3dvxQyHPg2hgJbeJywEP+N4cDzpo=8VhQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_075844_240786_1A1B6F03 
X-CRM114-Status: GOOD (  42.14  )
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

On Sat, Apr 02, 2022 at 09:07:17PM +0200, Arnd Bergmann wrote:
> On Sat, Apr 2, 2022 at 2:38 PM Sven Peter <sven@svenpeter.dev> wrote:
> > On Mon, Mar 21, 2022, at 18:07, Arnd Bergmann wrote:
> > > On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
> > >> The NVMe co-processor on the Apple M1 uses a DMA address filter called
> > >> SART for some DMA transactions. This adds a simple driver used to
> > >> configure the memory regions from which DMA transactions are allowed.
> > >>
> > >> Co-developed-by: Hector Martin <marcan@marcan.st>
> > >> Signed-off-by: Hector Martin <marcan@marcan.st>
> > >> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > >
> > > Can you add some explanation about why this uses a custom interface
> > > instead of hooking into the dma_map_ops?
> >
> > Sure.
> > In a perfect world this would just be an IOMMU implementation but since
> > SART can't create any real IOVA space using pagetables it doesn't fit
> > inside that subsytem.
> >
> > In a slightly less perfect world I could just implement dma_map_ops here
> > but that won't work either because not all DMA buffers of the NVMe
> > device have to go through SART and those allocations happen
> > inside the same device and would use the same dma_map_ops.
> >
> > The NVMe controller has two separate DMA filters:
> >
> >    - NVMMU, which must be set up for any command that uses PRPs and
> >      ensures that the DMA transactions only touch the pages listed
> >      inside the PRP structure. NVMMU itself is tightly coupled
> >      to the NVMe controller: The list of allowed pages is configured
> >      based on command's tag id and even commands that require no DMA
> >      transactions must be listed inside NVMMU before they are started.
> >    - SART, which must be set up for some shared memory buffers (e.g.
> >      log messages from the NVMe firmware) and for some NVMe debug
> >      commands that don't use PRPs.
> >      SART is only loosely coupled to the NVMe controller and could
> >      also be used together with other devices. It's also the only
> >      thing that changed between M1 and M1 Pro/Max/Ultra and that's
> >      why I decided to separate it from the NVMe driver.
> >
> > I'll add this explanation to the commit message.
> 
> Ok, thanks.
> 
> > >> +static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
> > >> +                           phys_addr_t *paddr, size_t *size)
> > >> +{
> > >> +       u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
> > >> +       u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART2_PADDR(index));
> > >
> > > Why do you use the _relaxed() accessors here and elsewhere in the driver?
> >
> > This device itself doesn't do any DMA transactions so it needs no memory
> > synchronization barriers. Only the consumer (i.e. rtkit and nvme) read/write
> > from/to these buffers (multiple times) and they have the required barriers
> > in place whenever they are used.
> >
> > These buffers so far are only allocated at probe time though so even using
> > the normal writel/readl here won't hurt performance at all. I can just use
> > those if you prefer or alternatively add a comment why _relaxed is fine here.
> >
> > This is a bit similar to the discussion for the pinctrl series last year [1].
> 
> I think it's better to only use the _relaxed version where it actually helps,
> with a comment about it, and use the normal version elsewhere, in
> particular in functions that you have copied from the normal nvme driver.
> I had tried to compare some of your code with the other version and
> was rather confused by that.

Oh good, I tell folks the opposite (and others do too). We don't accept 
random explicit barriers without explanation, but implicit ones are 
okay? The resulting code on arm32 is also pretty horrible with the L2x0 
and OMAP sync hooks not that that matters here.

I don't really care too much which way we go, but we should document one 
rule and follow that.

Rob

