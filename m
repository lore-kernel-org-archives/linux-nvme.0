From: hch@lst.de (Christoph Hellwig)
Date: Thu, 25 May 2017 10:30:23 +0200
Subject: [PATCH V2 1/1] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170524142623.GA27721@dhcp-216.srv.tuxera.com>
References: <20170524142623.GA27721@dhcp-216.srv.tuxera.com>
Message-ID: <20170525083023.GA22852@lst.de>

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4c2ff2b..ba54e2a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1903,9 +1903,6 @@ static void nvme_reset_work(struct work_struct *work)
>  	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
>  	int result = -ENODEV;
>  
> -	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
> -		goto out;

Can we keep a

	WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))

here?

>  		goto out;
> @@ -2009,8 +2003,8 @@ static int nvme_reset(struct nvme_dev *dev)
>  {
>  	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
>  		return -ENODEV;
> -	if (work_busy(&dev->reset_work))
> -		return -ENODEV;
> +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
> +		return -EBUSY;
>  	if (!queue_work(nvme_workq, &dev->reset_work))
>  		return -EBUSY;

nvme_probe will also have to set the state to NVME_CTRL_RESETTING to
keep the old behavior, which had some error handling implications.

Also we can replace the work_busy(&dev->reset_work) check in
nvme_should_reset with a check for the NVME_CTRL_RESETTING state now.
