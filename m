From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 22 Jun 2015 11:06:15 -0400
Subject: [PATCH] NVMe: Use CMB for the SQ if available
In-Reply-To: <1434750357-29162-1-git-send-email-jonathan.derrick@intel.com>
References: <1434750357-29162-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20150622150615.GD1971@linux.intel.com>

On Fri, Jun 19, 2015@03:45:57PM -0600, Jon Derrick wrote:
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 12d5b7b..ebbba55 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -108,6 +108,8 @@ struct nvme_queue {
>  	dma_addr_t sq_dma_addr;
>  	dma_addr_t cq_dma_addr;
>  	u32 __iomem *q_db;
> +	bool cmb_mapped;
> +	struct nvme_command cmb_cmd ____cacheline_aligned;
>  	u16 q_depth;
>  	s16 cq_vector;
>  	u16 sq_head;

I don't like this.  Some of the places which submit commands today
construct the command on the stack, and others construct them directly
in the host-side queue memory.  I'd rather see them all construct on
the stack, rather than in the nvme_queue.

> @@ -376,7 +394,12 @@ static int __nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
>  {
>  	u16 tail = nvmeq->sq_tail;
>  
> -	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
> +	if (nvmeq->cmb_mapped)
> +		memcpy_toio(&nvmeq->sq_cmds[tail], cmd,
> +				sizeof(*cmd));
> +	else
> +		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
> +

This part is going to become common, and should be factored out; either an
inline function or a macro.

> @@ -1434,6 +1461,41 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
>  	spin_unlock_irq(&nvmeq->q_lock);
>  }
>  
> +static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
> +				int entry_size)
> +{
> +	int q_depth = dev->q_depth;
> +	unsigned q_size_aligned = roundup(q_depth * entry_size, dev->page_size);
> +	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
> +		q_depth = rounddown(dev->cmb_size / nr_io_queues,
> +					dev->page_size) / entry_size;
> +
> +		/* Ensure the reduced q_depth is above some threshold where it
> +		would be better to map queues in system memory with the
> +		original depth */
> +		if (q_depth < 64)
> +			return -ENOMEM;
> +	}
> +
> +	return q_depth;
> +}

It seems to me that rather than avoiding use of the CMB entirely if it's
too small, or the number of queues is too large, we should use the CMB
for the first N queues and use host memory for the rest.  Yes, there'll
be a performance difference between the queues, but there's already a
performance difference between queues in memory that's NUMA-local to
the adapter and memory that's NUMA-far.
