From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 8 May 2018 10:24:33 -0600
Subject: [PATCH v2] nvme: add quirk to force medium priority for SQ
 creation
In-Reply-To: <20180508162226.GA31027@localhost.localdomain>
References: <879357dd-937c-4496-84af-f804877562eb@kernel.dk>
 <20180508162226.GA31027@localhost.localdomain>
Message-ID: <b56cff21-0720-25d9-e599-bb9bd321dda0@kernel.dk>

On 5/8/18 10:22 AM, Keith Busch wrote:
> On Tue, May 08, 2018@09:54:20AM -0600, Jens Axboe wrote:
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1097,6 +1097,14 @@ static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
>>  	int flags = NVME_QUEUE_PHYS_CONTIG;
>>  
>>  	/*
>> +	 * Some drives have a bug that auto-enables WRRU if MEDIUM isn't
>> +	 * set. Since URGENT priority is zeroes, it makes all queues
>> +	 * URGENT.
>> +	 */
>> +	if (ctrl->quirks & NVME_QUIRK_MEDIUM_PRIO_SQ)
>> +		flags |= NVME_SQ_PRIO_MEDIUM;
> 
> 'ctrl' is undeclared in this function; must be 'dev->ctrl.quirks'.

Gah, that's a lot of typos in a simple patch... Sending out v3.

-- 
Jens Axboe
