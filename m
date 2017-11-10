From: hch@lst.de (Christoph Hellwig)
Date: Fri, 10 Nov 2017 05:52:36 +0100
Subject: [PATCH 4/7] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20171109212111.GA1718@localhost.localdomain>
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-5-hch@lst.de>
 <20171109212111.GA1718@localhost.localdomain>
Message-ID: <20171110045236.GA32408@lst.de>

> If we've CMIC capabilities, we'll use the subsys->instance; if we don't
> have CMIC, we use the ctrl->instance. 
> 
> Since the two instances are independent of each other, they can create
> duplicate names.
> 
> To fix, I think we'll need to always use the subsys instance for
> consistency if CONFIG_NVME_MULTIPATH=y.

Yes, we should.  But once we do that we should just always use
subsys->instance, as it will always be the same as ctrl->instance
for CONFIG_NVME_MULTIPATH=n.
