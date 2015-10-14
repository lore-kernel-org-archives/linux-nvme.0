From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 14 Oct 2015 08:42:51 -0700
Subject: [PATCH 1/5 v2] dma-mapping: add generic dma_get_page_shift API
In-Reply-To: <20151014153900.GC30179@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
 <20151006095136.GB14144@infradead.org>
 <20151012210651.GB26702@linux.vnet.ibm.com>
 <20151014153900.GC30179@linux.vnet.ibm.com>
Message-ID: <20151014154251.GA7271@infradead.org>

Hi Nishanth,

sorry for the late reply.

> > On Power, since it's technically variable, we'd need a function. So are
> > you suggesting define'ing it to a function just on Power and leaving it
> > a constant elsewhere?
> > 
> > I noticed that sparc has a IOMMU_PAGE_SHIFT already, fwiw.
> 
> Sorry, I should have been more specific -- I'm ready to spin out a v3,
> with a sparc-specific function.
> 
> Are you ok with leaving it a function for now (the only caller is in
> NVMe obviously).


I guess we do indeed need a function then.  I'll take a look at your
patch, but as long you found a way to avoid adding too much boilerplate
code it should be fine.
