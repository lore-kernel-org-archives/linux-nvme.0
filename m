From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 13 Feb 2016 01:46:34 -0800
Subject: [PATCHv2-4.5 08/10] NVMe: Move error handling to failed reset
 handler
In-Reply-To: <1455221147-24228-9-git-send-email-keith.busch@intel.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
 <1455221147-24228-9-git-send-email-keith.busch@intel.com>
Message-ID: <20160213094634.GB15318@infradead.org>

On Thu, Feb 11, 2016@01:05:45PM -0700, Keith Busch wrote:
> This moves failed queue handling out of the namespace removal path and into
> the reset failure path, fixing a deadlock condition if the controller
> fails or link down during del_gendisk. Previously the driver had to see
> the controller as degraded prior to calling del_gendisk to setup the
> queues to fail. If the controller happened to fail after this though,
> there was no task to end the request_queue.
> 
> On failure, all namespace states are set to 'dead'. This has capacity
> revalidate to 0, and ends all new requests with error status.

I like this a lot, but a few comments below:

> +/**
> + * nvme_kill_ns_queues(): Ends all namespace queues
> + * @ctrl: the dead controller that needs to end
> + *
> + * Call this function when the driver determines it is unable to get the
> + * controller in a state capable of servicing IO.
> + */
> +void nvme_kill_ns_queues(struct nvme_ctrl *ctrl)

Why do we have a separate function for this instead of driving this
from nvme_remove_namespaces?

> @@ -678,7 +678,9 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	spin_lock_irq(&nvmeq->q_lock);
>  	if (unlikely(nvmeq->cq_vector < 0)) {
> -		ret = BLK_MQ_RQ_QUEUE_BUSY;
> +		ret = test_bit(NVME_NS_DEAD, &ns->flags) ?
> +					BLK_MQ_RQ_QUEUE_ERROR :
> +					BLK_MQ_RQ_QUEUE_BUSY;

This would be easier to read with a good old 'if'.
