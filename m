From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Wed, 20 Mar 2019 18:42:02 +0200
Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
In-Reply-To: <1553095686.65329.36.camel@acm.org>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <1553095686.65329.36.camel@acm.org>
Message-ID: <8994f43d26ebf6040b9d5d5e3866ee81abcf1a1c.camel@redhat.com>

On Wed, 2019-03-20@08:28 -0700, Bart Van Assche wrote:
> On Tue, 2019-03-19@16:41 +0200, Maxim Levitsky wrote:
> > *  All guest memory is mapped into the physical nvme device 
> >    but not 1:1 as vfio-pci would do this.
> >    This allows very efficient DMA.
> >    To support this, patch 2 adds ability for a mdev device to listen on 
> >    guest's memory map events. 
> >    Any such memory is immediately pinned and then DMA mapped.
> >    (Support for fabric drivers where this is not possible exits too,
> >     in which case the fabric driver will do its own DMA mapping)
> 
> Does this mean that all guest memory is pinned all the time? If so, are you
> sure that's acceptable?
I think so. The VFIO pci passthrough also pins all the guest memory.
SPDK also does this (pins and dma maps) all the guest memory.

I agree that this is not an ideal solution but this is a fastest and simplest
solution possible.

> 
> Additionally, what is the performance overhead of the IOMMU notifier added
> by patch 8/9? How often was that notifier called per second in your tests
> and how much time was spent per call in the notifier callbacks?

To be honest I haven't optimized my IOMMU notifier at all, so when it is called,
it stops the IO thread, does its work and then restarts it which is very slow.

Fortunelly it is not called at all during normal operation as VFIO dma map/unmap
events are really rare and happen only on guest boot.

The same is even true for nested guests, as nested guest startup causes a wave
of map unmap events while shadow IOMMU updates, but then it just uses these
mapping without changing them.

The only case when performance is really bad is when you boot a guest with
iommu=on intel_iommu=on and then use the nvme driver there. In this case, the
driver in the guest does itself IOMMU maps/unmaps (on the virtual IOMMU) and for
each such event my VFIO map/unmap callback is called.

This can be optimized though to be much better using also some kind of queued
invalidation in my driver. iommu=pt meanwhile in the guest solves that issue.

Best regards,
	Maxim Levitsky

> 
> Thanks,
> 
> Bart.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
