Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2873DE674AC
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 07:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=waUbj49118u4i7q+4ovU4pXPxCZS6UmbTpIEMIVVinY=; b=4JvzMFekslvuOpzES7xL4q9R6c
	KDkHHEVfj9Zdn5wYU+7IMcWXYac1+izAf+ioCsKoOm5wALn/fizZarSEFXPPz00Pfx0JUiKcKUP6f
	sLkLqq/grKX9J10LjTIzxWh/c8GPERiivnj/hAR9uFVv6bqfN2VCnUrDX77XYUwMtBybXNvZh82N/
	sA2+2kyz2hWxTbmf690gQxTYcphd1LAcsQtMMzO2QTwKxDbzepgJ6V7DDjjQVPxUUTxQPjc41KSKo
	fD+NcPqiF0A3VDM1olw1NzfIbP7L8DydLHlmJOlXgdr4GzEjyMCFhr5Cbx4eCeQLxrwTUydYscte9
	BkAbdCdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6m5F-000000066pV-1Mzq;
	Fri, 01 Nov 2024 07:28:37 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6lth-000000065K9-43E5
	for linux-nvme@lists.infradead.org;
	Fri, 01 Nov 2024 07:16:43 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so1484060a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 01 Nov 2024 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1730445400; x=1731050200; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waUbj49118u4i7q+4ovU4pXPxCZS6UmbTpIEMIVVinY=;
        b=utB1Ft4Txbbf+4CroLbd02WTrWhKaKc28NZXx5VZxbOOwq2zOdUf/kjiCw2O86rrmM
         RvKm2z1uDAatVVWfjYEnbHPLLYBZqN3JigyQTiC5vcX8vcryVbfzPkniuaCyj8J1eiFZ
         CkMnfRigMKwJXeWCkGCs2lUtcr4tAQRBbZ8gLmmXkYd8OqXJVa8GWMxZyTHaY/+U42Ut
         qdBRSA2X6fZxKj8WBFGcYdVlJsNKHYZnBtN/0dKg3Bkav88fxWuotbGOfLCgMLI2KPJO
         mJH28tj8c7tGIcqWIKgKThBfPa79XRGE9rjqnxRfUVR6KmWZcYJ6xyGdI8zElJIAbbUd
         Rstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730445400; x=1731050200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waUbj49118u4i7q+4ovU4pXPxCZS6UmbTpIEMIVVinY=;
        b=PWKe4zfnANKiOBCd+nyd3elHwUc5MjufuZjdK5aVmUYmkVCcwJte67mmojW841vpJq
         FVX3QhMS5oqiMPrweNB0bkoBhRq0BDc5aZwxm3l570fqVYAJngMdwWowomvTnqG0SkJ3
         9X8aQ2bwRTi/2znb3b11RvOh4iq+zy2SxaFguD+Qie9IlOjl+MB5kG1+ZJ0uiQWUzEKe
         U4H3fRASoMpEWKRRS5V71HN7ZK6Lbv2NxJrIrh2X9ro9TkxPdFfY+iJaUX92FzEqyvu5
         xMUnojhQzfUqjYon5FIF63r+SuSeAjWsQDjkgq7yByrFyDNfXNpyyR/LWUtwFLCgafsh
         vfNw==
X-Forwarded-Encrypted: i=1; AJvYcCXz+McZ1cshrHchHDpnFiVHpuSyI6a4mFxf+Ql+Q9vRkVV/RGswXNoiuQOEVTjJBP79BujR8/1T5X2B@lists.infradead.org
X-Gm-Message-State: AOJu0YwvorQ6FdaQpMQiOu7x3sNB/zCNyc7Zzk28RIDNw3htbY0DL+AL
	/Yr6U/mMX+CNl9M7wBdWt79A2ImXtkGkhKmmUN7/ch74H5PhdgM7rZnn7Fo6WohKNp5Lxi0k13B
	GMLon1H8Uqy0tDowVRkEqjXHNJgqG1CSrZCgYtA==
X-Google-Smtp-Source: AGHT+IGPuhXjQfdSyl9CCnBDb8kfQdLr1OP5WRts8Y+TKi58ZMd9VxEJGiFKfBDiAyZu0iCHQTVa3iEX7i7W0CHxx4g=
X-Received: by 2002:a17:907:7e8f:b0:a99:dde6:9f42 with SMTP id
 a640c23a62f3a-a9e50b935bcmr454552666b.47.1730445399842; Fri, 01 Nov 2024
 00:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de>
 <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com> <20241030154556.GA4449@lst.de>
 <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com> <20241030155052.GA4984@lst.de>
 <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com> <20241030165708.GA11009@lst.de>
 <ZyK0GS33Qhkx3AW-@kbusch-mbp.dhcp.thefacebook.com> <CANr-nt35zoSijRXYr+ommmWGfq0+Ye0tf3SfHfwi0cfpvwB0pg@mail.gmail.com>
 <ZyOO4PojaVIdmlOA@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZyOO4PojaVIdmlOA@kbusch-mbp.dhcp.thefacebook.com>
From: Hans Holmberg <hans@owltronix.com>
Date: Fri, 1 Nov 2024 08:16:30 +0100
Message-ID: <CANr-nt30gQzFFsnJt9Tzs1kRDWSj=2w0iTC1qYfu+7JwpszwQQ@mail.gmail.com>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, 
	javier.gonz@samsung.com, bvanassche@acm.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_001642_297048_B5A76EFC 
X-CRM114-Status: GOOD (  25.54  )
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

On Thu, Oct 31, 2024 at 3:06=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Thu, Oct 31, 2024 at 09:19:51AM +0100, Hans Holmberg wrote:
> > On Wed, Oct 30, 2024 at 11:33=E2=80=AFPM Keith Busch <kbusch@kernel.org=
> wrote:
> > > That is very much apples-to-oranges. The B+ isn't on the same device
> > > being evaluated for WAF, where this has all that mixed in. I think th=
e
> > > results are pretty good, all things considered.
> >
> > No. The meta data IO is just 0.1% of all writes, so that we use a
> > separate device for that in the benchmark really does not matter.
>
> It's very little spatially, but they overwrite differently than other
> data, creating many small holes in large erase blocks.

I don't really get how this could influence anything significantly.(If at a=
ll).

>
> > Since we can achieve a WAF of ~1 for RocksDB on flash, why should we
> > be content with another 67% of unwanted device side writes on top of
> > that?
> >
> > It's of course impossible to compare your benchmark figures and mine
> > directly since we are using different devices, but hey, we definitely
> > have an opportunity here to make significant gains for FDP if we just
> > provide the right kernel interfaces.
> >
> > Why shouldn't we expose the hardware in a way that enables the users
> > to make the most out of it?
>
> Because the people using this want this interface. Stalling for the last
> 6 months hasn't produced anything better, appealing to non-existent
> vaporware to block something ready-to-go that satisfies a need right
> now is just wasting everyone's time.
>
> Again, I absolutely disagree that this locks anyone in to anything.
> That's an overly dramatic excuse.

Locking in or not, to constructively move things forward (if we are
now stuck on how to wire up fs support) I believe it would be
worthwhile to prototype active fdp data placement in xfs and evaluate
it. Happy to help out with that.

Fdp and zns are different beasts, so I don't expect the results in the
presentation to be directly translatable but we can see what we can
do.

Is RocksDB the only file system user at the moment?
Is the benchmark setup/config something that could be shared?

