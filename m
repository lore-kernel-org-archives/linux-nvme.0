From: chris.hyser@oracle.com (chris hyser)
Date: Tue, 27 Jun 2017 16:46:31 -0400
Subject: DMA_ATTR_WEAK_ORDERING defintion, was Re: [PATCH] nvme: set
 DMA_ATTR_WEAK_ORDERING attribute on dma buffers
In-Reply-To: <20170624073539.GE14580@lst.de>
References: <1497645290-31041-1-git-send-email-alan.adamson@oracle.com>
 <20170617115703.GA13002@lst.de>
 <6a32f30b-433a-9857-164f-1717405a6082@oracle.com>
 <20170624073539.GE14580@lst.de>
Message-ID: <f485b21a-0cf7-d2f0-c957-03d234447561@oracle.com>

On 6/24/2017 3:35 AM, Christoph Hellwig wrote:
> I always assumed that our streaming mappings are relaxed order for
> TLP anyway.  And at very least Documentation/DMA-attributes.txt seems
> to imply something different:
>
>
>   DMA_ATTR_WEAK_ORDERING
>   ----------------------
>
>   DMA_ATTR_WEAK_ORDERING specifies that reads and writes to the mapping
>   may be weakly ordered, that is that reads and writes may pass each other.
>
> Which to me suggest host reads, which also makes me wonder why these
> would even apply to our streaming mappings.
>
> Adding the powerpc folks that added the DMA_ATTR_WEAK_ORDERING flag
> originally back in 2008, but not actual users as far as I can tell -
> those are all new and from the sparc gang, except for the noveau
> driver, which is a bit older but only uses for dma_alloc_attrs, where
> the original description makes sense to me.

I put this in for SPARC. In our case the host bridge/RC itself follows very strict ordering unless the relaxed order bit 
is set in the TLP. This works great for devices that actually allow the driver to enable it. We however also have to 
support an infiniband card that does not support enabling this in the HW and thus in the TLP but is actually fine with 
relaxed order for the data buffers (ie the streaming I/O vs the coherent control buffers). In fact w/o relaxed order the 
performance is absolutely atrocious ... w/ exceeds x86. This flag enables the driver to signal to us when we map the 
buffer in the IOMMU to enable the relaxed order attribute for our HW.

-chrish
