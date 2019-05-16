From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 16 May 2019 22:55:59 +0900
Subject: [PATCH 1/3] nvme: separate out nvme_ctrl_state_name()
In-Reply-To: <20190516083740.95894-2-hare@suse.de>
References: <20190516083740.95894-1-hare@suse.de>
 <20190516083740.95894-2-hare@suse.de>
Message-ID: <20190516135558.GC24001@minwooim-desktop>

Hi Hannes,

> +const char *nvme_ctrl_state_name(struct nvme_ctrl *ctrl)
> +{
> +	if ((unsigned)ctrl->state < ARRAY_SIZE(nvme_ctrl_state_names) &&
> +	    nvme_ctrl_state_names[ctrl->state])
> +		return nvme_ctrl_state_names[ctrl->state];
> +	return NULL;

Perhaps we can return "unknown" here that can make callers do not
need to consider that if it gives NULL and not return a string there also.

> @@ -2989,19 +3008,10 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
>  				     char *buf)
>  {
>  	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	static const char *const state_name[] = {
> -		[NVME_CTRL_NEW]		= "new",
> -		[NVME_CTRL_LIVE]	= "live",
> -		[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
> -		[NVME_CTRL_RESETTING]	= "resetting",
> -		[NVME_CTRL_CONNECTING]	= "connecting",
> -		[NVME_CTRL_DELETING]	= "deleting",
> -		[NVME_CTRL_DEAD]	= "dead",
> -	};
> -
> -	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
> -	    state_name[ctrl->state])
> -		return sprintf(buf, "%s\n", state_name[ctrl->state]);
> +	const char *state_name = nvme_ctrl_state_name(ctrl);
> +
> +	if (state_name)
> +		return sprintf(buf, "%s\n", state_name);
>  
>  	return sprintf(buf, "unknown state\n");

If so, we can make these three lines to a single one without considering
the NULL case.

What do you think?
