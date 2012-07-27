From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 27 Jul 2012 10:07:24 -0400
Subject: [PATCH] NVMe: Do not set queue depth beyond device max
In-Reply-To: <1343341268-24613-1-git-send-email-keith.busch@intel.com>
References: <1343341268-24613-1-git-send-email-keith.busch@intel.com>
Message-ID: <20120727140724.GJ22985@linux.intel.com>

On Thu, Jul 26, 2012@04:21:08PM -0600, Keith Busch wrote:
> Set the depth to the device maximum if the requested depth exceeds the
> device's capabilities.

The problem is that nvme_alloc_queue is called for both IO queues and
the admin queue, but MQES only applies to the IO queues.

I think we need to read it in nvme_setup_io_queues() instead.  This also
has the advantage of only reading MQES once instead of once per queue.

> @@ -892,8 +892,12 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
>  							int depth, int vector)
>  {
>  	struct device *dmadev = &dev->pci_dev->dev;
> -	unsigned extra = (depth / 8) + (depth * sizeof(struct nvme_cmd_info));
> -	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq) + extra, GFP_KERNEL);
> +	unsigned extra;
> +	struct nvme_queue *nvmeq;
> +
> +	depth = min_t(int, NVME_CAP_MQES(readq(&dev->bar->cap)) + 1, depth);
> +	extra = DIV_ROUND_UP(depth, 8) + (depth * sizeof(struct nvme_cmd_info));
> +	nvmeq = kzalloc(sizeof(*nvmeq) + extra, GFP_KERNEL);
>  	if (!nvmeq)
>  		return NULL;
>  
