From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 19 Dec 2016 22:49:01 -0800
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
Message-ID: <20161220064901.GB13844@infradead.org>

> +void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl)
> +{
> +	if (opal_unlock_from_suspend(&ctrl->sed_ctx))
> +		pr_warn("Failed to unlock one or more locking ranges!\n");
> +}
> +EXPORT_SYMBOL_GPL(nvme_unlock_from_suspend);

I don't think we even need this wrapper.  Also for the warning please
use dev_warn so that the user knows which controller failed.

> @@ -1765,7 +1766,7 @@ static void nvme_reset_work(struct work_struct *work)
>  {
>  	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
>  	int result = -ENODEV;
> -
> +	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
>  	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))

Please don't remove the empty line after the variable declarations.
Also I would place your new line before the result line, as that makes
it a tad easier to read.
