From: hch@lst.de (Christoph Hellwig)
Date: Tue, 22 May 2018 12:00:56 +0200
Subject: [PATCHv2 02/11] nvme: submit AEN event configuration on startup
In-Reply-To: <20180522091004.39620-3-hare@suse.de>
References: <20180522091004.39620-1-hare@suse.de>
 <20180522091004.39620-3-hare@suse.de>
Message-ID: <20180522100056.GA11894@lst.de>

> +void nvme_enable_aen(struct nvme_ctrl *ctrl)
> +{
> +	u32 aen_cfg = NVME_SMART_CRIT_SPARE | NVME_SMART_CRIT_TEMPERATURE |
> +		NVME_SMART_CRIT_RELIABILITY | NVME_SMART_CRIT_MEDIA |
> +		NVME_SMART_CRIT_VOLATILE_MEMORY;

Currently the kernel doesn't really care about smart warnings at
all.  Should we make this a sysfs to that people only enable if they
actually care?

> +	u32 result;
> +	int status;
> +
> +	aen_cfg |= ctrl->aen_cfg;
> +	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT,
> +				   aen_cfg, NULL, 0, &result);
> +	if (status)
> +		dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
> +			 aen_cfg);
> +}
> +

If status is negative we should abort the reset, so we need to pass
that on.

> @@ -2345,6 +2361,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  
>  	ctrl->oacs = le16_to_cpu(id->oacs);
>  	ctrl->oncs = le16_to_cpup(&id->oncs);
> +	ctrl->aen_cfg = le32_to_cpu(id->oaes) &
> +		(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT);

Hmm.  I'd rather store the oaes value in nvme_ctrl and do this
calculation in nvme_enable_aen.
