From: keith.busch@intel.com (Keith Busch)
Date: Wed, 13 Feb 2019 14:31:49 -0700
Subject: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
In-Reply-To: <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-2-ming.lei@redhat.com>
 <20190213150407.GB96272@google.com>
 <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
Message-ID: <20190213213149.GB8027@localhost.localdomain>

On Wed, Feb 13, 2019@09:56:36PM +0100, Thomas Gleixner wrote:
> On Wed, 13 Feb 2019, Bjorn Helgaas wrote:
> > On Wed, Feb 13, 2019@06:50:37PM +0800, Ming Lei wrote:
> > > We have to ask driver to re-caculate set vectors after the whole IRQ
> > > vectors are allocated later, and the result needs to be stored in 'affd'.
> > > Also both the two interfaces are core APIs, which should be trusted.
> > 
> > s/re-caculate/recalculate/
> > s/stored in 'affd'/stored in '*affd'/
> > s/both the two/both/
> > 
> > This is a little confusing because you're talking about both "IRQ
> > vectors" and these other "set vectors", which I think are different
> > things.  I assume the "set vectors" are cpumasks showing the affinity
> > of the IRQ vectors with some CPUs?
> 
> I think we should drop the whole vector wording completely.
> 
> The driver does not care about vectors, it only cares about a block of
> interrupt numbers. These numbers are kernel managed and the interrupts just
> happen to have a CPU vector assigned at some point. Depending on the CPU
> architecture the underlying mechanism might not even be named vector.

Perhaps longer term we could move affinity mask creation from the irq
subsystem into a more generic library. Interrupts aren't the only
resource that want to spread across CPUs. For example, blk-mq has it's
own implementation to for polled queues, so I think a non-irq specific
implementation would be a nice addition to the kernel lib.
