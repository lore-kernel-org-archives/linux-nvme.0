From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 Aug 2017 10:25:23 +0200
Subject: [PATCH 07/10] nvme: track shared namespaces
In-Reply-To: <1503951680.4860.3.camel@linux.intel.com>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-8-hch@lst.de>
 <bee7c6c3-bf6b-8f7e-ad8f-fd5e238a94ef@grimberg.me>
 <1503951680.4860.3.camel@linux.intel.com>
Message-ID: <20170829082523.GA10487@lst.de>

On Mon, Aug 28, 2017@01:21:20PM -0700, J Freyensee wrote:
> > > ?????horrible.??One idea would be to rename the current struct nvme_ns
> > > ?????to struct nvme_ns_link or similar and use the nvme_ns name for the
> > > ?????new structure.??But that would involve a lot of churn.
> > 
> > maybe nvme_ns_primary?
> 
> Since it looks like it holds all unique identifier values and should hold
> other namespace characteristics later, maybe:
> 
> nvme_ns_item?
> Or nvme_ns_entry?
> Or nvme_ns_element?
> Or nvme_ns_unit?
> Or nvme_ns_entity?
> Or nvme_ns_container?

I hate them all (including the current ns_head name :)).

I suspect the only way that would make my taste happy is to call
this new one nvme_ns, but that would lead to a lot of churn.
