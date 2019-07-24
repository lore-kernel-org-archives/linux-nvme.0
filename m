From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 24 Jul 2019 09:50:03 -0600
Subject: [PATCH 07/14] PCI/P2PDMA: Add the provider's pci_dev to the
 dev_pgmap struct
In-Reply-To: <20190724063229.GA1804@lst.de>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-8-logang@deltatee.com> <20190724063229.GA1804@lst.de>
Message-ID: <818e465d-3e57-b425-2431-e330a43fe7bd@deltatee.com>



On 2019-07-24 12:32 a.m., Christoph Hellwig wrote:
> On Mon, Jul 22, 2019@05:08:52PM -0600, Logan Gunthorpe wrote:
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 143e11d2a5c3..70c262b7c731 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -168,6 +168,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>>  	pgmap->res.end = pgmap->res.start + size - 1;
>>  	pgmap->res.flags = pci_resource_flags(pdev, bar);
>>  	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
>> +	pgmap->pci_p2pdma_provider = pdev;
>>  	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
>>  		pci_resource_start(pdev, bar);
> 
> I think we need to bite the bullet and move the PCIe P2P specific
> information out of struct dev_pagemap and into a pci-specific structure
> that embedds struct dev_pagemap.

OK, I was going to do that, but you just removed the p2p specific page
map. ;)

I'll change this for a v2.

Logan
