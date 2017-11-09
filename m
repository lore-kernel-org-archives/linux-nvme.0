From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 17:23:03 +0100
Subject: [PATCHv3 5/5] nvme: Send uevent for some asynchronous events
In-Reply-To: <20171109161846.GE25017@localhost.localdomain>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-6-keith.busch@intel.com>
 <20171109092702.GE17120@lst.de>
 <20171109161846.GE25017@localhost.localdomain>
Message-ID: <20171109162303.GA13634@lst.de>

On Thu, Nov 09, 2017@09:18:46AM -0700, Keith Busch wrote:
> > Seems like we should use cmpxchg on aen.
> 
> > > +		ctrl->aen = result;
> > 
> > Can we call the field aen_result?
> > 
> > Given that the rest of the series looks good I'd be tempted to just
> > fix that up and apply it.  Are you ok with that?
> 
> Thanks, the suggestions sound good to me. If you want to edit the commit
> when applying, I would much appreciate.

I'll just do the rename for now.  I'll ponder the cmpxchg a little more,
and if I think we need it I'll send a follow on patch.
