Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68972D60CF8
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G+3poB3x8mZCJHYB5+EbW5zk8iU8fuUhZ00XiU/us+Y=; b=NmD4wwi5tf83l7W+ci7K2Il7/m
	4SWNTCSUXHoJNC8S3GnCs5aLgIzm81TGTLyGEWU7Vfr/dgQK3BzWCfuNvJrh3/J/ppsQ4vCrVNp2Y
	ZDfuGQ2RhsP5uUarAscRT6cEFRybu/arluDbwWY0IncIPn4KwNX/gLAkxFUIUDlCApspcYIvXj0z5
	knGPaeuvWam8C5yjqJH5xTGJDKRI26BllGPetVi8IVA2bZgM6jyN6HsdbEYV3CmznR67AgD7kikE8
	iEBhAmFwxUF+EskqTzGmrxb1HRoMkwrDJt4/i8dHZde1zfJIo1FJGtWC6UMo5sTHJqLHS/5V1ZvP6
	gNAqkjIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDBIx-0000000Aruo-3DRD;
	Mon, 18 Nov 2024 23:37:15 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDBIv-0000000AruM-0pvf
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 23:37:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9D9F3A41D8B;
	Mon, 18 Nov 2024 23:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DFCC4CECC;
	Mon, 18 Nov 2024 23:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731973031;
	bh=ZYSc0BBh4PSuJUUQjsGASqp+WcLtE6wE2Rh9sEwzRfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsGnLRoET2OJq/9T7ye05AJbXGLHMVOdvqD92UeO1KjBLRaYL/vU2NQXyQbyinnxd
	 BSXwXPCTEMvgawu2F4Ha+n/kbkv89ZtK6Zqrq7h8e3MJiOtAtXADgoxCJnI8WdiatC
	 Ptv67gmVcHDPuSGqIbOF0xQtcdaYKBsurC1wTKV1RA3gq3HowmIYGSon1xJBjXACQI
	 vuGL1RSPlzKvIz6VuWkKhiXxUhiFuLOmqv8+5n/wzIFBU/CBMGW9hWrbsoK8CQcvfq
	 a5m8oYckiwgXQdb1gmYCF8Oxfyi1Lakb8jB+2SZTmYnsUEwbAt/sgU3jHWDXACFnS0
	 SSJBUq6knwMKA==
Date: Mon, 18 Nov 2024 16:37:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>, Pierre Labat <plabat@micron.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [EXT] Re: [PATCHv11 0/9] write hints with nvme fdp and scsi
 streams
Message-ID: <ZzvPpD5O8wJzeHth@kbusch-mbp>
References: <20241111102914.GA27870@lst.de>
 <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com>
 <20241112133439.GA4164@lst.de>
 <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com>
 <DS0PR08MB854131CDA4CDDF2451CEB71DAB592@DS0PR08MB8541.namprd08.prod.outlook.com>
 <20241113044736.GA20212@lst.de>
 <ZzU7bZokkTN2s8qr@dread.disaster.area>
 <20241114060710.GA11169@lst.de>
 <Zzd2lfQURP70dAxu@kbusch-mbp>
 <20241115165348.GA22628@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115165348.GA22628@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_153713_378829_862695D3 
X-CRM114-Status: GOOD (  29.01  )
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

On Fri, Nov 15, 2024 at 05:53:48PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 15, 2024 at 09:28:05AM -0700, Keith Busch wrote:
> > SSDs operates that way. FDP just reports more stuff because that's what
> > people kept asking for. But it doesn't require you fundamentally change
> > how you acces it. You've singled out FDP to force a sequential write
> > requirement that that requires unique support from every filesystem
> > despite the feature not needing that.
> 
> No I haven't.  If you think so you are fundamentally misunderstanding
> what I'm saying.

We have an API that has existed for 10+ years. You are gatekeeping that
interface by declaring NVMe's FDP is not allowed to use it. Do I have
that wrong? You initially blocked this because you didn't like how the
spec committe worked. Now you've shifted to trying to pretend FDP
devices require explicit filesystem handholding that was explicely NOT
part of that protocol.
 
> > We have demonstrated 40% reduction in write amplifcation from doing the
> > most simplist possible thing that doesn't require any filesystem or
> > kernel-user ABI changes at all. You might think that's not significant
> > enough to let people realize those gains without more invasive block
> > stack changes, but you may not buying NAND in bulk if that's the case.
> 
> And as iterared multiple times you are doing that by bypassing the
> file system layer in a forceful way that breaks all abstractions and
> makes your feature unavailabe for file systems.

Your filesystem layering breaks the abstraction and capabilities the
drives are providing. You're doing more harm than good trying to game
how the media works here.

> I've also thrown your a nugget by first explaining and then even writing
> protype code to show how you get what you want while using the proper
> abstractions.  

Oh, the untested prototype that wasn't posted to any mailing list for
a serious review? The one that forces FDP to subscribe to the zoned
interface only for XFS, despite these devices being squarly in the
"conventional" SSD catagory and absolutely NOT zone devices? Despite I
have other users using other filesystems successfuly using the existing
interfaces that your prototype doesn't do a thing for? Yah, thanks...

I appreciate you put the time into getting your thoughts into actual
code and it does look very valuable for ACTUAL ZONE block devices. But
it seems to have missed the entire point of what this hardware feature
does. If you're doing low level media garbage collection with FDP and
tracking fake media write pointers, then you're doing it wrong. Please
use Open Channel and ZNS SSDs if you want that interface and stop
gatekeeping the EXISTING interface that has proven value in production
software today.

> But instead of a picking up on that you just whine like
> this.  Either spend a little bit of effort to actually get the interface
> right or just shut up.

Why the fuck should I make an effort to do improve your pet project that
I don't have a customer for? They want to use the interface that was
created 10 years ago, exactly for the reason it was created, and no one
wants to introduce the risks of an untested and unproven major and
invasive filesystem and block stack change in the kernel in the near
term!

