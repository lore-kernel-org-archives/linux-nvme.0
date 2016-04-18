From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 18 Apr 2016 21:36:58 +0300
Subject: [PATCH 2/5] nvme: introduce a controller state machine
In-Reply-To: <1460982893-11315-3-git-send-email-hch@lst.de>
References: <1460982893-11315-1-git-send-email-hch@lst.de>
 <1460982893-11315-3-git-send-email-hch@lst.de>
Message-ID: <5715294A.3020309@grimberg.me>


> @@ -1893,7 +1888,10 @@ static void nvme_reset_work(struct work_struct *work)
>   		nvme_dev_add(dev);
>   	}
>
> -	clear_bit(NVME_CTRL_RESETTING, &dev->flags);
> +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
> +		dev_warn(dev->ctrl.device, "failed to mark controller live\n");
> +		goto out;
> +	}
>   	return;
>
>    out:

You're missing a state change before removing a
dead controller...
