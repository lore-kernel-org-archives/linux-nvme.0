From: kbusch@kernel.org (Keith Busch)
Date: Fri, 5 Apr 2019 16:37:20 -0600
Subject: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
In-Reply-To: <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
Message-ID: <20190405223719.GC25081@localhost.localdomain>

On Fri, Apr 05, 2019@04:23:27PM -0600, Jens Axboe wrote:
> On 4/5/19 3:59 PM, Keith Busch wrote:
> > Managed interrupts can not migrate affinity when their CPUs are offline.
> > If the CPU is allowed to shutdown before they're returned, commands
> > dispatched to managed queues won't be able to complete through their
> > irq handlers.
> > 
> > Introduce per-hctx reference counting so we can block the CPU dead
> > notification for all allocated requests to complete if an hctx's last
> > CPU is being taken offline.
> 
> What does this do to performance? We're doing a map per request...

It should be the same cost as the blk_queue_enter/blk_queue_exit that's
also done per request, which is pretty cheap way to count users. I
don't think I'm measuring a difference, but my test sample size so far
is just one over-powered machine.
