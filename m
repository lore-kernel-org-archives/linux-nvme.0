From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Mon, 8 Oct 2018 12:29:46 +0200
Subject: [PATCH 1/2] nvme: NUMA locality information for fabrics
In-Reply-To: <162f2606-f5a5-cbe1-e4ff-4e409f430ff3@suse.com>
References: <20181005092915.126636-1-hare@suse.de>
 <20181005092915.126636-2-hare@suse.de> <20181008100423.GA6686@lst.de>
 <cffba6f0-3d8a-8596-ced1-ef6eea7195f5@bjorling.me>
 <162f2606-f5a5-cbe1-e4ff-4e409f430ff3@suse.com>
Message-ID: <dc3821f1-6b2d-8723-d95d-269d332cb60f@bjorling.me>



On 10/08/2018 12:27 PM, Hannes Reinecke wrote:
> On 10/8/18 12:22 PM, Matias Bj?rling wrote:
>>
>>
>> On 10/08/2018 12:04 PM, Christoph Hellwig wrote:
> [ .. ]
>>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>>> index d668682f91df..b5d37aacf212 100644
>>>> --- a/drivers/nvme/host/pci.c
>>>> +++ b/drivers/nvme/host/pci.c
>>>> @@ -2517,6 +2517,7 @@ static int nvme_probe(struct pci_dev *pdev, 
>>>> const struct pci_device_id *id)
>>>> ????? dev_info(dev->ctrl.device, "pci function %s\n", 
>>>> dev_name(&pdev->dev));
>>>> +??? dev->ctrl.node_id = node;
>>>> ????? nvme_get_ctrl(&dev->ctrl);
>>>> ????? async_schedule(nvme_async_probe, dev);
>>>
>>> This changes behavior as node might remain NUMA_NO_NODE when the code
>>> above sets the device node to first_memory_node now when
>>> it would otherwise be NUMA_NO_NODE.? Then again that code makes no
>>> sense to me to start with - Matias added it with the blk-mq conversion,
>>> so maybe he remembers why we do it to start with?? If we want to fix
>>> up nodes like that it seems like we should do it in the driver core
>>> or the PCI core.
>>>
>>
>> Back in the days it was carried over to make sure the structures was 
>> allocated from the same node as the pcie device.
>>
> Which really is what this patch is trying to do.
> Or am I wrong?
> 

Yep. It was missing for fabrics.

> Cheers,
> 
> Hannes
