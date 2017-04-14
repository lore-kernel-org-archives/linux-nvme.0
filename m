From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 14 Apr 2017 19:53:19 +0200 (CEST)
Subject: [PATCH 2/4] genirq: return the irq name from free_irq
In-Reply-To: <20170414173649.GA26228@lst.de>
References: <20170413070643.32165-1-hch@lst.de>
 <20170413070643.32165-3-hch@lst.de>
 <alpine.DEB.2.20.1704141920560.2327@nanos> <20170414173649.GA26228@lst.de>
Message-ID: <alpine.DEB.2.20.1704141951590.2327@nanos>

On Fri, 14 Apr 2017, Christoph Hellwig wrote:

> On Fri, Apr 14, 2017@07:28:42PM +0200, Thomas Gleixner wrote:
> > On Thu, 13 Apr 2017, Christoph Hellwig wrote:
> > 
> > > This allows callers to get back at them instead of having to store
> > > it in another variable.
> > 
> > Alternatively you tell the irq code to free it for you. Patch below.
> 
> Yes, this should work to.  But I think having the same layer free
> something they allocated again is a tad cleaner in terms of layering.

Fair enough. Was just a thought.

Bjorn, please route it through PCI alltogether.

For the whole series:

    Reviewed-by: Thomas Gleixner <tglx at linutronix.de>

Thanks,

	tglx
