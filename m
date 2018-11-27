From: hch@lst.de (Christoph Hellwig)
Date: Tue, 27 Nov 2018 17:14:26 +0100
Subject: [PATCH] nvme: Implement Enhanced Command Retry
In-Reply-To: <20181127155000.GA6401@localhost.localdomain>
References: <20181127153710.6328-1-keith.busch@intel.com>
 <20181127154626.GA26787@lst.de> <20181127155000.GA6401@localhost.localdomain>
Message-ID: <20181127161426.GA27370@lst.de>

On Tue, Nov 27, 2018@08:50:00AM -0700, Keith Busch wrote:
> On Tue, Nov 27, 2018@04:46:26PM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 27, 2018@08:37:10AM -0700, Keith Busch wrote:
> > >  		if (!blk_queue_dying(req->q)) {
> > > +			unsigned long delay = 0;
> > > +			struct nvme_ns *ns = req->q->queuedata;
> > > +			u16 crd = (nvme_req(req)->status & NVME_SC_CRD) >> 11;
> > > +
> > > +			if (crd && ns)
> > > +				delay = ns->ctrl->crdt[crd - 1] * 100;
> > 
> > Do we need bounce checking for crd here?
> 
> I assume you mean bounds, in which case it should not be necessary since
> the result of the mask and shift can't be > 3, which is the size of the
> crdt array. I can add the check if not having it is visually alarming.

True, I don't think we'll need a check.  Maybe at best a comment.
