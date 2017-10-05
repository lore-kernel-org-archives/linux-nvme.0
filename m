From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 5 Oct 2017 00:57:30 -0700
Subject: [PATCH v2 2/7] nvme_fc: change ctlr state assignments during
 reset/reconnect
In-Reply-To: <20170927045046.22238-3-jsmart2021@gmail.com>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-3-jsmart2021@gmail.com>
Message-ID: <20171005075730.GA5063@infradead.org>

>  	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> -	WARN_ON_ONCE(!changed);
>  
>  	ctrl->ctrl.nr_reconnects = 0;
>  
> -	nvme_start_ctrl(&ctrl->ctrl);
> +	if (changed)
> +		nvme_start_ctrl(&ctrl->ctrl);

It's just cosmetic, but can you folow the RDMA pattern here:

	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
	if (!changed) {
		/* state change failure is ok if we're in DELETING state */
		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
		return;
	}

else the patch looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
