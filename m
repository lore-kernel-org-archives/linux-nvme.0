From: hch@lst.de (Christoph Hellwig)
Date: Fri, 10 Nov 2017 06:07:48 +0100
Subject: [PATCH 4/7] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20171110045236.GA32408@lst.de>
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-5-hch@lst.de>
 <20171109212111.GA1718@localhost.localdomain> <20171110045236.GA32408@lst.de>
Message-ID: <20171110050748.GA32668@lst.de>

On Fri, Nov 10, 2017@05:52:36AM +0100, Christoph Hellwig wrote:
> > If we've CMIC capabilities, we'll use the subsys->instance; if we don't
> > have CMIC, we use the ctrl->instance. 
> > 
> > Since the two instances are independent of each other, they can create
> > duplicate names.
> > 
> > To fix, I think we'll need to always use the subsys instance for
> > consistency if CONFIG_NVME_MULTIPATH=y.
> 
> Yes, we should.  But once we do that we should just always use
> subsys->instance, as it will always be the same as ctrl->instance
> for CONFIG_NVME_MULTIPATH=n.

Scrap that.  Of course they aren't always the same in the
CONFIG_NVME_MULTIPATH=n.  We'll need your patch as-is.
