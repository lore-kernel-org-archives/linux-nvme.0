From: m@bjorling.me (=?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?=)
Date: Thu, 16 Apr 2015 12:23:00 +0200
Subject: [PATCH 2/5 v2] blk-mq: Support for Open-Channel SSDs
In-Reply-To: <1429175408.16771.45.camel@x220>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>	
 <1429101284-19490-3-git-send-email-m@bjorling.me>
 <1429175408.16771.45.camel@x220>
Message-ID: <552F8D84.8030504@bjorling.me>

On 04/16/2015 11:10 AM, Paul Bolle wrote:
> A few things I spotted (while actually fiddling with 3/5).

Thanks. I'll fix them up.

>
> On Wed, 2015-04-15@14:34 +0200, Matias Bj?rling wrote:
>> index f3dd028..58a8a71 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -221,6 +221,9 @@ static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
>>   	rq->end_io = NULL;
>>   	rq->end_io_data = NULL;
>>   	rq->next_rq = NULL;
>> +#if CONFIG_BLK_DEV_NVM
>
> I think you meant
>      #ifdef CONFIG_BLK_DEV_NVM
>
>> +	rq->phys_sector = 0;
>> +#endif
>>
>>   	ctx->rq_dispatched[rw_is_sync(rw_flags)]++;
>>   }
>
>> --- /dev/null
>> +++ b/block/blk-nvm.c
>
>> +int nvm_register_target(struct nvm_target_type *tt)
>> +{
>> +	int ret = 0;
>> +
>> +	down_write(&_lock);
>> +	if (nvm_find_target_type(tt->name))
>> +		ret = -EEXIST;
>> +	else
>> +		list_add(&tt->list, &_targets);
>> +	up_write(&_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +void nvm_unregister_target(struct nvm_target_type *tt)
>> +{
>> +	if (!tt)
>> +		return;
>> +
>> +	down_write(&_lock);
>> +	list_del(&tt->list);
>> +	up_write(&_lock);
>> +}
>
> Trying to build rrpc.ko I saw this
>      WARNING: "nvm_unregister_target" [[...]/drivers/lightnvm/rrpc.ko] undefined!
>      WARNING: "nvm_register_target" [[...]/drivers/lightnvm/rrpc.ko] undefined!
>
> So I guess you need to export these two functions too.
>
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -209,6 +209,9 @@ struct request {
>>
>>   	/* for bidi */
>>   	struct request *next_rq;
>> +#if CONFIG_BLK_DEV_NVM
>
> Again, I think
>      #ifdef CONFIG_BLK_DEV_NVM
>
>> +	sector_t phys_sector;
>> +#endif
>>   };
>>
>>   static inline unsigned short req_get_ioprio(struct request *req)
>
>
> Paul Bolle
>
