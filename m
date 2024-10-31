Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DE4E68944
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 08:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fHihNpINELIVjK3l3rTKLlYaMgvUEcgArJNIc8J5kNA=; b=xm3M+HnRm4TOEcmHs05kfZfgf6
	q1KUZmvBuxgoIy1u7wjLygnqtlq3PunSsTbDS+QyxvKHw5BZ1unkcxFD3xxI2xZ2GYEDeY8/3QxPq
	TcW4KHXD5PXhzRDMNHlmdaN7Q3rVs23aIRhPIFeYdsx6nwak7NZ1OGh8QK3/bguqdpsi9UaRUw/r0
	MFNZArKt2+iuHuUkn9cBSBTjtjTGuEUBNQTJAqaJclbydPii4HiVqJWd9nec2PTZqgQ5/6zBESgkl
	5owhYdqiImyZNOb6vzHrjr7SKXtO79fB6fxCCYS6NeSCCv7wfoN1SPvUJFsOcJqlH0BExTBuJnDi0
	cbfyckbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6QPW-00000002vW5-1Toj;
	Thu, 31 Oct 2024 08:20:06 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6QPT-00000002vV7-1Syl
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 08:20:05 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so929290a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 31 Oct 2024 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1730362800; x=1730967600; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHihNpINELIVjK3l3rTKLlYaMgvUEcgArJNIc8J5kNA=;
        b=tLRtWO8m9sXkiYJCVmf+V4E6efjtUwCithXvZfxr6BfMu9tbBKIuW/fqcukpq/yhTQ
         KJUF/LJLMOwEofaCgZTG/d6/0+EzlyE7y6hJ18PHAq3gTEDos1HyCI4OcBpmBOD7mWgG
         +JLTIj6kvkPPfcskt4/R97grt7ViA2/PqUz+416R/ozASoS3YVk/jmTcpKecaIkAM5G2
         Cg5ivcODEOBLSFA6/o/uwpc2OZtcKOsWqGkC8z9YueIKK7irA2FHIBleVDLtlfkYdiVR
         Bv3Zwt+at16JP24R5UsHULR5+43qYAHaa/+DMW0BDVEarsUPG8wdpe4R6ciu2+DIC4+3
         vsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362800; x=1730967600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHihNpINELIVjK3l3rTKLlYaMgvUEcgArJNIc8J5kNA=;
        b=C1Zj7VtbhlEJQVnIhI6q3Bl2Y+FAadQuHCkNdN0rdH6bv5DTMRRl89uOQqaO9KoKX8
         Tl20pNO2+iWAZkxMY5PUfH1fHwHu0BczzZLErhx71Mer70AtXpKYAdr+Waz3m53bSgN2
         2jQp2ncT4hHUMJCJjSFQguqljNc29McefiXhiB9jZX3DdjnyYLbbtMWs8YCzBb/XvEQu
         +Td5NseoLS38h64r8S+6FsttvXLtp0tJYG9Hy0JB3ypyLvpyQaFkmivLfp/+SpFwr40j
         bI0x68OBDP4sxBOazrWY3t/mmVWYLjPrETgNljqrXIaveOaiYYDJVB7AfGvEivElKnRk
         tMsg==
X-Forwarded-Encrypted: i=1; AJvYcCXcssflAf7JHjGXxcCmNYEs1A2F49yceD5BBCzvwRMWWDCdnehYmytsa6sf4Dk+kL0YGtSku8jHM/io@lists.infradead.org
X-Gm-Message-State: AOJu0YzlFSj/K/xTJIhwyeqMtva9FVwhYI5bUJRFdRAg3VNXZBizOD6G
	roLA0Dzg9tcOgXWd3NTgiOv2wUrxZEtvvzassvy4h/0DYtz+OUPe9Kzn0pLDvxqd1skH2IwPFiH
	vfTYX9d/5YDExcLBWULk0Ubj1s2d3gpJlufH5+w==
X-Google-Smtp-Source: AGHT+IH8+r7Wg2Co4/bqHDcfHF1OtsjwdU/NhWvyCsNdTstwhoydYvHp6WgT8/ZbDKKPHXfyJqAdxDuKmLBM29l3xGo=
X-Received: by 2002:a05:6402:13c7:b0:5c9:547d:99 with SMTP id
 4fb4d7f45d1cf-5cbbf889742mr15743282a12.2.1730362800416; Thu, 31 Oct 2024
 01:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <ZyEBhOoDHKJs4EEY@kbusch-mbp> <20241029155330.GA27856@lst.de>
 <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de>
 <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com> <20241030154556.GA4449@lst.de>
 <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com> <20241030155052.GA4984@lst.de>
 <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com> <20241030165708.GA11009@lst.de>
 <ZyK0GS33Qhkx3AW-@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZyK0GS33Qhkx3AW-@kbusch-mbp.dhcp.thefacebook.com>
From: Hans Holmberg <hans@owltronix.com>
Date: Thu, 31 Oct 2024 09:19:51 +0100
Message-ID: <CANr-nt35zoSijRXYr+ommmWGfq0+Ye0tf3SfHfwi0cfpvwB0pg@mail.gmail.com>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, 
	javier.gonz@samsung.com, bvanassche@acm.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_012003_622745_29935BA0 
X-CRM114-Status: GOOD (  18.95  )
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

On Wed, Oct 30, 2024 at 11:33=E2=80=AFPM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Wed, Oct 30, 2024 at 05:57:08PM +0100, Christoph Hellwig wrote:
> > On Wed, Oct 30, 2024 at 10:42:59AM -0600, Keith Busch wrote:
> > > With FDP (with some minor rocksdb changes):
> > >
> > > WAF:        1.67
> > > IOPS:       1547
> > > READ LAT:   1978us
> > > UPDATE LAT: 2267us
> >
> > Compared to the Numbers Hans presented at Plumbers for the Zoned XFS co=
de,
> > which should work just fine with FDP IFF we exposed real write streams,
> > which roughly double read nad wirte IOPS and reduce the WAF to almost
> > 1 this doesn't look too spectacular to be honest, but it sure it someth=
ing.
>
> Hold up... I absolutely appreciate the work Hans is and has done. But
> are you talking about this talk?
>
> https://lpc.events/event/18/contributions/1822/attachments/1464/3105/Zone=
d%20XFS%20LPC%20Zoned%20MC%202024%20V1.pdf
>
> That is very much apples-to-oranges. The B+ isn't on the same device
> being evaluated for WAF, where this has all that mixed in. I think the
> results are pretty good, all things considered.

No. The meta data IO is just 0.1% of all writes, so that we use a
separate device for that in the benchmark really does not matter.

Since we can achieve a WAF of ~1 for RocksDB on flash, why should we
be content with another 67% of unwanted device side writes on top of
that?

It's of course impossible to compare your benchmark figures and mine
directly since we are using different devices, but hey, we definitely
have an opportunity here to make significant gains for FDP if we just
provide the right kernel interfaces.

Why shouldn't we expose the hardware in a way that enables the users
to make the most out of it?

