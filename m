From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 29 May 2019 22:30:35 +0000
Subject: [PATCH v2] nvme-fc: Add message when creating new association
References: <20190529222526.3672-1-jsmart2021@gmail.com>
Message-ID: <DM6PR04MB5754C57EABBC657A2096E0DF861F0@DM6PR04MB5754.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 05/29/2019 03:25 PM, James Smart wrote:
> When looking at console messages to troubleshoot, there are one
> maybe two messages before creation of the controller is complete.
> However, a lot of io takes place to reach that point. It's unclear
> when things have started.
>
> Add a message when the controller is attempting to create a new
> association. Thus we know what controller, between what host and
> remote port, and what NQN is being put into place for any
> subsequent success or failure messages.
>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
>
> --
> v2:
>   Moved message to create association so displayed at initial
>    creation as well as at each reconnect
>   Changed message to additionally print host port wwpn and target port
>    wwpn.
> ---
>   drivers/nvme/host/fc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index c17c887f2148..bd1be8aa2d65 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2607,6 +2607,12 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	if (nvme_fc_ctlr_active_on_rport(ctrl))
>   		return -ENOTUNIQ;
>
> +	dev_info(ctrl->ctrl.device,
> +		"NVME-FC{%d}: create association : host wwpn 0x%016llx "
> +		" rport wwpn 0x%016llx: NQN \"%s\"\n",
> +		ctrl->cnum, ctrl->lport->localport.port_name,
> +		ctrl->rport->remoteport.port_name, ctrl->ctrl.opts->subsysnqn);
> +
>   	/*
>   	 * Create the admin queue
>   	 */
>
