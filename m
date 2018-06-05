From: hch@lst.de (Christoph Hellwig)
Date: Tue, 5 Jun 2018 06:47:33 +0200
Subject: [PATCH 13/14] nvme: use the changed namespaces list log to
 clear ns data changed AENs
In-Reply-To: <20180604195908.GC8205@localhost.localdomain>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-14-hch@lst.de>
 <20180604195908.GC8205@localhost.localdomain>
Message-ID: <20180605044733.GA29448@lst.de>

On Mon, Jun 04, 2018@01:59:09PM -0600, Keith Busch wrote:
> > Per section 5.2 we need to issue the corresponding log page to clear an
> > AEN, so for a namespace data changed AEN we need to read the changed
> > namespace list log.  And once we read that log anyway we might as well
> > use it to optimize the rescan.
> > 
> > Signed-off-by: Christoph Hellwig <hch at lst.de>
> 
> I'm a little concerned about this. Userspace might be reading the same
> log page. Since the contents of the page may change each time its read,
> it's possible the driver will see only a subset of changed namespaces
> at the point it gets to read the log page, missing a chance to
> revalidate others.

I agree with the concern, but I don't think it really is uniqueue here.
We allow userspace to send all kind sof harmful commands, even queue
for queue creation and deletion.

But let's assume we don't want to use the list due to this concern:
we'd still have to read the log page, as per the NVMe spec the only
think clearing a pending AEN is reading the associated log page.
We'd then need to still do the full scan using identify.  Is this what
we want?  If you think this is important for reliability we could
just ignore the log page.
