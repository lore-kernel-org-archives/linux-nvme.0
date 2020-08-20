Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E763C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 10:12:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E54C206DA
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 10:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lnk0v+sS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="foA95pAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E54C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d2npsPOmYAFS1J8DBeg7bZSyHr3fJgmX8qgnPqVBfPU=; b=Lnk0v+sS1p4d//q6G20IQEvmX
	twsOtLXyX/fJP0/tQZffJ0rfvsM9o3BTHCrcMgOo0F8zLcF2/NSw01nfmYEBuMUNMD1/vOKqY01Gt
	t1r2PBuW2amgjpDkM4fsb+ZzL2AZ9mVV+c69TxA/ki8DBh0Zkm+sir0fgouVDJjTfzl+sEO+SyO10
	XNTfkkuzpQkkivZo94f753RRApmq9NGY1srrgfjw1Tp9YdFlBOvJ/d9UW6JYo4rXIt8N51Xhgmg7O
	czLOIUmeNV4q3spPR2EhDEZd7zoYi/rvzUxLx1TYKFrsaayUHWQw8zd76HYgRfB/NDqEPYClmcWSt
	LO9Wj4eMQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8hYm-0006Sj-9H; Thu, 20 Aug 2020 10:12:40 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8hYk-0006S5-Jk
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 10:12:39 +0000
Received: by mail-ed1-x541.google.com with SMTP id cq28so1122894edb.10
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pbe+IJf4ZBxt6yUxRRrQR1l3UQTW2eLx6AT4PE1gQKg=;
 b=foA95pAMne0k+ZduK2+JsEaA0Kd3Xk6AJeP12ZUtsQO8oCEqpY6AC2jWiQeJjjQrKA
 n//Z/S/hwU9sUSwrh2bpFx9EjO5w8H5vkm5cyHDHvlSF0L7E3fVBHC7P2Ym9zd8UwQZN
 UTTFBKoIkLT88Lc8FZLz7dV6a5Tegh0nandB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pbe+IJf4ZBxt6yUxRRrQR1l3UQTW2eLx6AT4PE1gQKg=;
 b=FJqf7ZjV25BUK3OyPz54y+qTnuqsTLs0pVfYXDqcIYGxHRMc29XAMmcRGVH2P1PcV0
 8RueX9J/qNh3WjwB0eUHwnNa6Hd4xCDpUZ4u41b950Hhqb672I0NKUAuEtGuicB0Hd1d
 PYNdbUy9hvl5tvSvZzdREUnDnQcI0wVnZhA3DVgQJwsf97Z/y7CbyHdMUZ1k9a1Cl66E
 NWOVZqjGcGeNZKaXmVN2BZORr0fDyHGBmTPd+C+JfvzgHQk5hWRjgDBcaYopaljZvmIQ
 eFOVnGjf2mBiBuw8ErlAaoFi5imHENljE7sTCgnqD69OJ80ttv1aMjMKDQE3SdaJbVwi
 eRVA==
X-Gm-Message-State: AOAM532sSiY7SWRnCHhhHWaJYTob10bvM/NsNEBtQFixB3SaI9Vf/WPL
 YYLGuoDTk+4FFEmDBNMDJZadhZQmqA1iCr1Q
X-Google-Smtp-Source: ABdhPJyhC6atbg/ogGQ8IISZzfBzSrLplFY5VD3D5GNaS3kguYW5xOj7X0euTNwK4C47wWoBAaGBkw==
X-Received: by 2002:aa7:c70b:: with SMTP id i11mr2111225edq.272.1597918357257; 
 Thu, 20 Aug 2020 03:12:37 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44])
 by smtp.gmail.com with ESMTPSA id d20sm1144462ejj.10.2020.08.20.03.12.36
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 03:12:37 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id bs17so1155653edb.1
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 03:12:36 -0700 (PDT)
X-Received: by 2002:a5d:6744:: with SMTP id l4mr2628495wrw.105.1597917944145; 
 Thu, 20 Aug 2020 03:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <20200819135454.GA17098@lst.de>
 <CAAFQd5BuXP7t3d-Rwft85j=KTyXq7y4s24mQxLr=VoY9krEGZw@mail.gmail.com>
 <20200820044347.GA4533@lst.de> <20200820052004.GA5305@lst.de>
In-Reply-To: <20200820052004.GA5305@lst.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 20 Aug 2020 12:05:29 +0200
X-Gmail-Original-Message-ID: <CAAFQd5CFiA2WBaaPQ9ezvMjYZfNw37c42UEy9Pk7kJyCi1mLzQ@mail.gmail.com>
Message-ID: <CAAFQd5CFiA2WBaaPQ9ezvMjYZfNw37c42UEy9Pk7kJyCi1mLzQ@mail.gmail.com>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_061238_752312_6437E828 
X-CRM114-Status: GOOD (  26.90  )
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-mips@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 20, 2020 at 7:20 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Aug 20, 2020 at 06:43:47AM +0200, Christoph Hellwig wrote:
> > On Wed, Aug 19, 2020 at 03:57:53PM +0200, Tomasz Figa wrote:
> > > > > Could you explain what makes you think it's unused? It's a feature of
> > > > > the UAPI generally supported by the videobuf2 framework and relied on
> > > > > by Chromium OS to get any kind of reasonable performance when
> > > > > accessing V4L2 buffers in the userspace.
> > > >
> > > > Because it doesn't do anything except on PARISC and non-coherent MIPS,
> > > > so by definition it isn't used by any of these media drivers.
> > >
> > > It's still an UAPI feature, so we can't simply remove the flag, it
> > > must stay there as a no-op, until the problem is resolved.
> >
> > Ok, I'll switch to just ignoring it for the next version.
>
> So I took a deeper look.  I don't really think it qualifies as a UAPI
> in our traditional sense.  For one it only appeared in 5.9-rc1, so we
> can trivially expedite the patch into 5.9-rc and not actually make it
> show up in any released kernel version.  And even as of the current
> Linus' tree the only user is a test driver.  So I really think the best
> way to go ahead is to just revert it ASAP as the design wasn't thought
> out at all.

The UAPI and V4L2/videobuf2 changes are in good shape and the only
wrong part is the use of DMA API, which was based on an earlier email
guidance anyway, and a change to the synchronization part . I find
conclusions like the above insulting for people who put many hours
into designing and implementing the related functionality, given the
complexity of the videobuf2 framework and how ill-defined the DMA API
was, and would feel better if such could be avoided in future
communication.

That said, we can revert it on the basis of the implementation issues,
but I feel like we wouldn't get anything by doing so, because as I
said, the design is sane and most of the implementation is fine as
well. Instead. I'd suggest simply removing the use of the attribute
being removed, so that the feature stays no-op until the DMA API
provides a way to implement it or we just migrate videobuf2 to stop
using the DMA API as much as possible, like many drivers in the DRM
subsystem did.

Best regards,
Tomasz

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
