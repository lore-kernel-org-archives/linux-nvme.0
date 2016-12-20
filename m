From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 19 Dec 2016 22:21:04 -0800
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
Message-ID: <20161220062104.GC4765@infradead.org>

> +static int nvme_sec_send(void *ctrl_data, u16 spsp, u8 secp,
> +			 void *buf, size_t len)
> +{
> +	return nvme_sec_submit(ctrl_data, spsp, secp, buf, len,
> +			       nvme_admin_security_send);
> +}
> +
> +static int nvme_sec_recv(void *ctrl_data, u16 spsp, u8 secp,
> +			 void *buf, size_t len)
> +{
> +	return nvme_sec_submit(ctrl_data, spsp, secp, buf, len,
> +			       nvme_admin_security_recv);
> +}
> +
> +static const struct sec_ops nvme_sec_ops = {
> +	.sec_send = nvme_sec_send,
> +	.sec_recv = nvme_sec_recv,
> +};

Just make sec_submit the callback passed to the core and avoid
this boiler-plate code.

>  
> +int nvme_opal_initialize(struct nvme_ctrl *ctrl)
> +{
> +	/* Opal dev has already been allocated for this controller */
> +	if (ctrl->sed_ctx.dev)
> +		return 0;
> +
> +	ctrl->sed_ctx.dev = alloc_opal_dev(ctrl->admin_q);
> +	if (!ctrl->sed_ctx.dev)
> +		return -ENOMEM;
> +	ctrl->sed_ctx.ops = &nvme_sec_ops;
> +	ctrl->sed_ctx.sec_data = ctrl;

No need for sec_data callback, just pass the sed_ctx to the driver
and use container_of to get at the containing structure.
