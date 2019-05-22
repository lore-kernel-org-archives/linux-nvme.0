From: aeasi@marvell.com (Arun Easi)
Date: Wed, 22 May 2019 10:43:25 -0700
Subject: [PATCH 3/4] nvme-fc: fail reconnect if state change fails
In-Reply-To: <20190520063624.50338-4-hare@suse.de>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-4-hare@suse.de>
Message-ID: <alpine.LRH.2.21.9999.1905221035410.9636@mvluser05.qlc.com>

On Sun, 19 May 2019, 11:36pm, Hannes Reinecke wrote:

> If the final state change to LIVE in nvme_fc_create_association()
> fails the controller is not operational as no I/O is possible.
> So we should be returning an error here to reschedule reconnect.
> Additionally it should only be called while in CONNECTING state, so
> add a check for this, too.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/fc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index e5c81ba2b7a1..71b22139e78b 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2624,6 +2624,14 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>  
>  	++ctrl->ctrl.nr_reconnects;
>  
> +	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {

Question: There is a path in nvme_fc_resume_controller() that schedules 
connect_work when controller state is NVME_CTRL_NEW. I am not quite sure 
when this is exercised; but if it does, it conflicts with this 
expectation.

Otherwise changes look good.

Regards,
-Arun

> +		dev_info(ctrl->ctrl.device,
> +			 "NVME-FC{%d}: state %s cancelled new "
> +			 "association attempt\n",
> +			 ctrl->cnum, nvme_ctrl_state_name(&ctrl->ctrl));
> +		return -ENODEV;
> +	}
> +
>  	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
>  		return -ENODEV;
>  
> @@ -2726,6 +2734,14 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>  	}
>  
>  	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> +	if (!changed && ctrl->ctrl.state != NVME_CTRL_DELETING) {
> +		dev_err(ctrl->ctrl.device,
> +			"NVME-FC{%d}: error_recovery: Couldn't change "
> +			"state from %s to LIVE\n", ctrl->cnum,
> +			nvme_ctrl_state_name(&ctrl->ctrl));
> +		ret = -EAGAIN;
> +		goto out_destroy_queues;
> +	}
>  
>  	ctrl->ctrl.nr_reconnects = 0;
>  
> @@ -2734,6 +2750,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>  
>  	return 0;	/* Success */
>  
> +out_destroy_queues:
> +	nvme_fc_delete_hw_io_queues(ctrl);
> +	nvme_fc_free_io_queues(ctrl);
>  out_term_aen_ops:
>  	nvme_fc_term_aen_ops(ctrl);
>  out_disconnect_admin_queue:
> 
