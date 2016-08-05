From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Thu, 4 Aug 2016 21:17:27 -0300
Subject: [PATCH v4 0/3] dma-mapping, powerpc, nvme: introduce the
 DMA_ATTR_NO_WARN attribute
In-Reply-To: <20160804150145.fb5690e9a873121db1dfa0b1@linux-foundation.org>
References: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20160804150145.fb5690e9a873121db1dfa0b1@linux-foundation.org>
Message-ID: <57A3DB17.3060603@linux.vnet.ibm.com>

Andrew,

On 08/04/2016 07:01 PM, Andrew Morton wrote:
> It would help to have seen an example of the error message - please
> always quote such things when fixing bugs.

Indeed; okay.

The error messages are several blocks like this one:

     ppc_iommu_map_sg: 11784 callbacks suppressed
     nvme 0001:01:00.0: iommu_alloc failed, tbl c00001965c5ca400 vaddr 
c000018faa7b0000 npages 16
     nvme 0001:01:00.0: iommu_alloc failed, tbl c00001965c5ca400 vaddr 
c000018faa9b0000 npages 16
     <repeat>

> I assume the warnings are coming via nvme_map_data()'s call to
> blk_rq_map_sg()?  [snip]

If I understand the point in the question correctly -- actually not,
the warnings are coming via:

   nvme_map_data()
   -> dma_map_sg[_attrs]()
      -> dma_map_ops.map_sg()
        (dma_map_ops = dma_iommu_ops @ arch/powerpc/kernel/iommu.c)
         -> dma_iommu_map_sg()
            -> ppc_iommu_map_sg() /* as seen above */

And from what I could observe, the blk_rq_map_sg() path doesn't end
up in there.

> [snip] An alternative (and more idiomatic) fix would be to
> change the blk_rq_map_sg() interface to permit passing down some
> foo_NOWARN flag and propagating that down the stack into
> ppc_iommu_map_sg().  Was this approach evaluated?  I suspect it might
> be messy.

I see; I haven't evaluated that, but agree with you it might be messy.

As far as I can see, in order to pass something to blk_rq_map_sg() and
have it eventually make into ppc_iommu_map_sg(), that something should
be present in the scatterlist -- which seems to be what's common/passed
to both blk_rq_map_sg() (the interface point proposed) and dma_map_sg() 
(which is the function which reaches ppc_iommu_map_sg() down the chain).

It seems a bit hidden, and (if I got the suggestion right), it doesn't
seem to be in the scope of scatterlist to contain such a flag.

One point of the patches is make the attribute visible/explicit; I see
it can be inconvenient sometimes, but it allows for a clear / evident
difference between dma_map_sg() calls which are (not) OK with failures.

(for example, the 2 calls in nvme_map_data() - they can return either
BLK_MQ_RQ_QUEUE_BUSY or BLK_MQ_RQ_QUEUE_ERROR - so the former is OK.)

Does that make sense?

Thanks for the review.

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
