From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 16 Mar 2019 22:25:51 +0100
Subject: [PATCH 1/2] [RFC] ata: ahci: Respect bus DMA constraints
In-Reply-To: <20190313183056.GB4926@lst.de>
References: <20190307000440.8708-1-marek.vasut@gmail.com>
 <7c051bbd-7835-9cab-30b2-0acde1364781@arm.com>
 <356f3ee8-407f-f865-e5cc-333695d4f857@gmail.com>
 <79e44e90-b16a-5315-e02f-101a2ebbb6a0@arm.com>
 <a8b5b75f-2660-e216-033a-77808e2afb76@gmail.com>
 <20190308071810.GA11959@lst.de>
 <a6b34982-9100-0e60-c3eb-6ed8fcbe9e93@gmail.com>
 <20190313183056.GB4926@lst.de>
Message-ID: <3b665597-a616-70fc-8cd0-dfde236fe669@gmail.com>

On 3/13/19 7:30 PM, Christoph Hellwig wrote:
> On Sat, Mar 09, 2019@12:23:15AM +0100, Marek Vasut wrote:
>> On 3/8/19 8:18 AM, Christoph Hellwig wrote:
>>> On Thu, Mar 07, 2019@12:14:06PM +0100, Marek Vasut wrote:
>>>>> Right, but whoever *interprets* the device masks after the driver has
>>>>> overridden them should be taking the (smaller) bus mask into account as
>>>>> well, so the question is where is *that* not being done correctly?
>>>>
>>>> Do you have a hint where I should look for that ?
>>>
>>> If this a 32-bit ARM platform it might the complete lack of support
>>> for bus_dma_mask in arch/arm/mm/dma-mapping.c..
>>
>> It's an ARM 64bit platform, just the PCIe controller is limited to 32bit
>> address range, so the devices on the PCIe bus cannot read the host's
>> DRAM above the 32bit limit.
> 
> arm64 should take the mask into account both for the swiotlb and
> iommu case.  What are the exact symptoms you see?

With the nvme, the device is recognized, but cannot be used.
It boils down to PCI BAR access being possible, since that's all below
the 32bit boundary, but when the device tries to do any sort of DMA,
that transfer returns nonsense data.

But when I call dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32) in
the affected driver (thus far I tried this nvme, xhci-pci and ahci-pci
drivers), it all starts to work fine.

Could it be that the driver overwrites the (coherent_)dma_mask and
that's why the swiotlb/iommu code cannot take this into account ?

> Does it involve
> swiotlb not kicking in, or iommu issues?

How can I check ? I added printks into arch/arm64/mm/dma-mapping.c and
drivers/iommu/dma-iommu.c , but I suspect I need to look elsewhere.

> What is the exact kernel version?

next/master from 20190306 (5.0.0 + next patches)

-- 
Best regards,
Marek Vasut
