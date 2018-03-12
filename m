From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 12 Mar 2018 17:09:13 +0800
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
In-Reply-To: <20180309172445.GC14765@localhost.localdomain>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de> <20180301150329.GB6795@ming.t460p>
 <20180301161042.GA14799@localhost.localdomain>
 <20180308074220.GC15748@lst.de>
 <20180309172445.GC14765@localhost.localdomain>
Message-ID: <20180312090827.GB23903@ming.t460p>

On Fri, Mar 09, 2018@10:24:45AM -0700, Keith Busch wrote:
> On Thu, Mar 08, 2018@08:42:20AM +0100, Christoph Hellwig wrote:
> > 
> > So I suspect we'll need to go with a patch like this, just with a way
> > better changelog.
> 
> I have to agree this is required for that use case. I'll run some
> quick tests and propose an alternate changelog.
> 
> Longer term, the current way we're including offline present cpus either
> (a) has the driver allocate resources it can't use or (b) spreads the
> ones it can use thinner than they need to be. Why don't we rerun the
> irq spread under a hot cpu notifier for only online CPUs?

4b855ad371 ("blk-mq: Create hctx for each present CPU") removes handling
mapping change via hot cpu notifier. Not only code is cleaned up, but
also fixes very complicated queue dependency issue:

- loop/dm-rq queue depends on underlying queue
- for NVMe, IO queue depends on admin queue

If freezing queue can be avoided in CPU notifier, it should be fine to
do that, otherwise it need to be avoided.

Thanks,
Ming
