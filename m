Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C76C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 14:12:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780B42072D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 14:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l9pUrZBs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dV/u8lgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780B42072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=krELcRxz97bgXUc0HVsnRRlW0dQ6Z25W8SMZbV+OnDE=; b=l9pUrZBsAbncBqITGxFlL8N6G
	qlbJlVqgeBm0jAplLvv0JEadKXtGbavF+aiNENQy0e45+ZdUpEflqCkXhvCi/FjS+zbIJAeTwYFwU
	cjLc9qemE1gS04EZ+H8djdYgLEUfDWeXmvTb/7epi1xpWCRV/Jz7UVLp/Jd8+KUwQkLUfpnd/ZGUS
	wreMI1GOfPx7dV1HyjmvdhrkCLbs4bBYuXIRu51EyBbV/1V9jMClYa9vC1g+gRxl3inyQ4XCIuTKu
	U14zmtYFOf+oshC7h6xNQaISgl2sEdXUb25Rk/q0UNemLDVVqXi4cHT/ZeilzQoW1n+XYXzRPG5+Y
	tqEeSKphw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8Op4-0002gR-IL; Wed, 19 Aug 2020 14:12:14 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8Op2-0002fD-7O
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 14:12:13 +0000
Received: by mail-ej1-x644.google.com with SMTP id bo3so26427991ejb.11
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Js4y14Ghs6Bq4zdQYDVHKruVAGVzHlKISQN4bMebSg=;
 b=dV/u8lgzRJf9R13RTyQNVA0z7K0gpop908KdbH7mh1lom7wOwawyDuMH4lJJUnAt3N
 ER1Hz91rD7vCxhZyzb6LHpsKYbaB2LKK6Ns95j0nfjmJX5hZXauljIjL3//YJqgWaxRv
 97QHf+SgHVXKKphnPxr8+LnwmzFET6Ce2ARqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Js4y14Ghs6Bq4zdQYDVHKruVAGVzHlKISQN4bMebSg=;
 b=N14lQ4pujg+SGsRuBka28tpLvZ003k3sKr5V4gievvc7jDaoLGGCyYtuB0T+K3YAQU
 zH2JdFPP8c6KAblGPKJ+s62pYV7WB0TYAhU2hstwbN4nTTient59IJWUXasgK4DwNUfJ
 YCq/lWCFAj4xuSt4foEbwgoQa3zKdGo6lm0D9/IIAeCikDvkAy7MUysQuyqxCo1zPNy+
 aWrI8EBBuBeqxmw3VS/yjG7Gft1GSDcyt25t0RDTCDyMig3Vh0o04xSh1uzi5ewg3U2w
 72PDKv3vLdIXOMiO/hCwI3+kARz3aBy7AwfYeQYn0d186NkEAbXMmOyOUYp3TGbvW6Lp
 NGKQ==
X-Gm-Message-State: AOAM531v2NX2QikXnAoNFEuwlkSOIZo4NXZ4B2yoDVmKc9cTLm+RcH37
 Nn0EUrK14cLNPfhNKBmy4+syRa+b1pgb3w==
X-Google-Smtp-Source: ABdhPJxJn9OzwRTCcPxlfzDMBJw+XoKuOKYrzfET4LOoOeKRqLaWEhJApzRluL0eoABuLgw2kR522w==
X-Received: by 2002:a17:906:5596:: with SMTP id
 y22mr25110104ejp.471.1597846330661; 
 Wed, 19 Aug 2020 07:12:10 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47])
 by smtp.gmail.com with ESMTPSA id a26sm18536384eju.83.2020.08.19.07.12.09
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 07:12:09 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id a14so21702758wra.5
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 07:12:09 -0700 (PDT)
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr24104550wrn.385.1597846328915; 
 Wed, 19 Aug 2020 07:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <62e4f4fc-c8a5-3ee8-c576-fe7178cb4356@arm.com>
 <CAAFQd5AcCTDguB2C9KyDiutXWoEvBL8tL7+a==Uo8vj_8CLOJw@mail.gmail.com>
 <20200819135738.GB17098@lst.de>
In-Reply-To: <20200819135738.GB17098@lst.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 19 Aug 2020 16:11:52 +0200
X-Gmail-Original-Message-ID: <CAAFQd5BvpzJTycFvjntmX9W_d879hHFX+rJ8W9EK6+6cqFaVMA@mail.gmail.com>
Message-ID: <CAAFQd5BvpzJTycFvjntmX9W_d879hHFX+rJ8W9EK6+6cqFaVMA@mail.gmail.com>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_101212_393146_DF4245E9 
X-CRM114-Status: GOOD (  26.41  )
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
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 nouveau@lists.freedesktop.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 3:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 19, 2020 at 02:49:01PM +0200, Tomasz Figa wrote:
> > With the default config it doesn't, but with
> > CONFIG_DMA_NONCOHERENT_CACHE_SYNC enabled it makes dma_pgprot() keep
> > the pgprot value as is, without enforcing coherence attributes.
>
> Which isn't selected on arm64, and that is for a good reason.
>
> > AFAIK dma_cache_sync() isn't the only way to perform the cache
> > synchronization.
>
> Yes, it is the only documented way to do it.  And if you read the whole
> series instead of screaming you'd see that it provides a proper way
> to deal with non-coherent memory which will also work with arm64.
> instead of screaming
>

I'm sorry if I have offended you in any way, but would also appreciate
it if a less aggressive tone was directed towards me as well.

I have valid reasons to object to this patch, as stated in my previous
emails. The fact that the original feature has problems is of course
another story and, as I mentioned too, I'm willing to look into fixing
them.

I'm of course happy to review the rest of the series and even more
happy to help migrating this code to whatever is added there, as long
as the functionality is preserved.

> > By the way, as a videobuf2 reviewer, I'd appreciate being CC'd on any
> > series related to the subsystem-facing DMA API changes, since
> > videobuf2 is one of the biggest users of it.
>
> The cc list is too long - I cc lists and key maintainers.  As a reviewer
> should should watch your subsystems lists closely.

Well, I guess we can disagree on this, because there is no clear
policy. I'm listed in the MAINTAINERS file for the subsystem and I
believe the purpose of the file is to list the people to CC on
relevant patches. We're all overloaded with work and having to look
through the huge volume of mailing lists like linux-media doesn't help
and thus I'd still appreciate being added on CC.

Best regards,
Tomasz

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
