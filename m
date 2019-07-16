From: hch@lst.de (Christoph Hellwig)
Date: Tue, 16 Jul 2019 08:04:30 +0200
Subject: [PATCH 2/3] nvme: Retrieve the required IO queue entry size
 from the controller
In-Reply-To: <20190716004649.17799-2-benh@kernel.crashing.org>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
 <20190716004649.17799-2-benh@kernel.crashing.org>
Message-ID: <20190716060430.GB29414@lst.de>

> +	/* Use default IOSQES. We'll update it later if needed */
>  	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>  	ctrl->ctrl_config |= NVME_CC_ENABLE;
>  
> @@ -2698,6 +2699,30 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		ctrl->hmmin = le32_to_cpu(id->hmmin);
>  		ctrl->hmminds = le32_to_cpu(id->hmminds);
>  		ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
> +
> +		/* Grab required IO queue size */
> +		ctrl->iosqes = id->sqes & 0xf;
> +		if (ctrl->iosqes < NVME_NVM_IOSQES) {
> +			dev_err(ctrl->device,
> +				"unsupported required IO queue size %d\n", ctrl->iosqes);
> +			ret = -EINVAL;
> +			goto out_free;
> +		}
> +		/*
> +		 * If our IO queue size isn't the default, update the setting
> +		 * in CC:IOSQES.
> +		 */
> +		if (ctrl->iosqes != NVME_NVM_IOSQES) {
> +			ctrl->ctrl_config &= ~(0xfu << NVME_CC_IOSQES_SHIFT);
> +			ctrl->ctrl_config |= ctrl->iosqes << NVME_CC_IOSQES_SHIFT;
> +			ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC,
> +						     ctrl->ctrl_config);
> +			if (ret) {
> +				dev_err(ctrl->device,
> +					"error updating CC register\n");
> +				goto out_free;
> +			}
> +		}

Actually, this doesn't work on a "real" nvme controller, to change CC
values the controller needs to be disabled.  So back to the version
you circulated to me in private mail that just sets q->sqes and has a
comment that this is magic for The Apple controller.  If/when we get
standardized large SQE support we'll need to discover that earlier or
do a disable/enable dance.  Sorry for misleading you down this road and
creating the extra work.  
