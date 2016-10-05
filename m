From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 5 Oct 2016 15:21:15 +0200
Subject: [PATCH rfc 1/6] nvme-pci: Split __nvme_process_cq to poll and
 handle
In-Reply-To: <1475660534-16681-2-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <1475660534-16681-2-git-send-email-sagi@grimberg.me>
Message-ID: <20161005132115.myxhgu25ibro3rss@linux-x5ow.site>

On Wed, Oct 05, 2016@12:42:09PM +0300, Sagi Grimberg wrote:
> Just some rework to split the logic and make it slightly
> more readable. This will help us to easily add the irq-poll
> logic.
> 
> We remove the cqe_seen indication as a preparation for
> irq-poll where we will schedule soft-irq context for polling
> so we should consider the interrupt as handled always.
> 
> Also, introduce nvme_ring_cq_doorbell helper to mask out the
> cq_vector validity check.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---

[...]

> +static int __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
> +{
> +	struct nvme_completion cqe;
> +	int consumed = 0;
>  
> -	}
> +	while (nvme_read_cqe(nvmeq, &cqe)) {
> +		nvme_handle_cqe(nvmeq, &cqe);
>  
> -	/* If the controller ignores the cq head doorbell and continuously
> -	 * writes to the queue, it is theoretically possible to wrap around
> -	 * the queue twice and mistakenly return IRQ_NONE.  Linux only
> -	 * requires that 0.1% of your interrupts are handled, so this isn't
> -	 * a big problem.
> -	 */
> -	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
> -		return;
> +		if (tag && *tag == cqe.command_id) {
> +			*tag = -1;
> +			break;
> +		}
> +	}
>  
> -	if (likely(nvmeq->cq_vector >= 0))
> -		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
> -	nvmeq->cq_head = head;
> -	nvmeq->cq_phase = phase;
> +	if (consumed)
> +		nvme_ring_cq_doorbell(nvmeq);
>  
> -	nvmeq->cqe_seen = 1;
> +	return consumed;
>  }

Won't 'consumed' always be 0 here and we thus never call
nvme_ring_cq_doorbell()? Am I overlooking something here, or is this
just for preparation of later patches?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
