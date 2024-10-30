Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466BCD74963
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 05:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b891zHCy4ExkeUUnRktvqP7TNe1cWSYCAKY/dzl1r8w=; b=h2uKOtW9cRjeVfi3e3y0pKrBlR
	J7dCGHA6m7VfboGbpulzf8YHlnGuVHWpS1LpJl+dUwrTX+Wpn3vFZSPAwvzA84GytBuAPYIo8hI6w
	Ss+troNksxdeQwMC12FuwhLipmDAIDyDXeLdvx9TOlbl3WcnFckXW86tPNhALk1StHUuTR9aHWU78
	zPbFKdccZzHiE3MHZjesGxq3Ic7KGYtif+4SjU3c50UvlhKnd6V8OSstMAW1vfbWjkw6AkO0PCcZY
	9xul8PFNpBKQ1Z5Ow1b9dhDF4I2aDDUow+vS/htJ92RIZP7lixYY5bDMRgsIO2PFPR6h4jdNVBcKC
	h+vgWm+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t60qK-0000000Gjjn-1Ylw;
	Wed, 30 Oct 2024 05:02:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t60jx-0000000Girr-2XUp
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 04:55:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55591227A8E; Wed, 30 Oct 2024 05:55:26 +0100 (CET)
Date: Wed, 30 Oct 2024 05:55:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241030045526.GA32385@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241029151922.459139-10-kbusch@meta.com> <20241029152654.GC26431@lst.de> <ZyEAb-zgvBlzZiaQ@kbusch-mbp> <20241029153702.GA27545@lst.de> <ZyEBhOoDHKJs4EEY@kbusch-mbp> <20241029155330.GA27856@lst.de> <ZyEL4FOBMr4H8DGM@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyEL4FOBMr4H8DGM@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_215529_961994_938CF1FA 
X-CRM114-Status: GOOD (  32.44  )
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

On Tue, Oct 29, 2024 at 10:22:56AM -0600, Keith Busch wrote:
> On Tue, Oct 29, 2024 at 04:53:30PM +0100, Christoph Hellwig wrote:
> > On Tue, Oct 29, 2024 at 09:38:44AM -0600, Keith Busch wrote:
> > > They're not exposed as write streams. Patch 7/9 sets the feature if it
> > > is a placement id or not, and only nvme sets it, so scsi's attributes
> > > are not claiming to be a write stream.
> > 
> > So it shows up in sysfs, but:
> > 
> >  - queue_max_write_hints (which really should be queue_max_write_streams)
> >    still picks it up, and from there the statx interface
> > 
> >  - per-inode fcntl hint that encode a temperature still magically
> >    get dumpted into the write streams if they are set.
> > 
> > In other words it's a really leaky half-backed abstraction.
> 
> Exactly why I asked last time: "who uses it and how do you want them to
> use it" :)

For the temperature hints the only public user I known is rocksdb, and
that only started working when Hans fixed a brown paperbag bug in the
rocksdb code a while ago.  Given that f2fs interprets the hints I suspect
something in the Android world does as well, maybe Bart knows more.

For the separate write streams the usage I want for them is poor mans
zones - e.g. write N LBAs sequentially into a separate write streams
and then eventually discard them together.  This will fit nicely into
f2fs and the pending xfs work as well as quite a few userspace storage
systems.  For that the file system or application needs to query
the number of available write streams (and in the bitmap world their
numbers of they are distontigous) and the size your can fit into the
"reclaim unit" in FDP terms.  I've not been bothering you much with
the latter as it is an easy retrofit once the I/O path bits lands.

> > Let's brainstorm how it could be done better:
> > 
> >  - the max_write_streams values only set by block devices that actually
> >    do support write streams, and not the fire and forget temperature
> >    hints.  They way this is queried is by having a non-zero value
> >    there, not need for an extra flag.
> 
> So we need a completely different attribute for SCSI's permanent write
> streams? You'd mentioned earlier you were okay with having SCSI be able
> to utilized per-io raw block write hints. Having multiple things to
> check for what are all just write classifiers seems unnecessarily
> complicated.

I don't think the multiple write streams interface applies to SCSIs
write streams, as they enforce a relative temperature, and they don't
have the concept of how much you can write into an "reclaim unit".

OTOH there isn't much you need to query for them anyway, as the
temperature hints have always been defined as pure hints with all
up and downsides of that.

> No need to create a new fcntl. The people already testing this are
> successfully using FDP with the existing fcntl hints. Their applications
> leverage FDP as way to separate files based on expected lifetime. It is
> how they want to use it and it is working above expectations. 

FYI, I think it's always fine and easy to map the temperature hits to
write streams if that's all the driver offers.  It loses a lot of the
capapilities, but as long as it doesn't enforce a lower level interface
that never exposes more that's fine.


