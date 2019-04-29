From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Apr 2019 16:18:34 -0700
Subject: [PATCH V2 2/3] nvme: improve logging
In-Reply-To: <20190429032442.5923-3-chaitanya.kulkarni@wdc.com>
References: <20190429032442.5923-1-chaitanya.kulkarni@wdc.com>
 <20190429032442.5923-3-chaitanya.kulkarni@wdc.com>
Message-ID: <dfc245f5-e311-9b87-d308-dea143592ebd@grimberg.me>


> -	if (changed)
> +	if (changed) {
>   		ctrl->state = new_state;
> +		dev_info(ctrl->device, "state change from (%s -> %s)\n",
> +				nvme_get_ctrl_state_name(new_state),
> +					nvme_get_ctrl_state_name(ctrl->state));

dev_info is too chatty... dev_dbg please...

> @@ -2960,21 +2978,8 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
>   				     char *buf)
>   {
>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> -	static const char *const state_name[] = {
> -		[NVME_CTRL_NEW]		= "new",
> -		[NVME_CTRL_LIVE]	= "live",
> -		[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
> -		[NVME_CTRL_RESETTING]	= "resetting",
> -		[NVME_CTRL_CONNECTING]	= "connecting",
> -		[NVME_CTRL_DELETING]	= "deleting",
> -		[NVME_CTRL_DEAD]	= "dead",
> -	};

Patch #1 should erase this table here.

> -
> -	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
> -	    state_name[ctrl->state])
> -		return sprintf(buf, "%s\n", state_name[ctrl->state]);
> -
> -	return sprintf(buf, "unknown state\n");
> +
> +	return sprintf(buf, "%s\n", nvme_get_ctrl_state_name(ctrl->state));
>   }
>   
>   static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
> 
