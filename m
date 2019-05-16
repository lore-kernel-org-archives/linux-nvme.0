From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 16 May 2019 23:32:14 +0900
Subject: [PATCH 1/2] nvme: add thermal zone infrastructure
In-Reply-To: <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190516143212.GE24001@minwooim-desktop>

> +	if (sensor < 0 || sensor > 8)
> +		return -EINVAL;

Does we really need to check the negative case here ?  Am I missing
something in this context ?  If we really want to check it in this
level, can we check the invalid case in the following function?

> +static struct thermal_zone_device *
> +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, int sensor)
> +{
> +	struct thermal_zone_device *tzdev;
> +	char type[THERMAL_NAME_LENGTH];
> +	int ret;
> +
> +	snprintf(type, sizeof(type), "nvme_temp%d", sensor);

Before preparing "nvme_temp%d", maybe we can make it sure here. :)
What do you say?

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

Quenstion here. Are we okay not to print some warnings here in case
of error returned?
