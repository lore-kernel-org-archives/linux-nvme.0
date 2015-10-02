From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Oct 2015 10:41:46 -0700
Subject: [PATCH 2/2] drivers/nvme: default to the IOMMU page size on Power
In-Reply-To: <20151002173947.GA40695@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
 <20151002172313.GC41011@linux.vnet.ibm.com>
 <20151002172544.GA16139@infradead.org>
 <20151002173947.GA40695@linux.vnet.ibm.com>
Message-ID: <20151002174146.GA21503@infradead.org>

On Fri, Oct 02, 2015@10:39:47AM -0700, Nishanth Aravamudan wrote:
> Ok, I'm happy to do that instead -- what I struggled with is that I
> don't have enough knowledge of the various architectures to provide the
> right default implementation. It should be sufficient for the default to
> return PAGE_SHIFT, and on Power just override that to return the IOMMU
> table's page size? Since the only user will be the NVMe driver
> currently, that should be fine?

I think that's fine.

> Sorry for the less-than-ideal patch!

Np, it's a reasonable first attempt that we just need to refine.
