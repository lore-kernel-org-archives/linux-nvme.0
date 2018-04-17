From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 17 Apr 2018 16:15:38 -0600
Subject: [PATCH] nvme: lightnvm: add granby support
In-Reply-To: <20180417220901.GG11513@localhost.localdomain>
References: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
 <6e50972d-f806-52ac-7983-2642bd211afa@lightnvm.io>
 <20180417220901.GG11513@localhost.localdomain>
Message-ID: <6701f433-e865-5a17-f1c7-4c0e0c5effaa@kernel.dk>

On 4/17/18 4:09 PM, Keith Busch wrote:
> On Tue, Apr 17, 2018@08:16:25AM +0200, Matias Bj?rling wrote:
>> On 4/17/18 3:55 AM, Wei Xu wrote:
>>> Add a new lightnvm quirk to identify CNEX?s Granby controller.
>>>
>>> Signed-off-by: Wei Xu <wxu at cnexlabs.com>
>>> ---
>>>   drivers/nvme/host/pci.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index cb73bc8..9419e88 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -2529,6 +2529,8 @@ static const struct pci_device_id nvme_id_table[] = {
>>>   		.driver_data = NVME_QUIRK_LIGHTNVM, },
>>>   	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
>>>   		.driver_data = NVME_QUIRK_LIGHTNVM, },
>>> +	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
>>> +		.driver_data = NVME_QUIRK_LIGHTNVM, },
>>>   	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>>>   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
>>>   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
>>>
>>
>> Looks good to me.
>>
>> Reviewed-by: Matias Bj?rling <mb at lightnvm.io>
>>
>> Keith, when convenient can you pick this up for 4.18?
> 
> This looks safe for 4.17-rc2, no? Unless you want to wait for the next
> release.

It should wait for the next release, it's not a fix.

-- 
Jens Axboe
