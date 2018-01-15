From: keith.busch@intel.com (Keith Busch)
Date: Sun, 14 Jan 2018 19:00:16 -0700
Subject: [PATCH V2] nvme: free pre-allocated queue if create ioq goes wrong
In-Reply-To: <1515963650-3805-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1515963650-3805-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <20180115020016.GB13580@localhost.localdomain>

On Mon, Jan 15, 2018@06:00:50AM +0900, Minwoo Im wrote:
>  static const struct blk_mq_ops nvme_mq_admin_ops = {
>  	.queue_rq	= nvme_queue_rq,
>  	.complete	= nvme_pci_complete_rq,
> @@ -1637,8 +1636,10 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
>  	max = min(dev->max_qid, dev->ctrl.queue_count - 1);
>  	for (i = dev->online_queues; i <= max; i++) {
>  		ret = nvme_create_queue(dev->queues[i], i);
> -		if (ret)
> +		if (ret) {
> +			nvme_free_queues(dev, dev->online_queues);
>  			break;
> +		}
>  	}

Unless this is the very first pass at initialisation, I don't think we
can free queues until after blk_mq_update_nr_hw_queues since the hctx
could otherwise point to freed memory.
