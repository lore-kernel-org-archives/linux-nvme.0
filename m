From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 6 Oct 2015 02:51:36 -0700
Subject: [PATCH 1/5 v2] dma-mapping: add generic dma_get_page_shift API
In-Reply-To: <20151002201142.GC40695@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
Message-ID: <20151006095136.GB14144@infradead.org>

Do we need a function here or can we just have a IOMMU_PAGE_SHIFT define
with an #ifndef in common code?

Also not all architectures use dma-mapping-common.h yet, so you either
need to update all of those as well, or just add the #ifndef directly
to linux/dma-mapping.h.
