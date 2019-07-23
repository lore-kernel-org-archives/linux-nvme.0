From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 23 Jul 2019 10:58:20 -0600
Subject: [PATCH 14/14] PCI/P2PDMA: Introduce pci_p2pdma_[un]map_resource()
In-Reply-To: <d5e20223-04b9-dcb4-7c96-57d84eb010ae@amd.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-15-logang@deltatee.com>
 <d5e20223-04b9-dcb4-7c96-57d84eb010ae@amd.com>
Message-ID: <a6282247-b7a4-3eb9-4f87-4e73a0047f28@deltatee.com>



On 2019-07-23 10:28 a.m., Koenig, Christian wrote:
> Am 23.07.19 um 01:08 schrieb Logan Gunthorpe:
>> pci_p2pdma_[un]map_resource() can be used to map a resource given
>> it's physical address and the backing pci_dev. The functions will call
>> dma_[un]map_resource() when appropriate.
>>
>> This is for demonstration purposes only as there are no users of this
>> function at this time. Thus, this patch should not be merged at
>> this time.
>>
>> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> 
> Not sure if pci_p2pdma_phys_to_bus actually needs to be exported. But 
> apart from that looks fine to me.

Yes, oops, it certainly shouldn't be exported if it's static. I'll fix that.

> Reviewed-by: Christian K?nig <christian.koenig at amd.com>
> 
> Christian.
> 
>> ---
>>   drivers/pci/p2pdma.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index baf476039396..20c834cfd2d3 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -874,6 +874,91 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>   }
>>   EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>>   
>> +static pci_bus_addr_t pci_p2pdma_phys_to_bus(struct pci_dev *dev,
>> +		phys_addr_t start, size_t size)
>> +{
>> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>> +	phys_addr_t end = start + size;
>> +	struct resource_entry *window;
>> +
>> +	resource_list_for_each_entry(window, &bridge->windows) {
>> +		if (window->res->start <= start && window->res->end >= end)
>> +			return start - window->offset;
>> +	}
>> +
>> +	return DMA_MAPPING_ERROR;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_p2pdma_phys_to_bus);
>> +
>> +/**
>> + * pci_p2pdma_map_resource - map a PCI peer-to-peer physical address for DMA
>> + * @provider: pci device that provides the memory backed by phys_addr
>> + * @dma_dev: device doing the DMA request
>> + * @phys_addr: physical address of the memory to map
>> + * @size: size of the memory to map
>> + * @dir: DMA direction
>> + * @attrs: dma attributes passed to dma_map_resource() (if called)
>> + *
>> + * Maps a BAR physical address for programming a DMA engine.
>> + *
>> + * Returns the dma_addr_t to map or DMA_MAPPING_ERROR on failure
>> + */
>> +dma_addr_t pci_p2pdma_map_resource(struct pci_dev *provider,
>> +		struct device *dma_dev, phys_addr_t phys_addr, size_t size,
>> +		enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	struct pci_dev *client;
>> +	int dist;
>> +
>> +	client = find_parent_pci_dev(dma_dev);
>> +	if (!client)
>> +		return DMA_MAPPING_ERROR;
>> +
>> +	dist = upstream_bridge_distance(provider, client, NULL);
>> +	if (dist & P2PDMA_NOT_SUPPORTED)
>> +		return DMA_MAPPING_ERROR;
>> +
>> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
>> +		return dma_map_resource(dma_dev, phys_addr, size, dir, attrs);
>> +	else
>> +		return pci_p2pdma_phys_to_bus(provider, phys_addr, size);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_p2pdma_map_resource);
>> +
>> +/**
>> + * pci_p2pdma_unmap_resource - unmap a resource mapped with
>> + *		pci_p2pdma_map_resource()
>> + * @provider: pci device that provides the memory backed by phys_addr
>> + * @dma_dev: device doing the DMA request
>> + * @addr: dma address returned by pci_p2pdma_unmap_resource()
>> + * @size: size of the memory to map
>> + * @dir: DMA direction
>> + * @attrs: dma attributes passed to dma_unmap_resource() (if called)
>> + *
>> + * Maps a BAR physical address for programming a DMA engine.
>> + *
>> + * Returns the dma_addr_t to map or DMA_MAPPING_ERROR on failure
>> + */
>> +void pci_p2pdma_unmap_resource(struct pci_dev *provider,
>> +		struct device *dma_dev, dma_addr_t addr, size_t size,
>> +		enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	struct pci_dev *client;
>> +	int dist;
>> +
>> +	client = find_parent_pci_dev(dma_dev);
>> +	if (!client)
>> +		return;
>> +
>> +	dist = upstream_bridge_distance(provider, client, NULL);
>> +	if (dist & P2PDMA_NOT_SUPPORTED)
>> +		return;
>> +
>> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
>> +		dma_unmap_resource(dma_dev, addr, size, dir, attrs);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_resource);
>> +
>>   /**
>>    * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
>>    *		to enable p2pdma
> 
