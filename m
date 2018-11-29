From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 29 Nov 2018 10:06:20 -0700
Subject: [PATCH 3/7] nvme: implement mq_ops->commit_rqs() hook
In-Reply-To: <20181129170430.GA27364@infradead.org>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-4-axboe@kernel.dk>
 <20181129154713.GC7234@infradead.org>
 <2188627d-6d45-fe8a-8d31-fa46fdb82618@kernel.dk>
 <20181129170430.GA27364@infradead.org>
Message-ID: <64106f7d-73d9-70f3-7b28-9b836994d5aa@kernel.dk>

On 11/29/18 10:04 AM, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018@10:02:25AM -0700, Jens Axboe wrote:
>> On 11/29/18 8:47 AM, Christoph Hellwig wrote:
>>>> +static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
>>>> +{
>>>> +	if (++index == nvmeq->q_depth)
>>>> +		return 0;
>>>> +
>>>> +	return index;
>>>> +}
>>>
>>> This is unused now.
>>
>> Huh, wonder how I missed that. GCC must not have complained.
> 
> gcc never warns about unused static inline functions.  Which makes a lot
> of sense at least for headers..

Not so much for non-headers :-)

>>> Also what about this little cleanup on top?
>>
>> That looks good, I like it. With that, can I add your reviewed-by? I'll
>> run a sanity check on it first.
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Thanks!

-- 
Jens Axboe
