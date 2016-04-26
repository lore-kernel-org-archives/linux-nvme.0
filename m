From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 26 Apr 2016 10:18:34 -0600
Subject: [PATCH 2/5] nvme: introduce a controller state machine
In-Reply-To: <1461671520-4758-3-git-send-email-hch@lst.de>
References: <1461671520-4758-1-git-send-email-hch@lst.de>
 <1461671520-4758-3-git-send-email-hch@lst.de>
Message-ID: <20160426161833.GA13324@localhost.localdomain>

Hi Christoph,

> @@ -1835,7 +1829,7 @@ static void nvme_reset_work(struct work_struct *work)
>  	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
>  	int result = -ENODEV;
>  
> -	if (WARN_ON(test_bit(NVME_CTRL_RESETTING, &dev->flags)))
> +	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
>  		goto out;
>  
>  	/*
> @@ -1845,7 +1839,8 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
>  		nvme_dev_disable(dev, false);
>  
> -	set_bit(NVME_CTRL_RESETTING, &dev->flags);
> +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
> +		goto out;
>  
Seems redundant to above WARN_ON test


Otherwise looks good

Acked-by Jon Derrick: <jonathan.derrick at intel.com>
