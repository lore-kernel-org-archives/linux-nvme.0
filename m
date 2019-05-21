From: james.smart@broadcom.com (James Smart)
Date: Tue, 21 May 2019 09:25:00 -0700
Subject: [PATCH 4/4] nvme-fc: align nvme_fc_delete_association() with exit
 path
In-Reply-To: <20190520063624.50338-5-hare@suse.de>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-5-hare@suse.de>
Message-ID: <20485830-ae6a-eae1-32f3-940ca2cc1bf3@broadcom.com>



On 5/19/2019 11:36 PM, Hannes Reinecke wrote:
> nvme_fc_delete_association() should align with the exit path in
> nvme_fc_create_association() to ensure we are able to handle the
> failure case properly.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/fc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 71b22139e78b..ed9f4affbe10 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2836,6 +2836,11 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   	ctrl->flags &= ~FCCTRL_TERMIO;
>   	spin_unlock_irq(&ctrl->lock);
>   
> +	if (ctrl->ctrl.tagset) {
> +		nvme_fc_delete_hw_io_queues(ctrl);
> +		nvme_fc_free_io_queues(ctrl);
> +	}
> +
>   	nvme_fc_term_aen_ops(ctrl);
>   
>   	/*
> @@ -2847,11 +2852,6 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   	if (ctrl->association_id)
>   		nvme_fc_xmt_disconnect_assoc(ctrl);
>   
> -	if (ctrl->ctrl.tagset) {
> -		nvme_fc_delete_hw_io_queues(ctrl);
> -		nvme_fc_free_io_queues(ctrl);
> -	}
> -
>   	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
>   	nvme_fc_free_queue(&ctrl->queues[0]);
>   

no.? This is removing the underlying queues while blk-mq is still trying 
to submit to them - causing yet a different set of issues as the driver 
will have released contexts but the calldowns are still happening. Yet 
another different set of issues would likely appear.?? no need for this 
reorg.

-- james
