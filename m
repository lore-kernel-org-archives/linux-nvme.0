Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B973C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oZwkbhnRludRS5R0RTAiWczzy6FwRMExxe70tzi2HqA=; b=N78IAzAUAd//V1s/DiKWadJwcv
	07ArnxVUuxpb8Iv79oHM45fIGLJwWEY1M/4D0X7BnVBLAaG3MerO1vrY4Bzg9FbJU/WEBUG8fUhaf
	ICkzgsTKWjFkMDJVxK+bdvK2mDZOLTX4pWFbG018cWNulFy8TjVk1bCVEk3728/zHB8CsRAIOauLD
	NwMk7tgGqNpIZjHJxJRuFA49xC8VbZGUcZkGL/L+lAcZsEviMW05WBEUjetbX3WlvjuogByKtreQ5
	6ZyMDoJn+5XjmDHvYU4avtODvAF973UpbKaFTspZj5G9fiao1/r3eT4ptrHgHP5rTi5HRd/sYLOh9
	laNKIu0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naj67-009peF-CO; Sat, 02 Apr 2022 19:07:43 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naj63-009pcd-Cu; Sat, 02 Apr 2022 19:07:41 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MmkfQ-1oKGNU1mOU-00jpge; Sat, 02 Apr 2022 21:07:34 +0200
Received: by mail-wm1-f44.google.com with SMTP id
 bi13-20020a05600c3d8d00b0038c2c33d8f3so5329132wmb.4; 
 Sat, 02 Apr 2022 12:07:34 -0700 (PDT)
X-Gm-Message-State: AOAM530cMYlnEJyfYCOKNUHyknUCa7L2k3UES+TQ1CZbf10gx9gYxugi
 Z0MmsLue9tMGyLb4jETCT3FD1wfwUoACYkBHFGw=
X-Google-Smtp-Source: ABdhPJwIAkpxl+JZt9LjgRq9lJWnGHnJOqkbLJpfn319rdmgWy77pOsaUi8rkQeJc/4Nv+hf1X3LMml3uCdwMixVHak=
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id
 f19-20020a7bcd13000000b0038bf39c1181mr13827152wmj.20.1648926453781; Sat, 02
 Apr 2022 12:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-5-sven@svenpeter.dev>
 <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
 <f06576c8-76c6-41ae-874d-81ea0b5b5603@www.fastmail.com>
In-Reply-To: <f06576c8-76c6-41ae-874d-81ea0b5b5603@www.fastmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 2 Apr 2022 21:07:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3xioqJDb7hQ3dvxQyHPg2hgJbeJywEP+N4cDzpo=8VhQ@mail.gmail.com>
Message-ID: <CAK8P3a3xioqJDb7hQ3dvxQyHPg2hgJbeJywEP+N4cDzpo=8VhQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
To: Sven Peter <sven@svenpeter.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>, 
 Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, 
 "sagi@grimberg.me" <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lSCs024ug8tz20rxjmLOguYQZELjqNAg+5qYDOmTLHbw6CCjnZ8
 JIp9gZqflgOmw9l9cT5pVNeLTukknoJoXAp1Xm/FSU4pys8Deks21TUrcabCWx7Iuytz2Pl
 C6iZvGF0bzeW2+J3c7en/sRt0skgp5/T/uT7MiREtn8QvYpiEyeNO+SuIKRouTrVSMFwjfO
 0jRbnVEheEUx81S//DTzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3iPvDsg86vQ=:amHitQTSpk155fD7duNyg8
 EPriDgIWiLAgS46CzrFKi4RQlo4a/fbUiy01MHa7wGmN9zy5FJKwjtLnYvu1vq8gOF5DjZsg1
 eMGhDdj7gHE1fnvDfJ+eGkWWcL1sMC/+t3J4qXlnWTtgXX8b128Tq50kGUULTxgMVmfr21GMQ
 gNPRDE8r73aceNaaJz84ToeUv3pUIdxbI94YmjML7qUHobkQHyW6iZM1GG1G4Pz12QzzmtXUs
 bqngg2SWnZ+pRSYFrwkkDYBQ4GNuSYusVC9SQsWiZ2dZ24Atr2MWJITyKeJrL2zhesCLes0YB
 ifbdBG1ZHPMs6gzHbgRDHywLy4zl1fIsEbbL/zTdGpw8jyDyzM9h7bpcbkugg252knoYeh4Tp
 P0mulbp3WGsg5SsN/omPDrp6YfEHroxn9TV3twmMYllq74wq1ji3bOMXdD9JFVUaWyVuRa0Ui
 xma/4CddyxLwodc1GXiqexXxYHKCvS2nvpPsAqcQ5wDZLHGfmvlDdc8yY0ShtFS/rj2SLYj6M
 xRyx/nUqL/ijaVszzXvSszTxVDMfrjq20zzEz8VbtYTYuv+Cy4kS10AajGfjv6ywLPvVeRhZ/
 SU69ybLvF7tgdwYMuEaFS3PeIaUh0CdlVW3ZidDjQipG6LQIDIQzOWZjwR6Y++ZLGNA3aDvUA
 iTeEmn7PUyMf33V0FEJNjGGsxGV4A/+y9nZMjmE7bExYAxvvUT/F7CvYICrmXGvdXw/uc2xiT
 tQ375XM16vw0oxd+gmPPl6KVQiG+jiQ/GNNTr5EnYtWgBy7Rw2iq5EVjpFNLOjzdMNsX30/mf
 We0FD06gdkWBt9ezu8Mp4rFIqevp2xl8CDEWL2yv/2xVLon/KE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_120739_756670_E2368475 
X-CRM114-Status: GOOD (  36.85  )
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

On Sat, Apr 2, 2022 at 2:38 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Mon, Mar 21, 2022, at 18:07, Arnd Bergmann wrote:
> > On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
> >> The NVMe co-processor on the Apple M1 uses a DMA address filter called
> >> SART for some DMA transactions. This adds a simple driver used to
> >> configure the memory regions from which DMA transactions are allowed.
> >>
> >> Co-developed-by: Hector Martin <marcan@marcan.st>
> >> Signed-off-by: Hector Martin <marcan@marcan.st>
> >> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> >
> > Can you add some explanation about why this uses a custom interface
> > instead of hooking into the dma_map_ops?
>
> Sure.
> In a perfect world this would just be an IOMMU implementation but since
> SART can't create any real IOVA space using pagetables it doesn't fit
> inside that subsytem.
>
> In a slightly less perfect world I could just implement dma_map_ops here
> but that won't work either because not all DMA buffers of the NVMe
> device have to go through SART and those allocations happen
> inside the same device and would use the same dma_map_ops.
>
> The NVMe controller has two separate DMA filters:
>
>    - NVMMU, which must be set up for any command that uses PRPs and
>      ensures that the DMA transactions only touch the pages listed
>      inside the PRP structure. NVMMU itself is tightly coupled
>      to the NVMe controller: The list of allowed pages is configured
>      based on command's tag id and even commands that require no DMA
>      transactions must be listed inside NVMMU before they are started.
>    - SART, which must be set up for some shared memory buffers (e.g.
>      log messages from the NVMe firmware) and for some NVMe debug
>      commands that don't use PRPs.
>      SART is only loosely coupled to the NVMe controller and could
>      also be used together with other devices. It's also the only
>      thing that changed between M1 and M1 Pro/Max/Ultra and that's
>      why I decided to separate it from the NVMe driver.
>
> I'll add this explanation to the commit message.

Ok, thanks.

> >> +static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
> >> +                           phys_addr_t *paddr, size_t *size)
> >> +{
> >> +       u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
> >> +       u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART2_PADDR(index));
> >
> > Why do you use the _relaxed() accessors here and elsewhere in the driver?
>
> This device itself doesn't do any DMA transactions so it needs no memory
> synchronization barriers. Only the consumer (i.e. rtkit and nvme) read/write
> from/to these buffers (multiple times) and they have the required barriers
> in place whenever they are used.
>
> These buffers so far are only allocated at probe time though so even using
> the normal writel/readl here won't hurt performance at all. I can just use
> those if you prefer or alternatively add a comment why _relaxed is fine here.
>
> This is a bit similar to the discussion for the pinctrl series last year [1].

I think it's better to only use the _relaxed version where it actually helps,
with a comment about it, and use the normal version elsewhere, in
particular in functions that you have copied from the normal nvme driver.
I had tried to compare some of your code with the other version and
was rather confused by that.

        Arnd

