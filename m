From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Dec 2018 16:00:22 +0100
Subject: [PATCH 01/13] block: move queues types to the block layer
In-Reply-To: <5a1cd7aa-8937-ae23-c9ae-c8ddaf525080@grimberg.me>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-2-hch@lst.de>
 <5a1cd7aa-8937-ae23-c9ae-c8ddaf525080@grimberg.me>
Message-ID: <20181204150022.GA3440@lst.de>

On Mon, Dec 03, 2018@04:49:56PM -0800, Sagi Grimberg wrote:
>> @@ -103,12 +101,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>>   						     unsigned int flags,
>>   						     unsigned int cpu)
>>   {
>> -	int hctx_type = 0;
>> +	enum hctx_type type = HCTX_TYPE_DEFAULT;
>> +
>> +	if (q->tag_set->nr_maps > HCTX_TYPE_POLL &&
>> +	    ((flags & REQ_HIPRI) && test_bit(QUEUE_FLAG_POLL, &q->queue_flags)))
>> +		type = HCTX_TYPE_POLL;
>>   -	if (q->mq_ops->rq_flags_to_type)
>> -		hctx_type = q->mq_ops->rq_flags_to_type(q, flags);
>> +	else if (q->tag_set->nr_maps > HCTX_TYPE_READ &&
>> +		 ((flags & REQ_OP_MASK) == REQ_OP_READ))
>> +		type = HCTX_TYPE_READ;
>
> Nit, there seems to be an extra newline that can be omitted here before
> the else if statement (if I'm reading this correctly)...

Empty lines can always be ommited, but in this case I actually like it
as it seems to help readability..
