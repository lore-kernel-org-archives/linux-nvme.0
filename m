From: keith.busch@intel.com (Keith Busch)
Date: Sat, 21 Apr 2018 13:16:09 -0600
Subject: [PATCH] fix failure when root filesystem is on nvme
In-Reply-To: <alpine.LRH.2.02.1804210942070.11467@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804210942070.11467@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180421191608.GC19048@localhost.localdomain>

On Sat, Apr 21, 2018@09:59:48AM -0400, Mikulas Patocka wrote:
> There's a bug in the nvme block device driver that causes failure when we 
> have no initramfs and the root filesystem is directly on nvme. The driver 
> spawns a work item nvme_reset_work() in the nvme_wq workqueue, but doesn't 
> wait for it. The result is that the kernel attempts to mount the root 
> filesystem before nvme_reset_work() finishes and it panics because it 
> can't find the root device.
> 
> It can be fixed with this simple patch (perhaps you can come up with a 
> better patch that uses the asynchronous probing infrastructure?)

We probe asynchronously to fix other issues. First is that boot takes way
too long if you have a lot of devices when probing all of them serially,
and then certain init systems kill the probe task after a certain time,
breaking boot for those.

Is there something we can do for your setup to have the kernel wait for
the root partition to be available instead of givinig up after pci probe?
