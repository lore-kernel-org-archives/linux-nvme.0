From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 17 May 2018 09:03:52 -0600
Subject: [PATCH] nvme: handle completions outside of the queue lock
In-Reply-To: <20180517074732.GA24736@infradead.org>
References: <da619fe4-a9ea-57e9-a731-e59a9043970e@kernel.dk>
 <20180517034750.GA22063@localhost.localdomain>
 <20180517071651.GC30079@infradead.org>
 <20180517074732.GA24736@infradead.org>
Message-ID: <20180517150351.GD22063@localhost.localdomain>

On Thu, May 17, 2018@12:47:32AM -0700, Christoph Hellwig wrote:
>  static irqreturn_t nvme_irq_check(int irq, void *data)
> @@ -1039,7 +1024,14 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
>  	nvme_process_cq(nvmeq, &start, &end);
>  	spin_unlock_irq(&nvmeq->q_lock);
>  
> -	return nvme_complete_cqes(nvmeq, start, end, tag);
> +	while (start != end) {
> +		if (nvme_handle_cqe(nvmeq, start, tag))
> +			return 1;

We can't return early from here anymore since the new interface moved
the CQ head. No one else is going to get to see those completions, so
the first caller owns completing everything up to the end that it claimed.
