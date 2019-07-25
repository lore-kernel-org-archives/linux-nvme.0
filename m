From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 10:00:25 -0600
Subject: [PATCH 11/14] PCI/P2PDMA: dma_map P2PDMA map requests that
 traverse the host bridge
In-Reply-To: <20190725061005.GB24875@lst.de>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-12-logang@deltatee.com> <20190724063232.GB1804@lst.de>
 <7173a4dd-0c9c-48de-98cd-93513313fd8d@deltatee.com>
 <20190725061005.GB24875@lst.de>
Message-ID: <fb39485a-2914-bac4-b249-e1f4ecc8d2be@deltatee.com>



On 2019-07-25 12:10 a.m., Christoph Hellwig wrote:
> On Wed, Jul 24, 2019@09:58:59AM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2019-07-24 12:32 a.m., Christoph Hellwig wrote:
>>>>  	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
>>>> +	struct pci_dev *client;
>>>> +	int dist;
>>>> +
>>>> +	client = find_parent_pci_dev(dev);
>>>> +	if (WARN_ON_ONCE(!client))
>>>> +		return 0;
>>>>  
>>>> +	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
>>>> +					client, NULL);
>>>
>>> Doing this on every mapping call sounds expensive..
>>
>> The result of this function is cached in an xarray (per patch 4) so, on
>> the hot path, it should just be a single xa_load() which should be a
>> relatively fast lookup which is similarly used for other hot path
>> operations.
> 
> We don't cache find_parent_pci_dev, though.  So we should probably
> export find_parent_pci_dev with a proper namespaces name and cache
> that in the caler.

Oh, yes, I'll take a look at this. Of the two callers: NVMe should be
easy we could just pass the PCI device instead of the struct device.
RDMA is significantly more unclear: would you add a pci_dev to struct
ib_device? Or maybe we should be able to simply rely on the fact that
the DMA device *must* be a PCI device and just use to_pci_dev() directly?

>>>
>>>> +	if (WARN_ON_ONCE(dist & P2PDMA_NOT_SUPPORTED))
>>>> +		return 0;
>>>> +
>>>> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
>>>> +		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>>>> +	else
>>>> +		return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
>>>
>>> Can't we organize the values so that we can switch on the return
>>> value instead of doing flag checks?
>>
>> Sorry, I don't follow what you are saying here. If you mean for
>> upstream_bridge_distance() to just return how to map and not the
>> distance that would interfere with other uses of that function.
> 
> The point is that in the map path we don't even care about the
> distance.  I think we should just have a function that returns the
> P2PDMA_ values from the xarray (maybe also store it there as two
> values, but that isn't quite as important), and get rid of even
> the concept of distance in the map path. e.g.:
> 
> 	switch (pci_p2pdma_supported(pgmap->pci_p2pdma_provider, client))) {
> 	case P2PDMA_HOST_BRIDGE:
> 		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
> 	case P2PDMA_SWITCH:
> 		return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
> 	default:
> 		WARN_ON_ONCE(1);
> 		return 0;
> 	}

Ok, will change for v2.

Thanks,

Logan
