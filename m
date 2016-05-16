From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Mon, 16 May 2016 19:19:34 -0300
Subject: [PATCH] Use MICRO UINT_MAX instead of actual value
In-Reply-To: <20160430101303.GB27909@huangminfeis-MacBook-Pro.local>
References: <1461554009-1695-1-git-send-email-mnghuan@gmail.com>
 <20160430101303.GB27909@huangminfeis-MacBook-Pro.local>
Message-ID: <201605162219.u4GMItgk019087@mx0a-001b2d01.pphosted.com>

On 04/30/2016 07:13 AM, Minfei Huang wrote:
> Ping.
>
> Any comment is appreciate.

Hi Minfei, I guess a good idea would be to resend the patch with the 
typo fixed, as a v2 patch. What do you think?

Cheers,


Guilherme

>
> Thanks
> Minfei
>
> On 04/25/16@11:13P, Minfei Huang wrote:
>> It's more elegant to use MICRO UINT_MAX to represent the max value of
>> type unsigned int. So replace the actual value by using this MICRO.
>>
>> Signed-off-by: Minfei Huang <mnghuan at gmail.com>
>> ---
>>   drivers/nvme/host/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 643f457..2c0bb13 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -597,7 +597,7 @@ static void nvme_config_discard(struct nvme_ns *ns)
>>
>>   	ns->queue->limits.discard_alignment = logical_block_size;
>>   	ns->queue->limits.discard_granularity = logical_block_size;
>> -	blk_queue_max_discard_sectors(ns->queue, 0xffffffff);
>> +	blk_queue_max_discard_sectors(ns->queue, UINT_MAX);
>>   	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
>>   }
>>
>> --
>> 2.6.3
>>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
