From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Jun 2017 19:29:06 +0300
Subject: [PATCH] nvme: move reset workqueue handling to common code
In-Reply-To: <20170608130836.31891-1-hch@lst.de>
References: <20170608130836.31891-1-hch@lst.de>
Message-ID: <ebdf570f-6a8c-4a8e-4932-831d091711f3@grimberg.me>


> +int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	if (!ctrl->admin_q || blk_queue_dying(ctrl->admin_q))
> +		return -ENODEV;

I don't think we need these. I know they exist in pci, but
it looks really odd that we're able to even get to this
point when the controller is not already in RESETTING/DELETING/DEAD
(which would not pass the ctrl state change anyhow).

And if it is, we need to fix that IMHO, we should always make
sure to rely on our ctrl state for making decisions.

> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		return -EBUSY;
> +	if (!queue_work(nvme_wq, &ctrl->reset_work))
> +		return -EBUSY;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
> +
> +static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
> +{
> +	int ret;
> +
> +	ret = nvme_reset_ctrl(ctrl);
> +	if (!ret)
> +		flush_work(&ctrl->reset_work);
> +	return ret;
> +}
> +
>   static int nvme_error_status(struct request *req)
>   {
>   	switch (nvme_req(req)->status & 0x7ff) {
> @@ -601,7 +623,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
>   	if (nvme_keep_alive(ctrl)) {
>   		/* allocation failure, reset the controller */
>   		dev_err(ctrl->device, "keep-alive failed\n");
> -		ctrl->ops->reset_ctrl(ctrl);
> +		nvme_reset_ctrl_sync(ctrl);

Looking at this, I actually think this should be the non-sync version.
My code :)

Both of these are not directly related to the patch itself so,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
