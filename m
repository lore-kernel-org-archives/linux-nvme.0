From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 3 Feb 2017 00:16:34 -0800
Subject: [PATCH v5 3/4] nvme: Add Support for Opal: Unlock from S3 & Opal
 Allocation/Ioctls
In-Reply-To: <1485857844-15130-4-git-send-email-scott.bauer@intel.com>
References: <1485857844-15130-1-git-send-email-scott.bauer@intel.com>
 <1485857844-15130-4-git-send-email-scott.bauer@intel.com>
Message-ID: <20170203081634.GD25892@infradead.org>

> +int nvme_opal_initialize(struct nvme_ctrl *ctrl)
> +{
> +	/* Opal dev has already been initialized for this controller */
> +	if (ctrl->opal_dev.initialized)
> +		return 0;
> +	init_opal_dev(&ctrl->opal_dev, &nvme_sec_submit);
> +
> +	if (check_opal_support(&ctrl->opal_dev, NULL, NULL) < 0)
> +		dev_warn(ctrl->device, "Opal is not supported\n");
> +
> +	return 0;
> +}

Can you move the initialized and supported checks into init_opal_dev?

That way we can remove this function entirely.

> +void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl)
> +{
> +	if (!ctrl->opal_dev.supported)
> +		return;
> +	if (opal_unlock_from_suspend(&ctrl->opal_dev))
> +		dev_warn(ctrl->dev, "Failed to unlock one or more locking ranges!\n");

Similarly I think the supported check should simply go into 
opal_unlock_from_suspend, and the nvme-pci driver could call 
opal_unlock_from_suspend directly.
