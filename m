From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 Feb 2016 10:53:16 -0800
Subject: [PATCH for-4.5 09/13] NVMe: Simplify device reset failure
In-Reply-To: <1455128250-5984-10-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-10-git-send-email-keith.busch@intel.com>
Message-ID: <20160210185316.GA10459@infradead.org>

> +	dev_warn(dev->dev, "Removing after probe failure status:%d\n", status);

Why not space after the colon?

>  static void nvme_reset_work(struct work_struct *work)
>  {
>  	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
> -	int result;
> +	int result = ENODEV;

negative errors, please.

> - remove:
> -	nvme_dev_list_remove(dev);
> - free_tags:
> -	nvme_dev_remove_admin(dev);
> -	blk_put_queue(dev->ctrl.admin_q);
> -	dev->ctrl.admin_q = NULL;
> -	dev->queues[0]->tags = NULL;
> - disable:
> -	nvme_disable_admin_queue(dev, false);
> - unmap:
> -	nvme_dev_unmap(dev);
>   out:
> -	nvme_remove_dead_ctrl(dev);
> +	nvme_remove_dead_ctrl(dev, result);

So this relies on the cleanup path to handle all states
of partial initialization.  I suspect you've audited this in
the current version, but the remove path could use a comment
stating that any edit will have to obey this restriction.
