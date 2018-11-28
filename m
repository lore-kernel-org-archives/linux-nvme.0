From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 28 Nov 2018 06:07:29 -0700
Subject: [PATCH 4/8] nvme: implement mq_ops->commit_rqs() hook
In-Reply-To: <20181128072037.GB11774@infradead.org>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-5-axboe@kernel.dk>
 <20181128072037.GB11774@infradead.org>
Message-ID: <9f2f7b6a-0b6b-30af-94b1-b30259a1ecbb@kernel.dk>

On 11/28/18 12:20 AM, Christoph Hellwig wrote:
>> +static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
>> +{
>> +	if (++index == nvmeq->q_depth)
>> +		return 0;
>> +
>> +	return index;
> 
> Can you please just drop this helper?  It makes the code not only
> less readable but also longer.
> 
> Otherwise the change looks fine to me.

Alright, dropped the helper.

-- 
Jens Axboe
