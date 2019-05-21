From: kbusch@kernel.org (Keith Busch)
Date: Tue, 21 May 2019 10:15:32 -0600
Subject: [PATCH v2 2/4] nvme: add thermal zone infrastructure
In-Reply-To: <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190521161532.GD1639@localhost.localdomain>

On Wed, May 22, 2019@01:04:07AM +0900, Akinobu Mita wrote:
> +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_smart_log *log;
> +	int ret;
> +	int i;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return 0; /* non-fatal error */
> +
> +	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +			   log, sizeof(*log), 0);
> +	if (ret) {
> +		dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
> +		ret = ret > 0 ? -EINVAL : ret;

A ret > 0 means the device provided a response, so don't return a
negative for that condition, please. That's just going to break
controllers that don't provide smart data, like qemu.
