From: hch@lst.de (Christoph Hellwig)
Date: Wed, 24 Jul 2019 08:32:36 +0200
Subject: [PATCH 14/14] PCI/P2PDMA: Introduce pci_p2pdma_[un]map_resource()
In-Reply-To: <20190722230859.5436-15-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-15-logang@deltatee.com>
Message-ID: <20190724063235.GC1804@lst.de>

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index baf476039396..20c834cfd2d3 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -874,6 +874,91 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>  
> +static pci_bus_addr_t pci_p2pdma_phys_to_bus(struct pci_dev *dev,
> +		phys_addr_t start, size_t size)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +	phys_addr_t end = start + size;
> +	struct resource_entry *window;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		if (window->res->start <= start && window->res->end >= end)
> +			return start - window->offset;
> +	}
> +
> +	return DMA_MAPPING_ERROR;

This does once again look very expensive for something called in the
hot path.
