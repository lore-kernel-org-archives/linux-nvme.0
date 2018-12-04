From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Dec 2018 17:00:59 -0800
Subject: [PATCH 06/13] nvme-pci: refactor nvme_disable_io_queues
In-Reply-To: <20181202164628.1116-7-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-7-hch@lst.de>
Message-ID: <0997230c-a13e-65ea-130a-cca366336989@grimberg.me>


> @@ -2428,7 +2426,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	nvme_stop_queues(&dev->ctrl);
>   
>   	if (!dead && dev->ctrl.queue_count > 0) {
> -		nvme_disable_io_queues(dev);
> +		if (nvme_disable_io_queues(dev, nvme_admin_delete_sq))
> +			

Would be nice if the opcode change would be kept inside but still
split like:

static void nvme_disable_io_queues(struct nvme_dev *dev)
{
	if (__nvme_disable_io_queues(dev, nvme_admin_delete_sq))
		__nvme_disable_io_queues(dev, nvme_admin_delete_cq);
}
