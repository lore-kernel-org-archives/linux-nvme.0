From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 May 2016 03:58:07 -0700
Subject: [PATCH] NVMe: Fix possible scheduling while atomic error
In-Reply-To: <1463521062-16488-1-git-send-email-keith.busch@intel.com>
References: <1463521062-16488-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160523105807.GC26331@infradead.org>

On Tue, May 17, 2016@03:37:42PM -0600, Keith Busch wrote:
>  		spin_unlock_irq(ns->queue->queue_lock);
>  
> -		blk_mq_cancel_requeue_work(ns->queue);
>  		blk_mq_stop_hw_queues(ns->queue);
>  	}
>  	rcu_read_unlock();
> @@ -1836,7 +1835,10 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
> -		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
> +		spin_lock_irq(ns->queue->queue_lock);
> +		queue_flag_clear(QUEUE_FLAG_STOPPED, ns->queue);
> +		spin_unlock_irq(ns->queue->queue_lock);

What's the rationale for this change? 

> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -609,6 +609,12 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	spin_unlock_irq(&nvmeq->q_lock);
>  	return BLK_MQ_RQ_QUEUE_OK;
>  out:
> +	if (ret == BLK_MQ_RQ_QUEUE_BUSY) {
> +		spin_lock_irq(ns->queue->queue_lock);
> +		if (blk_queue_stopped(req->q))
> +			blk_mq_stop_hw_queues(ns->queue);
> +		spin_unlock_irq(ns->queue->queue_lock);

Shouldn't we do this where set the stopped flag on the queue instead?
