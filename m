From: keith.busch@intel.com (Keith Busch)
Date: Wed, 15 May 2019 13:15:19 -0600
Subject: [PATCH 1/2] nvme: add thermal zone infrastructure
In-Reply-To: <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190515191518.GA21916@localhost.localdomain>

On Thu, May 16, 2019@12:17:16AM +0900, Akinobu Mita wrote:
> +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_smart_log *log;
> +	int ret;
> +	int i;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return -ENOMEM;
> +
> +	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +			   log, sizeof(*log), 0);
> +	if (ret) {
> +		ret = ret > 0 ? -EINVAL : ret;
> +		goto free_log;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> +		struct thermal_zone_device *tzdev;
> +
> +		if (i && !le16_to_cpu(log->temp_sensor[i - 1]))
> +			continue;
> +		if (ctrl->tzdev[i])
> +			continue;
> +
> +		tzdev = nvme_thermal_zone_register(ctrl, i);
> +		if (!IS_ERR(tzdev))
> +			ctrl->tzdev[i] = tzdev;
> +	}
> +
> +free_log:
> +	kfree(log);
> +
> +	return ret;
> +}

Since this routine is intended for use in the device initialization path,
the error returns are extra important. We have used < 0 to indicate we
need to abandon initialization because we won't be able communicate with
the device if we proceed. Since thermal reporting is not mandatory to
manage our controllers, out-of-memory or a device that doesn't support
SMART should just return 0. We should only halt init if the controller
is unresponsive here.

In general, I'm okay with this feature.
