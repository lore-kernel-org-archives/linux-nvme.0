Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA5BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f7SyYZI4nz+qs5qaMDg1riUJfz1XkXCuG6WXTU/lNCQ=; b=KWVW+WC5KdrcNYcpW99KtLrzL8
	3fmi/Yc1YdIOw17WMkMwGl2gWDPb8gFTBWsAed+AHcomBVevLOdcHoCUNgy/OMFbiwWT9akdYIeyr
	I5mwdEBL8Bt1GR7Tq08pp/vmMcDxdgZlJyBb7ivExbVJeoiArtDfcAwq8s8XZZbFNsYF2wMuvU6ma
	ywJ6h4xUPll8u7KhgTEneKD8mABLMsIhzRlQofzX5GapSVSMy1tmZSjSYHzrfDQz6uPIDBYVvyLeI
	4MxNHJHfRCkJXzmELjBRQjrsZOUJWPuhu+dabW3nqLX/+elQgkp24WHgFp1wcHJ7Hrl2fHuQ5gJTN
	1JzgWubw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nblFV-001jaO-1C; Tue, 05 Apr 2022 15:37:41 +0000
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nblFJ-001jY9-5g; Tue, 05 Apr 2022 15:37:31 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 4F6E23201464;
 Tue,  5 Apr 2022 11:37:25 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Tue, 05 Apr 2022 11:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; bh=f7SyYZI4nz+qs5qaMDg1riUJfz1XkX
 CuG6WXTU/lNCQ=; b=abLQr7Ocox7EC2QOocUVper/aOyFWncLbJ1SWNpn1FgdoE
 oFjH6XS6gAddBS5s3IaBrxIUWW+yGYgKFJiYiEb0PK8Fd8bZ62aLn+EoMPkvkHFG
 ZFNXxQWyE4j94LuxavQmpSANyzqQoQw+c/ZRF094grUvUCzHhDgJEmGW5N/C54Nr
 ZZX9/J+C8pc8b22K9aCU44ziKFWg8Aw1DoRnXI86Mxa+lSmPuorMtDjvJv5CCuR7
 VWlU1dP0LXpSdrWH/EgO/Q6Yt/n2GSdGRGiK63mExuRceE8IF901tSfv/R5k8VJR
 +7S5uBKQJHhihPJ+FK9pLvK6dQsZSM5M4iIfNwmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=f7SyYZI4nz+qs5qaM
 Dg1riUJfz1XkXCuG6WXTU/lNCQ=; b=UeVodiwW8PmkEP9EPOHfnWy0CCe0guLPF
 DliOMGO4FfQEz5RrQA9EawpvoUPmY2N4p1Y7hJAhXalO7KNhhjB9hrJzTKQryP13
 BRhjKbc0Uhhae7wmBkB/+Fo7rz7Ekz5+cWeXOJ2KBQmidkgdtNAzXIEa6cnKj6gi
 1EN0qK4VrO/0tTJM7IeFT5mRwIXqQwwJkuHJmIas+yyVgxcHUzTSCTmXCcaRx7xy
 knHKVCSSxf1IVkwBMTOVVhwIstsUlpUzQYMKKD+SXnSMXkbA1MutFKYiEFW1SG3r
 df+ISBqWong8Pjrx9tT1G5Yr/ia7zrmk+U01T4XEeMRJI4FDcDf9Q==
X-ME-Sender: <xms:NGJMYuWXQtktSsSAuTYUMvwDdFEcA4yhQ5MCW9aLDi_bY1KklAMTYw>
 <xme:NGJMYqmG5DoOWovS2HoBGsG8au43ep38U8M7cgPQyXj_NmRISXaRrhDPFjZDxNxP6
 K3qcSG8OEmA2TXnJjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedgkeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:NGJMYiaEdQ36azdMNu80CJVWjwDac80cJld0O7o-VJOtCoxYhEXbmg>
 <xmx:NGJMYlXUrltHCyl4_r8omNuAFmQQCjGgnOEUbp-oRMi_Dtg2ztDlvQ>
 <xmx:NGJMYomK1MwE0auNSM1PEA2y1xulMXcEXFvzKgQvi9xnwS18Q8u7NQ>
 <xmx:NGJMYhfRhmFqCvgyg5ojCGq54Zi4dy_aoLsD-vlMZVtN_tKRMHVfEg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1381327407F6; Tue,  5 Apr 2022 11:37:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-385-g3a17909f9e-fm-20220404.001-g3a17909f
Mime-Version: 1.0
Message-Id: <c5c0db06-2d82-4e5a-b9e4-89e0b7c9230c@www.fastmail.com>
In-Reply-To: <YksHoQvDqXOK70EX@robh.at.kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-5-sven@svenpeter.dev>
 <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
 <f06576c8-76c6-41ae-874d-81ea0b5b5603@www.fastmail.com>
 <CAK8P3a3xioqJDb7hQ3dvxQyHPg2hgJbeJywEP+N4cDzpo=8VhQ@mail.gmail.com>
 <YksHoQvDqXOK70EX@robh.at.kernel.org>
Date: Tue, 05 Apr 2022 17:37:03 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Rob Herring" <robh@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>
Cc: "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "Marc Zyngier" <maz@kernel.org>, DTML <devicetree@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_083729_503967_90D1FAF7 
X-CRM114-Status: GOOD (  36.53  )
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

On Mon, Apr 4, 2022, at 16:58, Rob Herring wrote:
> On Sat, Apr 02, 2022 at 09:07:17PM +0200, Arnd Bergmann wrote:
>> On Sat, Apr 2, 2022 at 2:38 PM Sven Peter <sven@svenpeter.dev> wrote:
>> > On Mon, Mar 21, 2022, at 18:07, Arnd Bergmann wrote:
>> > > On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
>> > >> The NVMe co-processor on the Apple M1 uses a DMA address filter called
>> > >> SART for some DMA transactions. This adds a simple driver used to
>> > >> configure the memory regions from which DMA transactions are allowed.
>> > >>
>> > >> Co-developed-by: Hector Martin <marcan@marcan.st>
>> > >> Signed-off-by: Hector Martin <marcan@marcan.st>
>> > >> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> > >
>> > > Can you add some explanation about why this uses a custom interface
>> > > instead of hooking into the dma_map_ops?
>> >
>> > Sure.
>> > In a perfect world this would just be an IOMMU implementation but since
>> > SART can't create any real IOVA space using pagetables it doesn't fit
>> > inside that subsytem.
>> >
>> > In a slightly less perfect world I could just implement dma_map_ops here
>> > but that won't work either because not all DMA buffers of the NVMe
>> > device have to go through SART and those allocations happen
>> > inside the same device and would use the same dma_map_ops.
>> >
>> > The NVMe controller has two separate DMA filters:
>> >
>> >    - NVMMU, which must be set up for any command that uses PRPs and
>> >      ensures that the DMA transactions only touch the pages listed
>> >      inside the PRP structure. NVMMU itself is tightly coupled
>> >      to the NVMe controller: The list of allowed pages is configured
>> >      based on command's tag id and even commands that require no DMA
>> >      transactions must be listed inside NVMMU before they are started.
>> >    - SART, which must be set up for some shared memory buffers (e.g.
>> >      log messages from the NVMe firmware) and for some NVMe debug
>> >      commands that don't use PRPs.
>> >      SART is only loosely coupled to the NVMe controller and could
>> >      also be used together with other devices. It's also the only
>> >      thing that changed between M1 and M1 Pro/Max/Ultra and that's
>> >      why I decided to separate it from the NVMe driver.
>> >
>> > I'll add this explanation to the commit message.
>> 
>> Ok, thanks.
>> 
>> > >> +static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
>> > >> +                           phys_addr_t *paddr, size_t *size)
>> > >> +{
>> > >> +       u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
>> > >> +       u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART2_PADDR(index));
>> > >
>> > > Why do you use the _relaxed() accessors here and elsewhere in the driver?
>> >
>> > This device itself doesn't do any DMA transactions so it needs no memory
>> > synchronization barriers. Only the consumer (i.e. rtkit and nvme) read/write
>> > from/to these buffers (multiple times) and they have the required barriers
>> > in place whenever they are used.
>> >
>> > These buffers so far are only allocated at probe time though so even using
>> > the normal writel/readl here won't hurt performance at all. I can just use
>> > those if you prefer or alternatively add a comment why _relaxed is fine here.
>> >
>> > This is a bit similar to the discussion for the pinctrl series last year [1].
>> 
>> I think it's better to only use the _relaxed version where it actually helps,
>> with a comment about it, and use the normal version elsewhere, in
>> particular in functions that you have copied from the normal nvme driver.
>> I had tried to compare some of your code with the other version and
>> was rather confused by that.
>
> Oh good, I tell folks the opposite (and others do too). We don't accept 
> random explicit barriers without explanation, but implicit ones are 
> okay? The resulting code on arm32 is also pretty horrible with the L2x0 
> and OMAP sync hooks not that that matters here.
>
> I don't really care too much which way we go, but we should document one 
> rule and follow that.

I don't have a strong opinion either. Arnd's approach is currently documented
in Documentation/driver-api/device-io.rst fwiw:

  On architectures that require an expensive barrier for serializing against
  DMA, these "relaxed" versions of the MMIO accessors only serialize against
  each other, but contain a less expensive barrier operation. A device driver
  might use these in a particularly performance sensitive fast path, with a
  comment that explains why the usage in a specific location is safe without
  the extra barriers.


Sven

