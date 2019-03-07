From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 7 Mar 2019 12:14:06 +0100
Subject: [PATCH 1/2] [RFC] ata: ahci: Respect bus DMA constraints
In-Reply-To: <79e44e90-b16a-5315-e02f-101a2ebbb6a0@arm.com>
References: <20190307000440.8708-1-marek.vasut@gmail.com>
 <7c051bbd-7835-9cab-30b2-0acde1364781@arm.com>
 <356f3ee8-407f-f865-e5cc-333695d4f857@gmail.com>
 <79e44e90-b16a-5315-e02f-101a2ebbb6a0@arm.com>
Message-ID: <a8b5b75f-2660-e216-033a-77808e2afb76@gmail.com>

On 3/7/19 10:48 AM, Robin Murphy wrote:
> On 2019-03-07 9:37 am, Marek Vasut wrote:
>> On 3/7/19 10:32 AM, Robin Murphy wrote:
>>> On 2019-03-07 12:04 am, marek.vasut@gmail.com wrote:
>>>> From: Marek Vasut <marek.vasut+renesas at gmail.com>
>>>>
>>>> Since commit 6c2fb2ea7636 ("of/device: Set bus DMA mask as
>>>> appropriate"),
>>>> the upstream bus can constraint device DMA range. Respect that
>>>> constraint
>>>> and do not change the device DMA masks if they were already set.
>>>>
>>>> This is applicable e.g. on systems where the PCIe controller cannot
>>>> expose
>>>> the full address space range. Such a system may have a 64bit CPU with
>>>> DRAM
>>>> mapped both below and above the 32bit address space, yet the PCIe
>>>> devices
>>>> can not perform DMA directly to/from the DRAM range above the 32bit
>>>> limit.
>>>> Hence, for such setup to work, all the buffers must exist below the
>>>> 32bit
>>>> limit.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas at gmail.com>
>>>> Cc: Christoph Hellwig <hch at lst.de>
>>>> Cc: Geert Uytterhoeven <geert+renesas at glider.be>
>>>> Cc: Jens Axboe <axboe at fb.com>
>>>> Cc: Jens Axboe <axboe at kernel.dk>
>>>> Cc: Keith Busch <keith.busch at intel.com>
>>>> Cc: Robin Murphy <robin.murphy at arm.com>
>>>> Cc: Sagi Grimberg <sagi at grimberg.me>
>>>> Cc: Wolfram Sang <wsa+renesas at sang-engineering.com>
>>>> Cc: linux-renesas-soc at vger.kernel.org
>>>> To: linux-ide at vger.kernel.org
>>>> To: linux-nvme at lists.infradead.org
>>>> ---
>>>> ?? drivers/ata/ahci.c | 7 +++++++
>>>> ?? 1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>>> index 021ce46e2e57..2acce056dd8c 100644
>>>> --- a/drivers/ata/ahci.c
>>>> +++ b/drivers/ata/ahci.c
>>>> @@ -926,6 +926,13 @@ static int ahci_configure_dma_masks(struct
>>>> pci_dev *pdev, int using_dac)
>>>> ?????? if (pdev->dma_mask && pdev->dma_mask < DMA_BIT_MASK(32))
>>>> ?????????? return 0;
>>>> ?? +??? /*
>>>> +???? * The upstream device could have applied DMA constraints already,
>>>> +???? * respect those and do not change the DMA masks.
>>>> +???? */
>>>> +??? if (pdev->dev.dma_mask && pdev->dev.coherent_dma_mask)
>>>> +??????? return 0;
>>>
>>> At least for DT platforms, the device masks are always going to be set
>>> to some initial value, which will most commonly just be the 32-bit
>>> default - that should not prevent the driver from setting wider masks if
>>> that's what the device really supports (in fact there are some patches
>>> queued in which we're now starting to formalise that properly).
>>>
>>> Are you seeing a problem with a DMA API backend failing to respect
>>> bus_dma_mask?
>>
>> Yes, the DMA mask gets overridden here to 64bit one, which on the R-Car
>> Gen3 with PCI with 32bit addressing limitation makes the AHCI driver
>> fail (and NVMe driver, and xHCI PCI etc). All those PCI devices fail the
>> same way because they override the DMA mask.
> 
> Right, but whoever *interprets* the device masks after the driver has
> overridden them should be taking the (smaller) bus mask into account as
> well, so the question is where is *that* not being done correctly?

Do you have a hint where I should look for that ?

-- 
Best regards,
Marek Vasut
