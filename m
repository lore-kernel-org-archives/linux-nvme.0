From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Sep 2017 16:27:24 -0400
Subject: [PATCH 3/4] nvme-pci: propagate (some) errors from host memory
 buffer setup
In-Reply-To: <a1eec558-51ee-4512-1ab1-16ae05bf598b@applied-asynchrony.com>
References: <20170906135532.21358-1-hch@lst.de>
 <20170906135532.21358-4-hch@lst.de>
 <a1eec558-51ee-4512-1ab1-16ae05bf598b@applied-asynchrony.com>
Message-ID: <20170906202724.GH17331@localhost.localdomain>

On Wed, Sep 06, 2017@04:19:43PM +0200, Holger Hoffst?tte wrote:
> On 09/06/17 15:55, Christoph Hellwig wrote:
> > We want to catch command execution errors when resetting the device, so
> > propagate errors from the Set Features when setting up the host memory
> > buffer.  We keep ignoring memory allocation failures, as the spec
> > clearly says that the controller must work without a host memory buffer.
> 
> Maybe I'm missing something but I think you forgot to update a bunch of
> function signatures in terms of return type. Changing "return" to "return 0"
> IMHO makes little sense otherwise.
> 
> -h

The sig is updated:

 -static void nvme_setup_host_mem(struct nvme_dev *dev)
 +static int nvme_setup_host_mem(struct nvme_dev *dev)

The diff is just showing the old sig.

> > @@ -1706,7 +1707,7 @@ static void nvme_setup_host_mem(struct nvme_dev *dev)
> >  			"min host memory (%lld MiB) above limit (%d MiB).\n",
> >  			min >> ilog2(SZ_1M), max_host_mem_size_mb);
> >  		nvme_free_host_mem(dev);
> > -		return;
> > +		return 0;
> 
> [..]
> 
> > @@ -1723,7 +1724,7 @@ static void nvme_setup_host_mem(struct nvme_dev *dev)
> >  		if (nvme_alloc_host_mem(dev, min, preferred)) {
> >  			dev_warn(dev->ctrl.device,
> >  				"failed to allocate host memory buffer.\n");
> > -			return;
> > +			return 0; /* controller must work without HMB */
> 
> [..]
> 
> > @@ -1731,8 +1732,10 @@ static void nvme_setup_host_mem(struct nvme_dev *dev)
> >  			dev->host_mem_size >> ilog2(SZ_1M));
> >  	}
> >  
> > -	if (nvme_set_host_mem(dev, enable_bits))
> > +	ret = nvme_set_host_mem(dev, enable_bits);
> > +	if (ret)
> >  		nvme_free_host_mem(dev);
> > +	return ret;
