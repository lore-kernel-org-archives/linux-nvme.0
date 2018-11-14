From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 14 Nov 2018 12:18:05 +0200
Subject: [PATCH 1/6] nvme: don't disable local ints for polled queue
In-Reply-To: <20181110151317.3813-2-axboe@kernel.dk>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-2-axboe@kernel.dk>
Message-ID: <bef68ece-948c-026a-dd17-260cfd1409d8@mellanox.com>


On 11/10/2018 5:13 PM, Jens Axboe wrote:
> A polled queued doesn't trigger interrupts, so it's always safe
> to grab the queue lock without disabling interrupts.


Jens,

can you share the added value in performance for this change ?



> Cc: Keith Busch <keith.busch at intel.com>
> Cc: linux-nvme at lists.infradead.org
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>   drivers/nvme/host/pci.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6aa86dfcb32c..a6e3fbddfadf 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1061,15 +1061,26 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
>   
>   static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
>   {
> +	unsigned long flags = 0; /* gcc 7.x fail */
>   	u16 start, end;
> -	bool found;
> +	bool found, has_irq;
>   
>   	if (!nvme_cqe_pending(nvmeq))
>   		return 0;
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
>   	found = nvme_process_cq(nvmeq, &start, &end, tag);
> -	spin_unlock_irq(&nvmeq->cq_lock);
> +	spin_unlock(&nvmeq->cq_lock);
> +
> +	if (has_irq)
> +		local_irq_restore(flags);
>   
>   	nvme_complete_cqes(nvmeq, start, end);
>   	return found;
