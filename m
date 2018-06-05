From: hch@lst.de (Christoph Hellwig)
Date: Tue, 5 Jun 2018 06:43:47 +0200
Subject: [PATCH v2 2/8] nvmet-rdma: wrap raw kref_get/put() with
 corresponding helpers
In-Reply-To: <20180604214916.GC24926@ziepe.ca>
References: <20180604123003.24748-1-roman.penyaev@profitbricks.com>
 <20180604123003.24748-3-roman.penyaev@profitbricks.com>
 <20180604214916.GC24926@ziepe.ca>
Message-ID: <20180605044347.GA29420@lst.de>

On Mon, Jun 04, 2018@03:49:16PM -0600, Jason Gunthorpe wrote:
> > +{
> > +	return kref_put(&dev->ref, nvmet_rdma_free_device);
> > +}
> > +
> > +static int nvmet_rdma_dev_get(struct nvmet_rdma_device *dev)
> > +{
> > +	return kref_get_unless_zero(&dev->ref);
> > +}
> 
> Don't wrap get_unless_zero with something called get..

Agreed.  And I hate all these wrappers.  Either we use kref_*
or we use wrappers and plain refcount_* ops, not both.
