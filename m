From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 3 Oct 2015 01:19:52 -0700
Subject: [PATCH 0/5 v2] Fix NVMe driver support on Power with 32-bit DMA
In-Reply-To: <1443819066.27295.19.camel@kernel.crashing.org>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <1443819066.27295.19.camel@kernel.crashing.org>
Message-ID: <20151003081952.GC24025@infradead.org>

On Sat, Oct 03, 2015@06:51:06AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2015-10-02@13:09 -0700, Nishanth Aravamudan wrote:
> 
> > 1) add a generic dma_get_page_shift implementation that just returns
> > PAGE_SHIFT
> 
> So you chose to return the granularity of the iommu to the driver
> rather than providing a way for the driver to request a specific
> alignment for DMA mappings. Any specific reason ?

At least for NVMe that's the way to go - it allows to set a page set in
the device which should fit the IOMMU page size.
