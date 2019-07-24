From: hch@lst.de (Christoph Hellwig)
Date: Wed, 24 Jul 2019 08:32:32 +0200
Subject: [PATCH 11/14] PCI/P2PDMA: dma_map P2PDMA map requests that
 traverse the host bridge
In-Reply-To: <20190722230859.5436-12-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-12-logang@deltatee.com>
Message-ID: <20190724063232.GB1804@lst.de>

>  	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
> +	struct pci_dev *client;
> +	int dist;
> +
> +	client = find_parent_pci_dev(dev);
> +	if (WARN_ON_ONCE(!client))
> +		return 0;
>  
> +	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
> +					client, NULL);

Doing this on every mapping call sounds expensive..

> +	if (WARN_ON_ONCE(dist & P2PDMA_NOT_SUPPORTED))
> +		return 0;
> +
> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
> +		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
> +	else
> +		return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);

Can't we organize the values so that we can switch on the return
value instead of doing flag checks?

>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
>  
> @@ -847,6 +861,21 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
>  void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs)
>  {
> +	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
> +	struct pci_dev *client;
> +	int dist;
> +
> +	client = find_parent_pci_dev(dev);
> +	if (!client)
> +		return;
> +
> +	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
> +					client, NULL);

And then we do it for every unmap again..
