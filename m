From: keith.busch@intel.com (Keith Busch)
Date: Fri, 9 Mar 2018 10:24:45 -0700
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
In-Reply-To: <20180308074220.GC15748@lst.de>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de> <20180301150329.GB6795@ming.t460p>
 <20180301161042.GA14799@localhost.localdomain>
 <20180308074220.GC15748@lst.de>
Message-ID: <20180309172445.GC14765@localhost.localdomain>

On Thu, Mar 08, 2018@08:42:20AM +0100, Christoph Hellwig wrote:
> 
> So I suspect we'll need to go with a patch like this, just with a way
> better changelog.

I have to agree this is required for that use case. I'll run some
quick tests and propose an alternate changelog.

Longer term, the current way we're including offline present cpus either
(a) has the driver allocate resources it can't use or (b) spreads the
ones it can use thinner than they need to be. Why don't we rerun the
irq spread under a hot cpu notifier for only online CPUs?
