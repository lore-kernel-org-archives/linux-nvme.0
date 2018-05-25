From: james.smart@broadcom.com (James Smart)
Date: Fri, 25 May 2018 08:53:36 -0700
Subject: [PATCH] nvme: re-enable clean shutdown
In-Reply-To: <20180525090524.58845-1-hare@suse.de>
References: <20180525090524.58845-1-hare@suse.de>
Message-ID: <78db23fc-6bf6-68b5-a298-6a44b0ece5ca@broadcom.com>



On 5/25/2018 2:05 AM, Hannes Reinecke wrote:
> Commit bb06ec31452f ("nvme: expand nvmf_check_if_ready checks")
> masked out all commands during shutdown, causing the nvme core
> to never send the shutdown command to the target.
> With this patch clean shutdown is re-enabled.
>
> Fixes: bb06ec31452f ("nvme: expand nvmf_check_if_ready checks")
> Cc: James Smart <james.smart at broadcom.com>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/fabrics.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 1c27f862dc45..13c5d3155c41 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -546,6 +546,17 @@ blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   
>   	switch (ctrl->state) {
>   	case NVME_CTRL_DELETING:
> +		if (!is_connected)
> +			goto reject_or_queue_io;
> +		/*
> +		 * We need to send shutdown commands to the
> +		 * target when deleting the controller.
> +		 */
> +		if (cmd->common.opcode == nvme_fabrics_command &&
> +		    (cmd->fabrics.fctype == nvme_fabrics_type_property_get ||
> +		     cmd->fabrics.fctype == nvme_fabrics_type_property_set))
> +			return BLK_STS_OK;
> +
>   		goto reject_io;
>   
>   	case NVME_CTRL_NEW:

yep. sounds good.

-- james

Reviewed-by:? James Smart? <james.smart at broadcom.com>
