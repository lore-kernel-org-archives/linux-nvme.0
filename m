Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B02CF07DC
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 09:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DHQiwFgGItIG0Gpp+j/jC0RJrfCa6rdYjrq6zUjNKmk=; b=zwYkoGvBkuBIWJEDv1DCURZdeH
	lx32HxO4yPUMqIrXlyvMGP14XgcjdBbpzUyoRHUJLfiJjTsK0QfGWr1Gf3NX5jocsLFDZNv4hMT9Z
	akiBxKpdQFqJaaZ9LTZAigdmUFsF9bwF8FI6LQpMLbH2wzMZ/2v31xf65hdWLscUeW+std0g2xjli
	SdCHAcHRVjG4sqySeU6AQwj8fJWb9rJwH2ELB2hbkpLV39svT/C0bSgY7XjARMnWnx5eoPBxYgv9x
	XQ79JxZDkyjF6I2mam/168gTGho2FUz1F3H/GIR4ESbSn7zbUBwcBzUOPi4gxJhyEbCS54t0ofJdB
	Z12zN+xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sypCv-0000000CAsF-2gUO;
	Thu, 10 Oct 2024 09:11:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sypBh-0000000CAej-3v6q
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 09:10:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E3E20227A8E; Thu, 10 Oct 2024 11:10:21 +0200 (CEST)
Date: Thu, 10 Oct 2024 11:10:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241010091021.GA9287@lst.de>
References: <20241004053121.GB14265@lst.de> <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local> <20241004062733.GB14876@lst.de> <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local> <20241004123027.GA19168@lst.de> <20241007101011.boufh3tipewgvuao@ArmHalley.local> <20241008122535.GA29639@lst.de> <ZwVFTHMjrI4MaPtj@kbusch-mbp> <20241009092828.GA18118@lst.de> <Zwab8WDgdqwhadlE@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwab8WDgdqwhadlE@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_021026_144741_4D5AB0AB 
X-CRM114-Status: GOOD (  18.54  )
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

On Wed, Oct 09, 2024 at 09:06:25AM -0600, Keith Busch wrote:
> > anything to the reclaim unit?  Or is this another of the cases where
> > as a hyperscaler you just "know" from the data sheet?
> 
> As far as I know, this is an inconsequential spec detail that is not
> being considered by any applications testing this. And yet, the expected
> imrpovements are still there, so I don't see a point holding this up for
> that reason.

It was the whole point of the thing, and a major source of complexity.
Although not quite for this use case Hans has numbers that aligning
application data tables / objects / etc to the underlying "erase unit"
absolutely matters.

And just to make it clear the objection here is not that we have an
an interface that doesn't take that into respect at the syscall
level.  We already have that interface and might as well make use
of that.  The problem is that the series tries to directly expose
that to the driver, freezing us into this incomplet interface forever
(assuming we have users actually picking it up).

That's why I keep insisting like a broken record that we need to get
this lower interface right first.

