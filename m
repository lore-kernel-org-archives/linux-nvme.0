Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B4FC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 22:05:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D01207D8
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 22:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mfi6Geh4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="TWsaugqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D01207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ucsc.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=of6jZu+a+5QdLTnJBp0SsVy5/QvIOUU33FBh6JAeq0U=; b=Mfi6Geh4s2+0cQ
	qI9eP4YnyZsJAIDxtzyG3L0i9JcZ8HLlFSTrJRByzM4PHPKBg17zUoHZ6fLZpYlWxqueEmmk+SPY9
	cRRFTq523YVNjKiz43rStRQHxcLJ6+Kp9V4w6Q/V6sMdzt7Uyo3SEbbjPTcwi6rhtH/r2S0AeL54k
	x5SsSpFIrrob0TUChJotC4biYyTmGdid5VsNAXK2FUBPIVnMPtsb1pUlbaJ7TyW+SHv0Sl++KGIZT
	jqCZvL051Q0Yba+IIqE4veP0megnnwmYoFoWsdYlC+ghlD1Ek1F+Kt35b0IrNb5XCXsmm+z8TvTUq
	xPmmEzhRcKzCA+iPQKgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jm2fG-0008Ck-7H; Thu, 18 Jun 2020 22:05:42 +0000
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jm2fD-0008CK-KL
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 22:05:41 +0000
Received: by mail-oo1-xc42.google.com with SMTP id 127so1500299ooc.9
 for <linux-nvme@lists.infradead.org>; Thu, 18 Jun 2020 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ucsc.edu; s=ucsc-google-2018;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ukeJ1uDwqwEFaLI3EARWl0bw73efHeUYm2hJguJBEBo=;
 b=TWsaugqPxzvYuOI9ohFUzP1FTDrrg8y4AA/KmWfWmbczPncUMlMhThod3UZpj28ywk
 roaj/d/J45UjumfnOvFcM0Eo360LueE8Y4lftPmaDi0yK3Vc2EkliMkI7Wks15ZHZ96M
 Lq2uyX4V4UvfgEeZmSNRzyZedyj6WaphzMLs5b9wv0uOVWyy0SCfR2JnIgQkK6dtkg9p
 rO9jmbaqtq64Q4s1rxIr0t+03wrVVKgdxEv38hOq0NKuolFwNfmRde6yUSrB/WBYHsrR
 YWQTHJZxzhtvOagUiMX7GHoRaEjYWswuVodmZoffC8pZoTBUhdm1hF4YYIZhq62edZ9i
 Ck7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ukeJ1uDwqwEFaLI3EARWl0bw73efHeUYm2hJguJBEBo=;
 b=YSWxnOjklIZi45QGLWt4P2LjGlVIBemcVgwdg7NQjaIQ5m6571kEA10KldfYTfOBXH
 J6Xl7i27z5iCCwmYNbAfVjO9hwegcdfP2bG3gdGNmpQkHn1QpFPi0meSxiCork592EfM
 m2C3anwUCVZGBT/4tA7hxTaAgntETy2dup2dcxrsn2RD4tx1hORAweTxXUx7iHsVLNad
 IGMaxdTdFVs6Cez1kfJwKVFxjpgBOOnfFeQPSiLxA74e0F5tn6hHD3Ip/2f4kuorWW/Z
 sH186EpgURPbdGHRoLdnqJ9CEQ5IJx9GlIoFRT6QgJqXsmVJkI97do7QMRfIANmCjzfz
 6AkA==
X-Gm-Message-State: AOAM533kIDSgYG3M31q0L6jP4J0pow8P64uRJIC5+/HANJZmMSWW2sJL
 zyis7ttPD/FYWeYByrMP0yTtXBz5lzQ2I7OzFwbDOA==
X-Google-Smtp-Source: ABdhPJzgFvQAYhWUzETFTkrodlO0t+L2/qMyxslngVbk0NI8jAwHLqUx5rCztsTSMazNASVi9EBmZJo6GnZHM8bVwNI=
X-Received: by 2002:a4a:bc8c:: with SMTP id m12mr911865oop.44.1592517938482;
 Thu, 18 Jun 2020 15:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
 <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
In-Reply-To: <20200618211945.GA2347@C02WT3WMHTD6>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Thu, 18 Jun 2020 15:05:27 -0700
Message-ID: <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_150539_669105_AB17E68C 
X-CRM114-Status: GOOD (  14.30  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Ajay Joshi <Ajay.Joshi@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 Judy Brock <judy.brock@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Matias, Keith,
thanks, this all sounds good and it makes total sense to hide striping
from the user.

In the end, the real problem really seems to be that ZNS effectively
requires in-order IO delivery which the kernel cannot guarantee. I
think fixing this problem in the ZNS specification instead of in the
communication substrate (kernel) is problematic, especially as
out-of-order delivery absolutely has no benefit in the case of ZNS.
But I guess this has been discussed before..

On Thu, Jun 18, 2020 at 2:19 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Jun 18, 2020 at 01:47:20PM -0700, Heiner Litz wrote:
> > the striping explanation makes sense. In this case will rephase to: It
> > is sufficient to support large enough un-splittable writes to achieve
> > full per-zone bandwidth with a single writer/single QD.
>
> This is subject to the capabilities of the device and software's memory
> constraints. The maximum DMA size for a single request an nvme device can
> handle often range anywhere from 64k to 4MB. The pci nvme driver maxes out at
> 4MB anyway because that's the most we can guarantee forward progress right now,
> otherwise the scatter lists become to big to ensure we'll be able to allocate
> one to dispatch a write command.
>
> We do report the size and the alignment constraints so that it won't get split,
> but we still have to work with applications that don't abide by those
> constraints.
>
> > My main point is: There is no fundamental reason for splitting up
> > requests intermittently just to re-assemble them in the same form
> > later.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
