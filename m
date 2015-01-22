From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Jan 2015 16:48:01 +0000 (UTC)
Subject: [patch] NVMe: return an error code if blk_mq_alloc_tag_set() fails
In-Reply-To: <54C07F45.4070406@kernel.dk>
References: <20150119144327.GE19086@mwanda> <54C07F45.4070406@kernel.dk>
Message-ID: <alpine.LNX.2.00.1501221626080.15481@localhost.lm.intel.com>

On Wed, 21 Jan 2015, Jens Axboe wrote:
> On 01/19/2015 07:43 AM, Dan Carpenter wrote:
>> In the current code, if blk_mq_alloc_tag_set() fails then it returns
>> zero (success) instead of preserving the error code.  The caller is not
>> expecting that and the kernel could be left in an inconsistent state.
>> 
>> Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
>
> Looks good to me, Keith, could you ack/review it? Leaving it below...

Should we bail on the device if tagset allocation fails? If so, the patch
is good, but I thought it was a concious descision to not return error
here so the controller can be managed. Capabilities would be limited
and a failure here probably means there's a bigger problem, so I'm okay
either way.

>> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
>> index cb529e9..2ff5efc 100644
>> --- a/drivers/block/nvme-core.c
>> +++ b/drivers/block/nvme-core.c
>> @@ -2152,7 +2152,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
>>   	dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>>   	dev->tagset.driver_data = dev;
>> 
>> -	if (blk_mq_alloc_tag_set(&dev->tagset))
>> +	res = blk_mq_alloc_tag_set(&dev->tagset);
>> +	if (res)
>>   		goto out;
>>
>>   	id_ns = mem;
