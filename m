From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Mar 2017 10:15:13 +0200
Subject: [PATCH rfc 04/10] block: Add a non-selective polling interface
In-Reply-To: <1489076712.2597.1.camel@sandisk.com>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-5-git-send-email-sagi@grimberg.me>
 <1489076712.2597.1.camel@sandisk.com>
Message-ID: <b8124df3-bd09-2eb2-9899-3c9195605510@grimberg.me>


>> +int blk_mq_poll_batch(struct request_queue *q, unsigned int batch)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +
>> +	if (!q->mq_ops || !q->mq_ops->poll_batch)
>> +		return 0;
>> +
>> +	hctx = blk_mq_map_queue(q, smp_processor_id());
>> +	return q->mq_ops->poll_batch(hctx, batch);
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_poll_batch);
>
> A new exported function without any documentation? Wow.

I just copied blk_mq_poll export...

> Please add a header
> above this function that documents at least which other completion processing
> code can execute concurrently with this function and from which contexts the
> other completion processing code can be called (e.g. blk_mq_poll() and
> .complete()).

I can do that, I'll document blk_mq_poll too..

> Why to return if (!q->mq_ops || !q->mq_ops->poll_batch)? Shouldn't that be a
> WARN_ON_ONCE() instead? I think it is an error to calling blk_mq_poll_batch()
> against a queue that does not define .poll_batch().

Not really, we don't know if the block driver actually supports 
poll_batch (or poll for that matter). Instead of conditioning in the
call-site, we condition within the call.

Its not really a bug, its harmless.

> Additionally, I think making the hardware context an argument of this function
> instead of using blk_mq_map_queue(q, smp_processor_id()) would make this
> function much more versatile.

What do you mean? remember that the callers interface to the device is
a request queue, it doesn't even know if its a blk-mq device. Can you
explain in more details what you would like to see?
