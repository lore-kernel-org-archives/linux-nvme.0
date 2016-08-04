From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 4 Aug 2016 15:01:45 -0700
Subject: [PATCH v4 0/3] dma-mapping, powerpc, nvme: introduce the
 DMA_ATTR_NO_WARN attribute
In-Reply-To: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-ID: <20160804150145.fb5690e9a873121db1dfa0b1@linux-foundation.org>

On Mon,  1 Aug 2016 19:59:47 -0300 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com> wrote:

> This patchset introduces dma_attr DMA_ATTR_NO_WARN (just like __GFP_NOWARN),
> which tells the DMA-mapping subsystem to suppress allocation failure reports.
> 
> On some architectures allocation failures are reported with error messages
> to the system logs.  Although this can help to identify and debug problems,
> drivers which handle failures (eg, retry later) have no problems with them,
> and can actually flood the system logs with error messages that aren't any
> problem at all, depending on the implementation of the retry mechanism.

It would help to have seen an example of the error message - please
always quote such things when fixing bugs.

I assume the warnings are coming via nvme_map_data()'s call to
blk_rq_map_sg()?  An alternative (and more idiomatic) fix would be to
change the blk_rq_map_sg() interface to permit passing down some
foo_NOWARN flag and propagating that down the stack into
ppc_iommu_map_sg().  Was this approach evaluated?  I suspect it might
be messy.
