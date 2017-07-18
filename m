From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 18 Jul 2017 15:12:55 -0600
Subject: [PATCH] nvme: Add support for NVMe 1.3 Timestamp Feature
In-Reply-To: <59e271b0-00d8-d705-b56e-a93d7b21e393@grimberg.me>
References: <20170712221101.1715-1-jonathan.derrick@intel.com>
 <59e271b0-00d8-d705-b56e-a93d7b21e393@grimberg.me>
Message-ID: <4dea408c-c020-97aa-c6f6-4f10583ecf00@intel.com>

On 07/13/2017 01:01 AM, Sagi Grimberg wrote:
> 
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 5d5aa7f..82ce677 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2156,6 +2156,10 @@ static void nvme_reset_work(struct work_struct *work)
>>   	if (result)
>>   		goto out;
>>   
>> +	if (dev->ctrl.vs >= NVME_VS(1, 3, 0) &&
>> +	    dev->ctrl.oncs & NVME_CTRL_ONCS_TIMESTAMP)
>> +		nvme_set_timestamp(&dev->ctrl);
>> +
> 
> Why after setting up the I/O queues?
> 
No reason in particular; I just wanted it in the reset path.
For v2 I've moved it to the identify path.
