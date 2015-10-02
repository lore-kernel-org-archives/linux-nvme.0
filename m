From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Fri, 2 Oct 2015 10:39:47 -0700
Subject: [PATCH 2/2] drivers/nvme: default to the IOMMU page size on Power
In-Reply-To: <20151002172544.GA16139@infradead.org>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
 <20151002172313.GC41011@linux.vnet.ibm.com>
 <20151002172544.GA16139@infradead.org>
Message-ID: <20151002173947.GA40695@linux.vnet.ibm.com>

On 02.10.2015 [10:25:44 -0700], Christoph Hellwig wrote:
> Hi Nishanth,
> 
> please expose this value through the generic DMA API instead of adding
> architecture specific hacks to drivers.

Ok, I'm happy to do that instead -- what I struggled with is that I
don't have enough knowledge of the various architectures to provide the
right default implementation. It should be sufficient for the default to
return PAGE_SHIFT, and on Power just override that to return the IOMMU
table's page size? Since the only user will be the NVMe driver
currently, that should be fine?

Sorry for the less-than-ideal patch!

-Nish
