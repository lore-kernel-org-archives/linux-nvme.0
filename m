From: keith.busch@intel.com (Busch, Keith)
Date: Thu, 22 Oct 2015 14:44:19 +0000
Subject: [PATCH 6/9] nvme: abort requests on the reqeueue list when
 shutting down a controller
In-Reply-To: <1445515421-4940-7-git-send-email-hch@lst.de>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-7-git-send-email-hch@lst.de>
Message-ID: <20151022144419.GB21840@localhost.localdomain>

On Thu, Oct 22, 2015@02:03:38PM +0200, Christoph Hellwig wrote:
> Otherwise we might never complete them as nvme_clear_queue won't find these
> requests.

With this change, requests will be ended in failure even though they
may have succeeded immediately after a reset. Nvme's unfreeze kicks the
namespaces' requeue_list just for that reason.

We shouldn't want to abort the requeue list unless we're freeing the
request_queue too, right?

I'm still trying to figure out what gap this is filling.

>  static void nvme_dev_shutdown(struct nvme_dev *dev)
>  {
> +	struct nvme_ns *ns;
>  	int i;
>  	u32 csts = -1;
>  
>  	nvme_dev_list_remove(dev);
>  
> +	list_for_each_entry(ns, &dev->ctrl.namespaces, list)
> +		blk_mq_abort_requeue_list(ns->queue);
