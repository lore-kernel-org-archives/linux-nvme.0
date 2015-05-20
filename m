From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 20 May 2015 09:20:44 -0400
Subject: [PATCH] NVMe: nvme_queue made cache friendly.
In-Reply-To: <1432144863-31742-1-git-send-email-parav.pandit@avagotech.com>
References: <1432144863-31742-1-git-send-email-parav.pandit@avagotech.com>
Message-ID: <20150520132044.GD2729@linux.intel.com>

On Wed, May 20, 2015@02:01:03PM -0400, Parav Pandit wrote:
> nvme_queue structure made 64B cache friendly so that majority of the
> data elements of the structure during IO and completion path can be
> found in typical single 64B cache line size which was previously spanning beyond
> single 64B cache line size.

Have you done any performance measurements on this?  I find it hard to
believe that moving q_lock to the second 64B cache line results in a
performance improvement.  Seems to me it would result in a performance
loss, since you have to grab the lock before operating on the queue,
and cache line prefetching tends to prefetch the _next_ line, not the
_previous_ line.

> @@ -98,23 +98,23 @@ struct async_cmd_info {
>  struct nvme_queue {
>  	struct device *q_dmadev;
>  	struct nvme_dev *dev;
> -	char irqname[24];	/* nvme4294967295-65535\0 */
> -	spinlock_t q_lock;
>  	struct nvme_command *sq_cmds;
> +	struct blk_mq_hw_ctx *hctx;
>  	volatile struct nvme_completion *cqes;
> -	dma_addr_t sq_dma_addr;
> -	dma_addr_t cq_dma_addr;
>  	u32 __iomem *q_db;
>  	u16 q_depth;
> -	s16 cq_vector;
>  	u16 sq_head;
>  	u16 sq_tail;
>  	u16 cq_head;
>  	u16 qid;
> +	s16 cq_vector;
>  	u8 cq_phase;
>  	u8 cqe_seen;
> +	spinlock_t q_lock;
>  	struct async_cmd_info cmdinfo;
> -	struct blk_mq_hw_ctx *hctx;
> +	char irqname[24];	/* nvme4294967295-65535\0 */
> +	dma_addr_t sq_dma_addr;
> +	dma_addr_t cq_dma_addr;
>  };
>  
>  /*
> -- 
> 1.8.3.1
