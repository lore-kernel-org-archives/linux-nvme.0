Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948EBC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 20:47:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CFE20890
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 20:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uvluRbL5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="imu7nPHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CFE20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ucsc.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ucpTBS0/k1/kLHLL769P9n5eU0VDsalU9igbzYeh8X0=; b=uvluRbL553S+4p
	XdSsm2nwpXFfBVgLANXaG6CFI7aRHwXDJ8UoiUJ+I2KKN/5yhMXoELXe7A230zKoM9g5Px/kKzeTw
	eHdYG+S44amhANn2LHfRxXIM5lMc+g5xCnvVWo3Ny/BwTS1NVsqb9CL73l/OFxy/mxAdIctgL5Y8n
	Kp/5+hJsBTgwPdWyp4LqqapwZmah5XVMZhVuRiD53BCF0opQ4vRGEOfXQc4pqYwwA0Wbc76cvwJPX
	VFs6PbC71PbrWfWrHPKGBq02nOcyIAunfqyQJGbc0HqjlJ33yfn8R2fZyj4Aim52YSrqDxGmV7/x+
	UU1RB/LP+jNJEUEAxATw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jm1Rg-0005g3-RA; Thu, 18 Jun 2020 20:47:36 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jm1Rd-0005fE-Ic
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 20:47:34 +0000
Received: by mail-ot1-x344.google.com with SMTP id g5so5647386otg.6
 for <linux-nvme@lists.infradead.org>; Thu, 18 Jun 2020 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ucsc.edu; s=ucsc-google-2018;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oCIz8rBcyOtzZ+pf5psWEfkMjtB5nSw0yMDYUhyKIo0=;
 b=imu7nPHeSFosqaUvtjQ93+rkE27kTrG1AuDzq38OZkZ4KIyxaSfqG/t/uJ+yONPwNJ
 0YZANWwY6yB+ApmmJ/XAO2txNHFU4hvwOSvNod6dVqg2q4wHW4OkrwLuW70vhvdpa4U3
 FGUta/WPtOAZrFWTvZ173FwIkDD+gjSx8c7p6uP43ew/pr4SupzvVWySo05j1Z4lstN9
 jtrUtO7ODxP/cGBBHyVpQk2MQ8WWQ3LxbRojhcW6IBgyQjaJkAXF+snMxVaNBxIro7Pf
 LYz4W1Omn5Ek/u7+Fg119AVl66icNJHZo6W9AB8eA7kf1rHxalL2Er0XAOSTOG7Gv3HT
 gCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oCIz8rBcyOtzZ+pf5psWEfkMjtB5nSw0yMDYUhyKIo0=;
 b=uaWALqJqfsi92935JBaH8pHUvt/2uX9UT9D0TrDZ6C/1N/BRdTPivZs6yuid3Zd73J
 +OsJJlYxCdPYhurRMVWVwirnHiELFQDAvJXgrFuzBuhCwnvuG+A4MYFp/BG3iWAb/BOr
 aYDtm4jdRoQlclNiCukJnOguCX/cNwyMz1+2fXvEGnKSe/MaC3AYtPfxFObEf5YN9RAu
 rnD1BpkzXe27s/S+kFVZzSgNgz3YRTbtvedBDjXgTzbYWqvJs48S0Ch8608xMZFR3mNi
 uEDIGGpZdTVvzfDVIaEkHWcxuv8uyIKEh1pvvO+wBolHTbeVCVmXGbtMdD8BxABby8ik
 Y7qw==
X-Gm-Message-State: AOAM5336BK578sApuGrHySnKXOO1HyY9cn9ftxXhZ8e3TwMvieVXSXyw
 apaeFKi/xJq60SHtm/EA6AdUJTsWWt50N4fsFAp2rQ==
X-Google-Smtp-Source: ABdhPJwCqJrVFPy1agTJt+A/o0Kg0zzaPnM6Yo6UXuyX5iMcAoHLSYvjs0Z96RcY8ycSHGJ0V6Vzcdi+i6iDm58//3k=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr431341oto.331.1592513251287; 
 Thu, 18 Jun 2020 13:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
 <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
 <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Thu, 18 Jun 2020 13:47:20 -0700
Message-ID: <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To: Damien Le Moal <Damien.LeMoal@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_134733_614817_BD82659A 
X-CRM114-Status: GOOD (  17.53  )
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
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 Ajay Joshi <Ajay.Joshi@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <Keith.Busch@wdc.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 Judy Brock <judy.brock@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks Damien,
the striping explanation makes sense. In this case will rephase to: It
is sufficient to support large enough un-splittable writes to achieve
full per-zone bandwidth with a single writer/single QD.

My main point is: There is no fundamental reason for splitting up
requests intermittently just to re-assemble them in the same form
later.

On Wed, Jun 17, 2020 at 10:15 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/06/18 13:24, Heiner Litz wrote:
> > What is the purpose of making zones larger than the erase block size
> > of flash? And why are large writes fundamentally unreasonable?
>
> It is up to the drive vendor to decide how zones are mapped onto flash media.
> Different mapping give different properties for different use cases. Zones, in
> many cases, will be much larger than an erase block due to stripping across many
> dies for example. And erase block size also has a tendency to grow over time
> with new media generations.
> The block layer management of zoned block devices also applies to SMR HDDs,
> which can have any zone size they want. This is not all about flash.
>
> As for large writes, they may not be possible due to memory fragmentation and/or
> limited SGL size of the drive interface. E.g. AHCI max out at 168 segments, most
> HBAs are at best 256, etc.
>
> > I don't see why it should be a fundamental problem for e.g. RocksDB to
> > issue single zone-sized writes (whatever the zone size is because
> > RocksDB needs to cope with it). The write buffer exists as a level in
> > DRAM anyways and increasing write latency will not matter either.
>
> Rocksdb is an application, so of course it is free to issue a single write()
> call with a buffer size equal to the zone size. But due to the buffer mapping
> limitations stated above, there is a very high probability that this single
> zone-sized large write operation will end-up being split into multiple write
> commands in the kernel.
>
> >
> > On Wed, Jun 17, 2020 at 6:55 PM Keith Busch <kbusch@kernel.org> wrote:
> >>
> >> On Wed, Jun 17, 2020 at 04:44:23PM -0700, Heiner Litz wrote:
> >>> Mandating zone-sized writes would address all problems with ease and
> >>> reduce request rate and overheads in the kernel.
> >>
> >> Yikes, no. Typical zone sizes are much to large for that to be
> >> reasonable.
> >
>
>
> --
> Damien Le Moal
> Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
