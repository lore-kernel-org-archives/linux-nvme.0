From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 30 May 2014 12:58:27 -0400
Subject: [PATCH v4] NVMe: basic conversion to blk-mq
In-Reply-To: <1401400285-25003-2-git-send-email-m@bjorling.me>
References: <1401400285-25003-1-git-send-email-m@bjorling.me>
 <1401400285-25003-2-git-send-email-m@bjorling.me>
Message-ID: <20140530165827.GE5499@linux.intel.com>

On Thu, May 29, 2014@11:51:25PM +0200, Matias Bj?rling wrote:
> +static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> +			  unsigned int i)
>  {
> +	struct nvme_dev *dev = data;
> +	struct nvme_queue *nvmeq = dev->queues[(i % dev->queue_count) + 1];
> +	BUG_ON(!nvmeq);
> +	WARN_ON(nvmeq->hctx);
> +	nvmeq->hctx = hctx;
> +	hctx->driver_data = nvmeq;
> +	return 0;
> +}

You can't call this parameter 'i'.  See Documentation/CodingStyle chapter 4.
