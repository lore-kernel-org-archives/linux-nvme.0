From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Fri, 2 Oct 2015 14:04:35 -0700
Subject: [PATCH 0/5 v2] Fix NVMe driver support on Power with 32-bit DMA
In-Reply-To: <1443819066.27295.19.camel@kernel.crashing.org>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <1443819066.27295.19.camel@kernel.crashing.org>
Message-ID: <20151002210435.GM8040@linux.vnet.ibm.com>

On 03.10.2015 [06:51:06 +1000], Benjamin Herrenschmidt wrote:
> On Fri, 2015-10-02@13:09 -0700, Nishanth Aravamudan wrote:
> 
> > 1) add a generic dma_get_page_shift implementation that just returns
> > PAGE_SHIFT
> 
> So you chose to return the granularity of the iommu to the driver
> rather than providing a way for the driver to request a specific
> alignment for DMA mappings. Any specific reason ?

Right, I did start with your advice and tried that approach, but it
turned out I was wrong about the actual issue at the time. The problem
for NVMe isn't actually the starting address alignment (which it can
handle not being aligned to the device's page size). It doesn't handle
(addr + len % dev_page_size != 0). That is, it's really a length
alignment issue.

It seems incredibly device specific to have a an API into the DMA code
to request an end alignment -- no other device seems to have this
issue/design. If you think that's better, I can fiddle with that
instead.

Sorry, I should have called this out better as an alternative
consideration.

-Nish
