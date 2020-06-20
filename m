Return-Path: <SRS0=PJ7C=AB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0EAC433DF
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Jun 2020 17:52:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09EA2405E
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Jun 2020 17:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DbA5K3RE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="UTbTzGsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09EA2405E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ucsc.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o2U3xBb60hOIbGhm0aP1wo9Yh7HK1A+oxGMB73nJzPA=; b=DbA5K3REYDkp22
	SCrhJj0N0XZdTnQa3VsyObAl19SbpVYZ2cCY2y+D96K9rozPbKWOVO3RVX4mMa9IJ0SGr481kXYDp
	siK+F8DzlF9qSzriOwNxhmMbN4pm2eFn611zDKmxtgAD23urwmwL447/aNkyT33aoDj5v+d5Uon0A
	lwTzdwNV2Gwc6/BnZehFk5oxwegS7Shq/aksq+ebqaAq8a3pqMPyERiQCLhpLIlquORr+xk9W0ns0
	M2gr0g1yJBjwKurQGdll+ouiN2t0/40PjOIvxPDOWKkCgI2RnpLsLSdxTZVAwkw+NwInlz7Eix/Pl
	EVVGHkZ4k0bJNvprfPLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmhfR-0000J9-0y; Sat, 20 Jun 2020 17:52:37 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmhfN-0000Iq-Lf
 for linux-nvme@lists.infradead.org; Sat, 20 Jun 2020 17:52:34 +0000
Received: by mail-ot1-x341.google.com with SMTP id s13so9829660otd.7
 for <linux-nvme@lists.infradead.org>; Sat, 20 Jun 2020 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ucsc.edu; s=ucsc-google-2018;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8Mz+T0R3CmrVkyAiLGaJ8kfGJk+hpqodjeuLQrL/aRA=;
 b=UTbTzGsbWCKY/FImoY5WfQYJ7oZQz6/Ykxs8LQYJMijNBHRsKDLOXj/FjddGttn6qx
 kCa13NDUM5mZK78I7Q2goO+/lgcuR2s8zgvKdXPVCUyPnDJgCSkzwtW0T6YQ7v9rSyx4
 uS1E49tNhzLY3qcO8SVTQmAq0x5hf9Hjpoid/6a/LL0Y03UFgfI4Bg6SmxN6AI8dty75
 7q4jKtGdH3WQT8cI5+Wuzm3J7Kz/LCTFsTqcPITvQAsI4aAXhVPdqlN0H6TaM0bZR6c4
 Kx+9/PHkDkRoXrIn+j5LJ6IwGNfb0Ulwa344Vo4VDrKj+WUmFjgztCsMmvpDGt7yK/gJ
 2uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8Mz+T0R3CmrVkyAiLGaJ8kfGJk+hpqodjeuLQrL/aRA=;
 b=XDPIvnwEPXG5pR4xRzPUrKaFFxmt5sDhjqFPAxjvXIh9stEx39fNzKu6OFQJhNJDQJ
 7OnjChn/nYuuy36VJDiCK5CnCNgzlUBhOArUb4kWkychVM9ClGrB66CSTHoVxROEqtFL
 KjWd7lUDY1IesOsUxZ7/HTTUPKQ0zo4eXD4LPk2/nyjpoymCcrKHw6ZvUM8VATt/gJF7
 Qm1a/gJGR6b2BVe1y2W/mOJF2rraGs3A24WJS6tU/2jjtumF4Kcg9NyHXU9uyuRiGJeY
 /3L8V3CeQ+mdRABAkcqM5MZm2OJhfuN3RlQQZCg/70n+5z3M3xSks0m6ZD8Cg8NFtqgW
 n5kQ==
X-Gm-Message-State: AOAM532osOT5WTK/lnU6vhOOps+KRTDqVmGRd7h+L0mnrW2X1aztNge8
 pe/IQacx+WoXIBr+FyErAjFUy3A5ppLnH4avB5EsQg==
X-Google-Smtp-Source: ABdhPJxG+NI+bUalvZTD9CwojB6vkCx6LZzpiseaSnMY0H1DGp8x/RDwPQKR3Fz+UXS/Hl1LCzDCAnWHbKU8D+6S4Y0=
X-Received: by 2002:a9d:4503:: with SMTP id w3mr7491080ote.38.1592675552497;
 Sat, 20 Jun 2020 10:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
 <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
 <20200620063301.GA2381@lst.de>
In-Reply-To: <20200620063301.GA2381@lst.de>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Sat, 20 Jun 2020 10:52:21 -0700
Message-ID: <CAJbgVnUFzP27Nx2jr4rLOuw9J0C5dRDdD+LfFMCwHY3=oBDYDw@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200620_105233_712946_28E44486 
X-CRM114-Status: GOOD (  12.10  )
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
 Hans Holmberg <Hans.Holmberg@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 Judy Brock <judy.brock@samsung.com>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I don't remember saying that I don't understand the basics of NVMe, so
I am not sure where you got this from.

That being said, the point I am trying to discuss is not about NVMe in
particular. It is the general question of: What is the benefit of
splitting and reordering (on whatever layer) for a hardware device
that requires sequential writes? I claim that there is no benefit.

I have worked with SSDs in the past that exposed raw flash blocks over
NVMe and that achieved maximum write bandwidth without append by
enforcing splitting/ordering guarantees, so I know it is possible.

I will accept that there is no interest in discussing the question
above, so I'll stop here.

On Fri, Jun 19, 2020 at 11:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 19, 2020 at 11:08:26AM -0700, Heiner Litz wrote:
> > Hi Matias,
> > no, I am rather saying that the Linux kernel has a deficit or at least
> > is not a good fit for ZNS because it cannot enforce in-order delivery.
>
> Seriously, if you don't understand the basics of NVMe can you please stop
> spamming this list with your crap?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
