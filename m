From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Tue, 21 May 2019 15:05:41 -0600
Subject: [PATCH v2 2/4] nvme: add thermal zone infrastructure
In-Reply-To: <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
Message-ID: <44154394-c0a0-4895-d406-ea357a906cfe@intel.com>



On 5/21/2019 10:04 AM, Akinobu Mita wrote:
> +static int nvme_set_over_temp_thresh(struct nvme_ctrl *ctrl,
> +				     unsigned int sensor, int temp)
> +{
> +	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
> +	int status;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(sensor >= ARRAY_SIZE(ctrl->tzdev)))
> +		return -EINVAL;
> +
> +	if (temp > NVME_TEMP_THRESH_MASK)
> +		return -EINVAL;
> +
> +	threshold |= temp & NVME_TEMP_THRESH_MASK;
> +
> +	ret = nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
> +				&status);

I'm not sure about best practices here but since 'status' is unused, you
can pass in a NULL pointer. The called function deals with it correctly.

> +
> +	return ret > 0 ? -EINVAL : ret;
> +}
> +
