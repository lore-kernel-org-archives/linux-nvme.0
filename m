From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Mon, 12 Oct 2015 14:06:51 -0700
Subject: [PATCH 1/5 v2] dma-mapping: add generic dma_get_page_shift API
In-Reply-To: <20151006095136.GB14144@infradead.org>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
 <20151006095136.GB14144@infradead.org>
Message-ID: <20151012210651.GB26702@linux.vnet.ibm.com>

On 06.10.2015 [02:51:36 -0700], Christoph Hellwig wrote:
> Do we need a function here or can we just have a IOMMU_PAGE_SHIFT define
> with an #ifndef in common code?

On Power, since it's technically variable, we'd need a function. So are
you suggesting define'ing it to a function just on Power and leaving it
a constant elsewhere?

I noticed that sparc has a IOMMU_PAGE_SHIFT already, fwiw.

-Nish
