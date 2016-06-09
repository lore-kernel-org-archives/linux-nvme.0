From: axboe@fb.com (Jens Axboe)
Date: Thu, 9 Jun 2016 14:28:54 -0600
Subject: [PATCH] NVMe: Only release requested regions
In-Reply-To: <20160608071629.y2ysgc5lsvv2c6nu@c203.arch.suse.de>
References: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>
 <20160608071629.y2ysgc5lsvv2c6nu@c203.arch.suse.de>
Message-ID: <5759D186.2090000@fb.com>

On 06/08/2016 01:16 AM, Johannes Thumshirn wrote:
> On Tue, May 10, 2016@03:14:28PM +0200, Johannes Thumshirn wrote:
>> The NVMe driver only requests the PCIe device's memory regions but releases
>> all possible regions (including eventual I/O regions). This leads to a stale
>> warning entry in dmesg about freeing non existent resources.
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
>> ---
>>   drivers/nvme/host/pci.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index eec73fe..6f5ad07 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1759,9 +1759,14 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>>
>>   static void nvme_dev_unmap(struct nvme_dev *dev)
>>   {
>> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
>> +	int bars;
>> +
>>   	if (dev->bar)
>>   		iounmap(dev->bar);
>> -	pci_release_regions(to_pci_dev(dev->dev));
>> +
>> +	bars = pci_select_bars(pdev, IORESOURCE_MEM);
>> +	pci_release_selected_regions(pdev, bars);
>>   }
>>
>>   static void nvme_pci_disable(struct nvme_dev *dev)
>> @@ -1998,7 +2003,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
>>
>>          return 0;
>>     release:
>> -       pci_release_regions(pdev);
>> +       pci_release_selected_regions(pdev, bars);
>>          return -ENODEV;
>>   }
>>
>> --
>> 1.8.5.6
>>
>
>
> Jens, ping?

Added for 4.7, thanks.

-- 
Jens Axboe
