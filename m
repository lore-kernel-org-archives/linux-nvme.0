From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 16 May 2018 16:57:56 -0600
Subject: nvme: batch completions and do them outside of the queue lock
In-Reply-To: <20180516223538.GE20223@localhost.localdomain>
References: <528cf765-16ae-5499-8843-9a62b4fd8326@kernel.dk>
 <20180516212757.GD20223@localhost.localdomain>
 <20180516223538.GE20223@localhost.localdomain>
Message-ID: <5e2e6da5-70ca-5b32-d02a-04baf2df1e9a@kernel.dk>

On 5/16/18 4:35 PM, Keith Busch wrote:
> On Wed, May 16, 2018@03:27:57PM -0600, Keith Busch wrote:
>> On Wed, May 16, 2018@02:37:40PM -0600, Jens Axboe wrote:
>>> This patch splits up the reaping of completion entries, and the
>>> block side completion. The advantage of this is two-fold:
>>>
>>> 1) We can batch completions, this patch pulls them off in units
>>>    of 8, but that number is fairly arbitrary. I wanted it to be
>>>    big enough to hold most use cases, but not big enough to be
>>>    a stack burden.
>>>
>>> 2) We complete the block side of things outside of the queue lock.
>>
>> Interesting idea. Since you bring this up, I think there may be more
>> optimizations on top of this concept. I'll stare at this a bit before
>> applying, or may have a follow-up proposal later.
> 
> While I'm not seeing a difference, I assume you are. I tried adding on
> to this proposal by batching *all* completions without using the stack,
> exploiting the fact we never wrap the queue so it can be accessed
> lockless after moving the cq_head.

That looks nifty.

> +	*start = nvmeq->cq_head;
> +	while (nvme_read_cqe(nvmeq));

Probably want to make that

	*start = nvmeq->cq_head;
	while (nvme_read_cqe(nvmeq))
		;

so it doesn't look like a misplaced ;.

Apart from that, looks pretty clean to me. Haven't tested it yet.
 
-- 
Jens Axboe
