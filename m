From: james.smart@broadcom.com (James Smart)
Date: Thu, 29 Mar 2018 09:24:36 -0700
Subject: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
In-Reply-To: <20180329160721.4691-4-logang@deltatee.com>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-4-logang@deltatee.com>
Message-ID: <03cb3610-8ec7-9dc4-9e0a-82f4c30de578@broadcom.com>

On 3/29/2018 9:07 AM, Logan Gunthorpe wrote:
> When allocating an SGL, the fibre channel target uses the number
> of entities mapped as the number of entities in a given scatter
> gather list. This is incorrect.
>
> The DMA-API-HOWTO document gives this note:
>
>     The 'nents' argument to the dma_unmap_sg call must be
>     the _same_ one you passed into the dma_map_sg call,
>     it should _NOT_ be the 'count' value _returned_ from the
>     dma_map_sg call.
>
> The fc code only stores the count value returned form the dma_map_sg()
> call and uses that value in the call to dma_unmap_sg().
>
> The dma_map_sg() call will return a lower count than nents when multiple
> SG entries were merged into one. This implies that there will be fewer
> DMA address and length entries but the original number of page entries
> in the SGL. So if this occurs, when the SGL reaches nvmet_execute_rw(),
> a bio would be created with fewer than the total number of entries.
>
> As odd as it sounds, and as far as I can tell, the number of SG entries
> mapped does not appear to be used anywhere in the fc driver and therefore
> there's no current need to store it.
>
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Cc: James Smart <james.smart at broadcom.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Fixes: c53432030d8642 ("nvme-fabrics: Add target support for FC transport")
> ---

Signed-off-by: James Smart? <james.smart at broadcom.com>

Patch looks fine.

As for "not used anywhere", be careful as the structure being prepped is 
passed from the nvme-fc transport to an underlying lldd. So the 
references would likely be in the lldd.

-- james
