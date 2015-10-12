From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Mon, 12 Oct 2015 09:04:52 -0700
Subject: [PATCH 1/5 v2] dma-mapping: add generic dma_get_page_shift API
In-Reply-To: <20151006095136.GB14144@infradead.org>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
 <20151006095136.GB14144@infradead.org>
Message-ID: <20151012160452.GB24212@linux.vnet.ibm.com>

On 06.10.2015 [02:51:36 -0700], Christoph Hellwig wrote:
> Do we need a function here or can we just have a IOMMU_PAGE_SHIFT define
> with an #ifndef in common code?

I suppose we could do that -- I wasn't sure if the macro would be
palatable.

> Also not all architectures use dma-mapping-common.h yet, so you either
> need to update all of those as well, or just add the #ifndef directly
> to linux/dma-mapping.h.

Ok, I will take a look at that and spin up a v3.

Thanks for the feedback!

-Nish
