From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Apr 2017 19:36:49 +0200
Subject: [PATCH 2/4] genirq: return the irq name from free_irq
In-Reply-To: <alpine.DEB.2.20.1704141920560.2327@nanos>
References: <20170413070643.32165-1-hch@lst.de>
 <20170413070643.32165-3-hch@lst.de>
 <alpine.DEB.2.20.1704141920560.2327@nanos>
Message-ID: <20170414173649.GA26228@lst.de>

On Fri, Apr 14, 2017@07:28:42PM +0200, Thomas Gleixner wrote:
> On Thu, 13 Apr 2017, Christoph Hellwig wrote:
> 
> > This allows callers to get back at them instead of having to store
> > it in another variable.
> 
> Alternatively you tell the irq code to free it for you. Patch below.

Yes, this should work to.  But I think having the same layer free
something they allocated again is a tad cleaner in terms of layering.

If you prefer this version I can respin the series.
