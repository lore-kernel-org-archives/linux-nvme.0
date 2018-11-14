From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 14 Nov 2018 00:43:22 -0800
Subject: [PATCH 1/6] nvme: don't disable local ints for polled queue
In-Reply-To: <20181110151317.3813-2-axboe@kernel.dk>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-2-axboe@kernel.dk>
Message-ID: <20181114084322.GA14954@infradead.org>

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6aa86dfcb32c..a6e3fbddfadf 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1061,15 +1061,26 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
>  
>  static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
>  {
> +	unsigned long flags = 0; /* gcc 7.x fail */
>  	u16 start, end;
> -	bool found;
> +	bool found, has_irq;
>  
>  	if (!nvme_cqe_pending(nvmeq))
>  		return 0;
>  
> -	spin_lock_irq(&nvmeq->cq_lock);
> +	/*
> +	 * Polled queue doesn't have an IRQ, no need to disable ints
> +	 */
> +	has_irq = !nvmeq->polled;
> +	if (has_irq)
> +		local_irq_save(flags);
> +
> +	spin_lock(&nvmeq->cq_lock);
>  	found = nvme_process_cq(nvmeq, &start, &end, tag);
> -	spin_unlock_irq(&nvmeq->cq_lock);
> +	spin_unlock(&nvmeq->cq_lock);
> +
> +	if (has_irq)
> +		local_irq_restore(flags);

Eww, this just looks ugly.  Given that we are micro-optimizing here
I'd rather just use a different ->poll implementation and thus blk_mq_ops
if we have a separate poll code.  Then we could leave the existing
__nvme_poll as-is and have a new nvme_poll_noirq something like this:

static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx, unsigned int tag)
{
        struct nvme_queue *nvmeq = hctx->driver_data;
>  	u16 start, end;
	bool found;
>  
>  	if (!nvme_cqe_pending(nvmeq))
>  		return 0;
>  
> +	spin_lock(&nvmeq->cq_lock);
>  	found = nvme_process_cq(nvmeq, &start, &end, tag);
> +	spin_unlock(&nvmeq->cq_lock);
> +
>  	nvme_complete_cqes(nvmeq, start, end);
>  	return found;

And while we are at it:  I think for the irq-driven queuest in a
separate queue for poll setup we might not even need to take the
CQ lock.  Which might be an argument for only allowing polling
if we have the separate queues just to keep everything simple.
