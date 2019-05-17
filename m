From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 May 2019 11:08:14 +0200
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <20190516142411.GC23333@localhost.localdomain>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-6-keith.busch@intel.com>
 <20190516062528.GA29930@lst.de>
 <20190516142411.GC23333@localhost.localdomain>
Message-ID: <20190517090814.GB15509@lst.de>

On Thu, May 16, 2019@08:24:11AM -0600, Keith Busch wrote:
> > I've still not heard an explanation of anyone why we need to disable
> > the HMB here. Even if there are states where we have to disable it
> > we need to restrict it to just those system power states where we have
> > to, as reclaiming and recreating the HMB is very costly for the device.
> 
> We're not really reclaiming the HMB here. We're just telling the
> controller to stop using it for a moment,

Well, at that point the device can't use it and has to reclaim that
memory internally, depending on how it is used.

> and we return it back to the
> device in the same condition it left it via NVME_HOST_MEM_RETURN. That
> should minimize bringup latency.

Assuming it can just suspend that usage, which might not always be true.

Because of that we should only disable the HMB if we have to.
