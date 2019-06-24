From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 25 Jun 2019 05:21:10 +0900
Subject: [PATCH v3 5/5] nvme: add support weighted round robin queue
In-Reply-To: <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
Message-ID: <20190624202110.GD6526@minwooim-desktop>

> @@ -2627,7 +2752,30 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>  
>  static void nvme_pci_get_ams(struct nvme_ctrl *ctrl, u32 *ams)
>  {
> -	*ams = NVME_CC_AMS_RR;
> +	/* if deivce doesn't support WRR, force reset wrr queues to 0 */
> +	if (!NVME_CAP_AMS_WRRU(ctrl->cap)) {
> +		wrr_low_queues = 0;
> +		wrr_medium_queues = 0;
> +		wrr_high_queues = 0;
> +		wrr_urgent_queues = 0;

Could we avoid this kind of reset variables in get_XXX() function?  I
guess it would be great if it just tries to get some value which is
mainly focused to do.

> +
> +		*ams = NVME_CC_AMS_RR;
> +		ctrl->wrr_enabled = false;
> +		return;
> +	}
> +
> +	/*
> +	 * if device support WRR, check wrr queue count, all wrr queues are
> +	 * 0, don't enable device's WRR.
> +	 */
> +	if ((wrr_low_queues + wrr_medium_queues + wrr_high_queues +
> +				wrr_urgent_queues) > 0) {
> +		*ams = NVME_CC_AMS_WRRU;
> +		ctrl->wrr_enabled = true;
> +	} else {
> +		*ams = NVME_CC_AMS_RR;
> +		ctrl->wrr_enabled = false;

These two line can be merged into above condition:

	if (!NVME_CAP_AMS_WRRU(ctrl->cap) ||
		wrr_low_queues + wrr_medium_queues + wrr_high_queues +
			wrr_urgent_queues <= 0) {
		*ams = NVME_CC_AMS_RR;
		ctrl->wrr_enabled = false;
	}
