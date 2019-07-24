From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 24 Jul 2019 09:58:59 -0600
Subject: [PATCH 11/14] PCI/P2PDMA: dma_map P2PDMA map requests that
 traverse the host bridge
In-Reply-To: <20190724063232.GB1804@lst.de>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-12-logang@deltatee.com> <20190724063232.GB1804@lst.de>
Message-ID: <7173a4dd-0c9c-48de-98cd-93513313fd8d@deltatee.com>



On 2019-07-24 12:32 a.m., Christoph Hellwig wrote:
>>  	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
>> +	struct pci_dev *client;
>> +	int dist;
>> +
>> +	client = find_parent_pci_dev(dev);
>> +	if (WARN_ON_ONCE(!client))
>> +		return 0;
>>  
>> +	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
>> +					client, NULL);
> 
> Doing this on every mapping call sounds expensive..

The result of this function is cached in an xarray (per patch 4) so, on
the hot path, it should just be a single xa_load() which should be a
relatively fast lookup which is similarly used for other hot path
operations.

> 
>> +	if (WARN_ON_ONCE(dist & P2PDMA_NOT_SUPPORTED))
>> +		return 0;
>> +
>> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
>> +		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>> +	else
>> +		return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
> 
> Can't we organize the values so that we can switch on the return
> value instead of doing flag checks?

Sorry, I don't follow what you are saying here. If you mean for
upstream_bridge_distance() to just return how to map and not the
distance that would interfere with other uses of that function.

>>  }
>>  EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
>>  
>> @@ -847,6 +861,21 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
>>  void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>  		int nents, enum dma_data_direction dir, unsigned long attrs)
>>  {
>> +	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
>> +	struct pci_dev *client;
>> +	int dist;
>> +
>> +	client = find_parent_pci_dev(dev);
>> +	if (!client)
>> +		return;
>> +
>> +	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
>> +					client, NULL);
> 
> And then we do it for every unmap again..

Yup, I don't think there's much else we can do here.

This is why I was fighting against doing lookups against the phys_addr_t
because that means you have to do these additional lookups.

My hope is if we can move to the phys_addr_t and flags as I described
here[1] we can get rid of these hot path lookups, but with the way
things are structured now this is necessary.

Logan

[1]
https://lore.kernel.org/linux-block/e63d0259-e17f-effe-b76d-43dbfda8ae3a at deltatee.com/
