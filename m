From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 27 Nov 2018 17:16:17 -0700
Subject: [PATCH 2/8] block: improve logic around when to sort a plug list
In-Reply-To: <20181128000501.GH846@vader>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-3-axboe@kernel.dk> <20181127233142.GB846@vader>
 <b6cfc7c8-39f4-252b-8c27-3a75f561061a@kernel.dk>
 <62f96268-f596-78b8-d227-6be1f5ae1cea@kernel.dk> <20181128000501.GH846@vader>
Message-ID: <142fca05-eb21-48ff-8dc3-ddc8797e7e1a@kernel.dk>

On 11/27/18 5:05 PM, Omar Sandoval wrote:
>> +static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>> +{
>> +	list_add_tail(&rq->queuelist, &plug->mq_list);
>> +	plug->rq_count++;
>> +	if (!plug->multiple_queues && !list_is_singular(&plug->mq_list)) {
>> +		struct request *tmp;
>> +
>> +		tmp = list_first_entry(&plug->mq_list, struct request,
>> +						queuelist);
>> +		if (tmp->q != rq->q)
>> +			plug->multiple_queues = true;
> 
> Actually, I thought we want to sort whenever there are different
> software/hardware queues on the plug list, even if they're on the same
> queue?

That was the original intent, but with the tons of testing I've done
lately, the cost of sorting batches is higher than the cost we pay for
having to do multiple inserts. So I think the only sane case is >= 3
requests, and multiple queues.

-- 
Jens Axboe
