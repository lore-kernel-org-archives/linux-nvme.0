From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 1 Jun 2017 00:18:20 -0700
Subject: [PATCH 4/4] nvme-pci: implement host memory buffer support
In-Reply-To: <1ac2afb3-7003-037e-5a2c-3a74798c1755@mellanox.com>
References: <20170520131357.15929-1-hch@lst.de>
 <20170520131357.15929-5-hch@lst.de>
 <1ac2afb3-7003-037e-5a2c-3a74798c1755@mellanox.com>
Message-ID: <20170601071820.GA20089@infradead.org>

> > +static void nvme_setup_host_mem(struct nvme_dev *dev)
> > +{
> > +	u64 max = (u64)max_host_mem_size_mb * 1024 * 1024;
> > +	u64 preferred = (u64)dev->ctrl.hmpre * 4096;
> > +	u64 min = (u64)dev->ctrl.hmmin * 4096;
> > +	u32 enable_bits = NVME_HOST_MEM_ENABLE;
> > +
> > +	preferred = min(preferred, max);
> > +	if (min > max) {
> 
> Should it be:
> if (min > preferred) ?

No.  max is the maxium value the kernel allows a device to take.
If the minimum required value is bigger than that we have to
fail, it has nothing to do with the preferred value.

> > +		dev_warn(dev->ctrl.device,
> > +			"min host memory (%lld MiB) above limit (%d MiB).\n",
> > +			preferred / 1024 / 1024, max_host_mem_size_mb);
> 
> here we can:
> preferred ==> min
> max_host_mem_size_mb ==> preferred / 1024 / 1024 ?
> 
> other option is change the warning print from "preferred" to "min" since
> we assume that dev->ctrl.hmpre >= dev->ctrl.hmmin.

The first one should indeed be min, but I think that's the only change
we need.
