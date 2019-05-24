From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 May 2019 23:51:04 -0700
Subject: [PATCH 2/4] nvme-fc: track state change failures during reconnect
In-Reply-To: <20190520063624.50338-3-hare@suse.de>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-3-hare@suse.de>
Message-ID: <ddf3f233-263d-288a-aedd-8d1ee3989709@grimberg.me>


> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 0c9e036afd09..e5c81ba2b7a1 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2867,8 +2867,12 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>   	unsigned long recon_delay = ctrl->ctrl.opts->reconnect_delay * HZ;
>   	bool recon = true;
>   
> -	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING)
> +	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
> +		dev_info(ctrl->ctrl.device,
> +			 "NVME-FC{%d}: couldn't reconnect in state %s\n",
> +			 ctrl->cnum, nvme_ctrl_state_name(&ctrl->ctrl));

Is this always "couldn't"? Is this expected?

>   		return;
> +	}
>   
>   	if (portptr->port_state == FC_OBJSTATE_ONLINE)
>   		dev_info(ctrl->ctrl.device,
> @@ -2914,7 +2918,8 @@ __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
>   	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
>   		dev_err(ctrl->ctrl.device,
>   			"NVME-FC{%d}: error_recovery: Couldn't change state "
> -			"to CONNECTING\n", ctrl->cnum);
> +			"from %s to CONNECTING\n", ctrl->cnum,
> +			nvme_ctrl_state_name(&ctrl->ctrl));

Doesn't this present an unnecessary combination of a lower-case state
and all-caps CONNECTING?
