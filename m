From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 9 Mar 2017 16:25:26 +0000
Subject: [PATCH rfc 04/10] block: Add a non-selective polling interface
In-Reply-To: <1489065402-14757-5-git-send-email-sagi@grimberg.me>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-5-git-send-email-sagi@grimberg.me>
Message-ID: <1489076712.2597.1.camel@sandisk.com>

On Thu, 2017-03-09@15:16 +0200, Sagi Grimberg wrote:
> +int blk_mq_poll_batch(struct request_queue *q, unsigned int batch)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	if (!q->mq_ops || !q->mq_ops->poll_batch)
> +		return 0;
> +
> +	hctx = blk_mq_map_queue(q, smp_processor_id());
> +	return q->mq_ops->poll_batch(hctx, batch);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_poll_batch);

A new exported function without any documentation? Wow. Please add a header
above this function that documents at least which other completion processing
code can execute concurrently with this function and from which contexts the
other completion processing code can be called (e.g. blk_mq_poll() and
.complete()).

Why to return if (!q->mq_ops || !q->mq_ops->poll_batch)? Shouldn't that be a
WARN_ON_ONCE() instead? I think it is an error to calling blk_mq_poll_batch()
against a queue that does not define .poll_batch().

Additionally, I think making the hardware context an argument of this function
instead of using blk_mq_map_queue(q, smp_processor_id()) would make this
function much more versatile.

Bart.
