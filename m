From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 24 Jul 2019 10:06:22 -0600
Subject: [PATCH 14/14] PCI/P2PDMA: Introduce pci_p2pdma_[un]map_resource()
In-Reply-To: <20190724063235.GC1804@lst.de>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-15-logang@deltatee.com> <20190724063235.GC1804@lst.de>
Message-ID: <57e8fc1a-de70-fb65-5ef1-ffa2b95c73a6@deltatee.com>



On 2019-07-24 12:32 a.m., Christoph Hellwig wrote:
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index baf476039396..20c834cfd2d3 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -874,6 +874,91 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>  }
>>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
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
> 
> This does once again look very expensive for something called in the
> hot path.

Yes. This is the downside of dealing only with a phys_addr_t: we have to
look up against it. Unfortunately, I believe it's possible for different
BARs on a device to be in different windows, so something like this is
necessary unless we already know the BAR the phys_addr_t belongs to. It
might probably be sped up a bit by storing the offsets of each bar
instead of looping through all the bridge windows, but I don't think it
will get you *that* much.

As this is an example with no users, the answer here will really depend
on what the use-case is doing. If they can lookup, ahead of time, the
mapping type and offset then they don't have to do this work on the hot
path and it means that pci_p2pdma_map_resource() is simply not a
suitable API.

Logan
