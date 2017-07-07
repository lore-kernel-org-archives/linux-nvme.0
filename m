From: hch@lst.de (Christoph Hellwig)
Date: Fri, 7 Jul 2017 20:11:46 +0200
Subject: [PATCH 6/7] nvme: Unexport starting async event work
In-Reply-To: <1499444581-28268-7-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-7-git-send-email-keith.busch@intel.com>
Message-ID: <20170707181146.GB24427@lst.de>

> +static void nvme_queue_async_events(struct nvme_ctrl *ctrl)
>  {
>  	queue_work(nvme_wq, &ctrl->async_event_work);
>  }
> -EXPORT_SYMBOL_GPL(nvme_queue_async_events);

I'd just kill this helper now that it's not even exported.
