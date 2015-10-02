From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 03 Oct 2015 06:51:06 +1000
Subject: [PATCH 0/5 v2] Fix NVMe driver support on Power with 32-bit DMA
In-Reply-To: <20151002200953.GB40695@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
Message-ID: <1443819066.27295.19.camel@kernel.crashing.org>

On Fri, 2015-10-02@13:09 -0700, Nishanth Aravamudan wrote:

> 1) add a generic dma_get_page_shift implementation that just returns
> PAGE_SHIFT

So you chose to return the granularity of the iommu to the driver
rather than providing a way for the driver to request a specific
alignment for DMA mappings. Any specific reason ?

Cheers,
Ben.
