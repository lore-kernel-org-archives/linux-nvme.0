From: james.smart@broadcom.com (James Smart)
Date: Thu, 16 May 2019 09:25:02 -0700
Subject: [PATCH 3/3] nvme-fc: fail reconnect if state change fails
In-Reply-To: <20190516083740.95894-4-hare@suse.de>
References: <20190516083740.95894-1-hare@suse.de>
 <20190516083740.95894-4-hare@suse.de>
Message-ID: <9f09edd0-bf71-61ed-7bcb-3c9e87d454a5@broadcom.com>



On 5/16/2019 1:37 AM, Hannes Reinecke wrote:
> If the final state change to LIVE in nvme_fc_create_association()
> fails the controller is not operational as no I/O is possible.
> So we should be returning an error here to reschedule reconnect.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/fc.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index e5c81ba2b7a1..9f9300cbdb62 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2620,7 +2620,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   {
>   	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
>   	int ret;
> -	bool changed;
>   
>   	++ctrl->ctrl.nr_reconnects;
>   
> @@ -2725,12 +2724,19 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   			goto out_term_aen_ops;
>   	}
>   
> -	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> +	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE)) {
> +		if (ctrl->ctrl.state != NVME_CTRL_DELETING) {
is this easier to arrange as:
 ??? if (nvme_change_ctrl_state(...) &&
 ???????? ctrl->ctrl.state != NVME_CTRL_DELETING) {

> +			dev_err(ctrl->ctrl.device,
> +				"NVME-FC{%d}: error_recovery: Couldn't change "
> +				"state from %s to LIVE\n", ctrl->cnum,
> +				nvme_ctrl_state_name(&ctrl->ctrl));
> +			return -EAGAIN;
> +		}
> +	}
>   
>   	ctrl->ctrl.nr_reconnects = 0;
>   
> -	if (changed)
> -		nvme_start_ctrl(&ctrl->ctrl);
> +	nvme_start_ctrl(&ctrl->ctrl);

I don't think you want to eliminate this check - you don't want to call 
nvme_start_ctrl() if state did transition to DELETING. You want to 
continue out to release the create thread, but the delete work will be 
coming along shortly.

-- james
