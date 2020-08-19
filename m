Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C332C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 13:58:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E942076E
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 13:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BXcvQo0I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m4IkKgPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E942076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q0cjIXGbK+73RLfyJAT3YYodboIdkh6kXKNhqiOMlQM=; b=BXcvQo0IuW4YOHmggZFtWssT3
	pEn84GslbA9t7ItE3JP0uC7WrhMM/PBPHFHgplm/iPuJAae3FgFjXrcIR8xWRZMyinSFKS/7JBeTG
	6PT+ZI5pSkwn4fqFawI+rbq4G0DpVIt4UNLUIH8Koennw+7j73KXs5PlLJRW6Qij7nBWVAwI71OVm
	+ZHn7tdLKbCB+B6Yk6QGhg9ALwOSf7M7p2dr0sdxwZu4bDhBYGA94JnHTxFAGi+jABxqcbjF0onz2
	sR8rfoeSPYOnxe1O+sa/gaE1pK2MY9z2GhM9JCzDtg7oMzq2cxz12KtVddrS/bMUz6p21SO8nvRlB
	ogctRXTug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8ObY-0007ac-Qr; Wed, 19 Aug 2020 13:58:16 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8ObV-0007Yt-JW
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 13:58:14 +0000
Received: by mail-ej1-x644.google.com with SMTP id t10so26400437ejs.8
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6xkguvOzsgzZf/2nZcmiUdLktaalZbMKG8kwCTKJnbQ=;
 b=m4IkKgPlDJh9Ow/m1Q5dtgZrYLnaRCS7od5vd7CevPl4aSkNJcXDYSbofI9IVrnSM1
 T0Nk8lAEv28vGxYfqJpLVc+ygPg3eNS610ZSiKpYmXTIZXUzbw+fr6qoGPkql89ad0SH
 sz82upHUpsjkfyqDK6oYGAHuFg3NLWv3KpWnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6xkguvOzsgzZf/2nZcmiUdLktaalZbMKG8kwCTKJnbQ=;
 b=fKYyuhpfPvHQa3MFEANViOn96meEwj6gYme4/j7kj783JmJINHOtmnjb3OOIa1HvQX
 Ch1tJZalA1l6yuiE1YjitvyScKQhl2AZdCJn3s4s7XkfEl0xdMfhs595M8hJNr0i/IKW
 jAiw5ILni4U4N7ohLxelGTGUpIR9mJoBH/VarwwO5sP00kKQhJMsdl/PQdw6jo8q4vpo
 zrJRnsFAv4ZWwia/LJIWH42YYlQNSO2Yi5ltywY/nqfCLZ9OI+fKTtcSBczykIHD4CYb
 gv6zBXGbviSgYHYQ5T96dSBkoICPkgOoyDXrCFNuPCSAdPD/LcdYjXzkZUcRHEHw9Ver
 J2Vw==
X-Gm-Message-State: AOAM5315wu0e9NgSU0JMaFJX9OrpFdlM7dBiVp74W2y9OP3rFN1labIw
 BDEjCxBSFPgOoODONPSeKrGo4nz2vtRJsA==
X-Google-Smtp-Source: ABdhPJy/cfJel72sPCEsw4RFz4EHVpYoYc3w95wnVDKRDhQou7PFalRdyzFX3AHuhB39/73MJowckA==
X-Received: by 2002:a17:906:c187:: with SMTP id
 g7mr4516153ejz.108.1597845492045; 
 Wed, 19 Aug 2020 06:58:12 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com.
 [209.85.128.43])
 by smtp.gmail.com with ESMTPSA id cn27sm18274093edb.4.2020.08.19.06.58.11
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 06:58:11 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id f18so1734306wmc.0
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 06:58:11 -0700 (PDT)
X-Received: by 2002:a1c:5581:: with SMTP id j123mr5137250wmb.11.1597845489930; 
 Wed, 19 Aug 2020 06:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <20200819135454.GA17098@lst.de>
In-Reply-To: <20200819135454.GA17098@lst.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 19 Aug 2020 15:57:53 +0200
X-Gmail-Original-Message-ID: <CAAFQd5BuXP7t3d-Rwft85j=KTyXq7y4s24mQxLr=VoY9krEGZw@mail.gmail.com>
Message-ID: <CAAFQd5BuXP7t3d-Rwft85j=KTyXq7y4s24mQxLr=VoY9krEGZw@mail.gmail.com>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_095813_882180_5CDB39CE 
X-CRM114-Status: GOOD (  19.57  )
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
 linux-mm@kvack.org, Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-mips@vger.kernel.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 3:55 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 19, 2020 at 01:16:51PM +0200, Tomasz Figa wrote:
> > Hi Christoph,
> >
> > On Wed, Aug 19, 2020 at 8:56 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > The V4L2-FLAG-MEMORY-NON-CONSISTENT flag is entirely unused,
> >
> > Could you explain what makes you think it's unused? It's a feature of
> > the UAPI generally supported by the videobuf2 framework and relied on
> > by Chromium OS to get any kind of reasonable performance when
> > accessing V4L2 buffers in the userspace.
>
> Because it doesn't do anything except on PARISC and non-coherent MIPS,
> so by definition it isn't used by any of these media drivers.

It's still an UAPI feature, so we can't simply remove the flag, it
must stay there as a no-op, until the problem is resolved.

Also, it of course might be disputable as an out-of-tree usage, but
selecting CONFIG_DMA_NONCOHERENT_CACHE_SYNC makes the flag actually do
something on other platforms, including ARM64.

Best regards,
Tomasz

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
