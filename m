From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 4 Aug 2016 18:05:01 -0700
Subject: [PATCH v4 0/3] dma-mapping, powerpc, nvme: introduce the
 DMA_ATTR_NO_WARN attribute
In-Reply-To: <57A3DB17.3060603@linux.vnet.ibm.com>
References: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20160804150145.fb5690e9a873121db1dfa0b1@linux-foundation.org>
 <57A3DB17.3060603@linux.vnet.ibm.com>
Message-ID: <20160804180501.f80c9b919341c486e2a95894@linux-foundation.org>

On Thu, 4 Aug 2016 21:17:27 -0300 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com> wrote:

> > [snip] An alternative (and more idiomatic) fix would be to
> > change the blk_rq_map_sg() interface to permit passing down some
> > foo_NOWARN flag and propagating that down the stack into
> > ppc_iommu_map_sg().  Was this approach evaluated?  I suspect it might
> > be messy.
> 
> I see; I haven't evaluated that, but agree with you it might be messy.
> 
> As far as I can see, in order to pass something to blk_rq_map_sg() and
> have it eventually make into ppc_iommu_map_sg(), that something should
> be present in the scatterlist -- which seems to be what's common/passed
> to both blk_rq_map_sg() (the interface point proposed) and dma_map_sg() 
> (which is the function which reaches ppc_iommu_map_sg() down the chain).
> 
> It seems a bit hidden, and (if I got the suggestion right), it doesn't
> seem to be in the scope of scatterlist to contain such a flag.
> 
> One point of the patches is make the attribute visible/explicit; I see
> it can be inconvenient sometimes, but it allows for a clear / evident
> difference between dma_map_sg() calls which are (not) OK with failures.
> 
> (for example, the 2 calls in nvme_map_data() - they can return either
> BLK_MQ_RQ_QUEUE_BUSY or BLK_MQ_RQ_QUEUE_ERROR - so the former is OK.)

Of course, the alternative is to just delete the damn warnings from
ppc_iommu_map_sg().  Imagine that!  Have they ever been of any use to
anyone?
