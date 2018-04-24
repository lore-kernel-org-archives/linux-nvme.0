From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 Apr 2018 17:14:15 -0600
Subject: [PATCH] fix failure when root filesystem is on nvme
In-Reply-To: <alpine.LRH.2.02.1804241743050.19786@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804210942070.11467@file01.intranet.prod.int.rdu2.redhat.com>
 <20180421191608.GC19048@localhost.localdomain>
 <alpine.LRH.2.02.1804241743050.19786@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180424231415.GA31318@localhost.localdomain>

On Tue, Apr 24, 2018@06:18:54PM -0400, Mikulas Patocka wrote:
> 
> 
> On Sat, 21 Apr 2018, Keith Busch wrote:
> 
> > On Sat, Apr 21, 2018@09:59:48AM -0400, Mikulas Patocka wrote:
> >
> > > There's a bug in the nvme block device driver that causes failure when we 
> > > have no initramfs and the root filesystem is directly on nvme. The driver 
> > > spawns a work item nvme_reset_work() in the nvme_wq workqueue, but doesn't 
> > > wait for it. The result is that the kernel attempts to mount the root 
> > > filesystem before nvme_reset_work() finishes and it panics because it 
> > > can't find the root device.
> > > 
> > > It can be fixed with this simple patch (perhaps you can come up with a 
> > > better patch that uses the asynchronous probing infrastructure?)
> > 
> > We probe asynchronously to fix other issues.
> > 
> > First is that boot takes way
> > too long if you have a lot of devices when probing all of them serially,
> > and then certain init systems kill the probe task after a certain time,
> > breaking boot for those.
> > 
> > Is there something we can do for your setup to have the kernel wait for
> > the root partition to be available instead of givinig up after pci probe?
> 
> Are different PCI NVME devices probed concurrently by the PCI API? (I 
> can't try, I have just one) 

It does not.

> If yes, then the patch that I posted should be 
> OK, because it wouldn't break this concurrency.

But you're waiting for the wrong work queue: the driver's reset_work
won't get your root filesystem. That is handled in the scan_work.

> If not, then you need to make sure that wait_for_device_probe() waits for 
> the NVME probe to finish. The kernel calls wait_for_device_probe() just 
> before it attempts to mount the root filesystem. I don't know which of the 
> kernel frameworks would be best suited to accomplish that. Perhaps the 
> simplest solution would be to increment probe_count in nvme_probe and 
> decrement it when the probe work item finishes - but it is not exported 
> and you'd need to create helper functions in drivers/base/dd.c to do that.

Will have to look into it, but I think an async_domain is going to be the
right way to go and shouldn't require any changes outside nvme.
