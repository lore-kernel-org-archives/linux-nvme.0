From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 31 May 2016 14:04:46 -0700
Subject: [PATCH 1/2] NVMe: Add controller state for scheduling resets
In-Reply-To: <1464724148-11169-1-git-send-email-keith.busch@intel.com>
References: <1464724148-11169-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160531210446.GA1338@infradead.org>

> +int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_SCHED_RESET))
> +		return -EBUSY;
> +
> +	return ctrl->ops->reset_ctrl(ctrl);
> +}
> +EXPORT_SYMBOL(nvme_reset_ctrl);

should be EXPORT_SYMBOL_GPL to match all the other symbols.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
