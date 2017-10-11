From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 14:09:40 +0300
Subject: [PATCH v2] nvme_fc: retry initial controller connections 3 times
In-Reply-To: <20171009233922.7216-1-jsmart2021@gmail.com>
References: <20171009233922.7216-1-jsmart2021@gmail.com>
Message-ID: <d80601a9-bead-2b21-fdaf-fea01fbdbafe@grimberg.me>


> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 1075488a81d6..18e036c6833b 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2790,7 +2790,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   {
>   	struct nvme_fc_ctrl *ctrl;
>   	unsigned long flags;
> -	int ret, idx;
> +	int ret, idx, retry;
>   
>   	if (!(rport->remoteport.port_role &
>   	    (FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
> @@ -2882,9 +2882,37 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
>   	spin_unlock_irqrestore(&rport->lock, flags);
>   
> -	ret = nvme_fc_create_association(ctrl);
> +	/*
> +	 * It's possible that transactions used to create the association
> +	 * may fail. Examples: CreateAssociation LS or CreateIOConnection
> +	 * LS gets dropped/corrupted/fails; or a frame gets dropped or a
> +	 * command times out for one of the actions to init the controller
> +	 * (Connect, Get/Set_Property, Set_Features, etc). Many of these
> +	 * transport errors (frame drop, LS failure) inherently must kill
> +	 * the association. The transport is coded so that any command used
> +	 * to create the association (prior to a LIVE state transition
> +	 * while NEW or RECONNECTING) will fail if it completes in error or
> +	 * times out.
> +	 *
> +	 * As such: as the connect request was mostly likely due to a
> +	 * udev event that discovered the remote port, meaning there is
> +	 * not an admin or script there to restart if the connect
> +	 * request fails, retry the initial connection creation up to
> +	 * three times before giving up and declaring failure.
> +	 */
> +	for (retry = 0; retry < 3; retry++) {
> +		ret = nvme_fc_create_association(ctrl);
> +		if (!ret)
> +			break;
> +	}
> +
>   	if (ret) {
> +		/* couldn't schedule retry - fail out */
> +		dev_err(ctrl->ctrl.device,
> +			"NVME-FC{%d}: Connect retry failed\n", ctrl->cnum);
> +
>   		ctrl->ctrl.opts = NULL;
> +
>   		/* initiate nvme ctrl ref counting teardown */
>   		nvme_uninit_ctrl(&ctrl->ctrl);
>   		nvme_put_ctrl(&ctrl->ctrl);
> 

Its not directly related to this patch, but the error handling here
seems non trivial, why isn't this going to the normal out_* error
targets below in the function?
