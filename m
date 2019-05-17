From: james.smart@broadcom.com (James Smart)
Date: Fri, 17 May 2019 09:10:37 -0700
Subject: [PATCH 3/3] nvme-fc: fail reconnect if state change fails
In-Reply-To: <20190517064254.95561-4-hare@suse.de>
References: <20190517064254.95561-1-hare@suse.de>
 <20190517064254.95561-4-hare@suse.de>
Message-ID: <12b86c1a-9e83-f3b7-d72b-20eef528ab06@broadcom.com>

On 5/16/2019 11:42 PM, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index e5c81ba2b7a1..a8ef62512d9a 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2726,6 +2734,13 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	}
>   
>   	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> +	if (!changed && ctrl->ctrl.state != NVME_CTRL_DELETING) {
> +		dev_err(ctrl->ctrl.device,
> +			"NVME-FC{%d}: error_recovery: Couldn't change "
> +			"state from %s to LIVE\n", ctrl->cnum,
> +			nvme_ctrl_state_name(&ctrl->ctrl));
> +		return -EAGAIN;
> +	}
>   
>   	ctrl->ctrl.nr_reconnects = 0;
>   

Sorry, I should have spotted this last time.?? We shouldn't be exiting 
in the bad case - we should be setting ret=-EAGAIN then have a goto 
out_term_aen_ops so that whatever was built up for the association is 
torn down.

-- james
