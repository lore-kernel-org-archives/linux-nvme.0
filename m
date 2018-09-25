From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 25 Sep 2018 10:33:25 -0700
Subject: [PATCH v7 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
In-Reply-To: <20180925162231.4354-4-logang@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
 <20180925162231.4354-4-logang@deltatee.com>
Message-ID: <1537896805.11137.25.camel@acm.org>

On Tue, 2018-09-25@10:22 -0600, Logan Gunthorpe wrote:
> +int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +		      enum dma_data_direction dir)
> +{
> +	struct dev_pagemap *pgmap;
> +	struct scatterlist *s;
> +	phys_addr_t paddr;
> +	int i;
> +
> +	/*
> +	 * p2pdma mappings are not compatible with devices that use
> +	 * dma_virt_ops. If the upper layers do the right thing
> +	 * this should never happen because it will be prevented
> +	 * by the check in pci_p2pdma_add_client()
> +	 */
> +	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
> +			 dev->dma_ops == &dma_virt_ops))
> +		return 0;

Are you assuming that the compiler will optimize out the dev->dma_ops
== &dma_virt_ops test if CONFIG_DMA_VIRT_OPS=n such that no reference to the
dma_virt_ops symbol appears in the object file? Are you sure all compilers
and compiler versions that are used to build the Linux kernel will do that?

Thanks,

Bart.
