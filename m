Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A6AD591D4
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 07:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IsCn19yYzSbrcUBKQREXDJTAgD/YUNlN0+PetPRsb2s=; b=b/lyztN6iMERu4FHn6eesmBymb
	vftH/1/QVtq0EECA888zRhN+OuO026lGbizwnr75zmJYF1nrKSBOk+B9cpygESGUitrOTf3S3jS8B
	GIrjPcyE2VfcznGBvR+Tx/bCckyH1b1gIJrsrYY/a0IvbFlynMk3JurTU9pjjBI710MapZ3venH/O
	UDzDNr7Cap0XI5HM8bF5VBiGYtBf7sAvMtC3RZDdzRxMg2PrbruEJjCMc09LES2Dq4055Iin12HAi
	gMXBFb6pO0b/X9NV/yusEZRQtVh31SgCN/CWKgavLMa9tmd/2urSRpE5Y/BAyWAZP4Y7OpLhj4Go7
	jI5pRh5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDITC-0000000Bc23-3HE4;
	Tue, 19 Nov 2024 07:16:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDIT1-0000000Bc1J-0sHy
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 07:16:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EAAF068D49; Tue, 19 Nov 2024 08:15:56 +0100 (CET)
Date: Tue, 19 Nov 2024 08:15:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
	Pierre Labat <plabat@micron.com>,
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
Message-ID: <20241119071556.GA8417@lst.de>
References: <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com> <20241112133439.GA4164@lst.de> <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com> <DS0PR08MB854131CDA4CDDF2451CEB71DAB592@DS0PR08MB8541.namprd08.prod.outlook.com> <20241113044736.GA20212@lst.de> <ZzU7bZokkTN2s8qr@dread.disaster.area> <20241114060710.GA11169@lst.de> <Zzd2lfQURP70dAxu@kbusch-mbp> <20241115165348.GA22628@lst.de> <ZzvPpD5O8wJzeHth@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzvPpD5O8wJzeHth@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_231607_547822_94184469 
X-CRM114-Status: GOOD (  42.43  )
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

On Mon, Nov 18, 2024 at 04:37:08PM -0700, Keith Busch wrote:
> We have an API that has existed for 10+ years. You are gatekeeping that
> interface by declaring NVMe's FDP is not allowed to use it. Do I have
> that wrong? You initially blocked this because you didn't like how the
> spec committe worked. Now you've shifted to trying to pretend FDP
> devices require explicit filesystem handholding that was explicely NOT
> part of that protocol.

I'm not fucking gate keeping anything, I'm really tired of this claim
with absolutely no facts backing it up.

> > And as iterared multiple times you are doing that by bypassing the
> > file system layer in a forceful way that breaks all abstractions and
> > makes your feature unavailabe for file systems.
> 
> Your filesystem layering breaks the abstraction and capabilities the
> drives are providing. You're doing more harm than good trying to game
> how the media works here.

How so?

> > I've also thrown your a nugget by first explaining and then even writing
> > protype code to show how you get what you want while using the proper
> > abstractions.  
> 
> Oh, the untested prototype that wasn't posted to any mailing list for
> a serious review? The one that forces FDP to subscribe to the zoned
> interface only for XFS, despite these devices being squarly in the
> "conventional" SSD catagory and absolutely NOT zone devices? Despite I
> have other users using other filesystems successfuly using the existing
> interfaces that your prototype doesn't do a thing for? Yah, thanks...

What zoned interface to FDP?

The exposed interface is to:

 a) pick a write stream
 b) expose the size of the reclaim unit

not done yet, but needed for good operation:

 c) expose how much capacity in a reclaim unit has been written

This is about as good as it gets to map the FDP (and to a lesser extent
streams) interface to an abstract block layer API.  If you have a better
suggestion to actually expose these capabilities I'm all ears.

Now _my_ preferred use of that interface is a write out of place,
map LBA regions to physical reclaim blocks file system.  On the hand
hand because it actually fits the file system I'm writing, on the other
hand because industry experience has shown that this is a very good
fit to flash storage (even without any explicit placement).  If you
think that's all wrong that fine, despite claims to the contrary from
you absolutely nothing in the interface forced you to do that.

You can roll the dice for your LBA allocations and write them using
a secure random number generator.  The interface allows for all of that,
but I doubt your results will all that great.  Not my business.

> I appreciate you put the time into getting your thoughts into actual
> code and it does look very valuable for ACTUAL ZONE block devices. But
> it seems to have missed the entire point of what this hardware feature
> does. If you're doing low level media garbage collection with FDP and
> tracking fake media write pointers, then you're doing it wrong. Please
> use Open Channel and ZNS SSDs if you want that interface and stop
> gatekeeping the EXISTING interface that has proven value in production
> software today.

Hey, feel free to come up with a better design.  The whole point of a
proper block layer design is that you actually can do that!

> > But instead of a picking up on that you just whine like
> > this.  Either spend a little bit of effort to actually get the interface
> > right or just shut up.
> 
> Why the fuck should I make an effort to do improve your pet project that
> I don't have a customer for? They want to use the interface that was
> created 10 years ago, exactly for the reason it was created, and no one
> wants to introduce the risks of an untested and unproven major and
> invasive filesystem and block stack change in the kernel in the near
> term!

Because you apparently want an interface to FDP in the block layer.  And
if you want that you need to stop bypassing the file systems as pointed
out not just by me but also at least one other file system maintainer
and the maintainer of the most used block subsystem.  I've thrown you
some bones how that can be done while doing everything else you did
before (at least assuming you get the fs side past the fs maintainers),
but the only thanks for that is bullshit attacks at a personal level.

