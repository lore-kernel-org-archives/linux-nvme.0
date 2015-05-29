From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 29 May 2015 09:29:44 -0700
Subject: [PATCH 2/2] NVMe: Remove hctx reliance for multi-namespace
In-Reply-To: <1432838222-4076-2-git-send-email-keith.busch@intel.com>
References: <1432838222-4076-1-git-send-email-keith.busch@intel.com>
 <1432838222-4076-2-git-send-email-keith.busch@intel.com>
Message-ID: <20150529162944.GA31249@infradead.org>

> +static void nvme_exit_tags(void *data, unsigned int hctx_idx)
>  {
> +	struct nvme_dev *dev = data;
> +	struct nvme_queue *nvmeq = dev->queues[
> +					(hctx_idx % dev->queue_count) + 1];
> +	nvmeq->tags = NULL;
> +}
>  
> +static int nvme_init_tags(struct blk_mq_tags *tags, void *data,
> +			  unsigned int hctx_idx)
> +{
> +	struct nvme_dev *dev = data;
> +	struct nvme_queue *nvmeq = dev->queues[
> +					(hctx_idx % dev->queue_count) + 1];
> +	WARN_ON(nvmeq->tags);
> +	nvmeq->tags = tags;
> +	return 0;

I'd rather do the runtime indexing with the qid into the tags array than
adding these methods.  I also don't see why you need the modulo
arithmetic.

Otherwise the series looks nice to me.
