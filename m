From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 13 May 2019 15:16:19 +0000
Subject: [PATCH 2/2] nvme: validate cntlid during controller initialisation
References: <20190513062510.756-1-hch@lst.de> <20190513062510.756-3-hch@lst.de>
Message-ID: <SN6PR04MB45270478B09DF4C9516B2280860F0@SN6PR04MB4527.namprd04.prod.outlook.com>

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.

On 05/12/2019 11:26 PM, Christoph Hellwig wrote:
> The CNTLID value is required to be unique, and we do rely on this
> for correct operation. So reject any controller for which a non-unique
> CNTLID has been detected.
>
> Based on a patch from Hannes Reinecke.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c | 41 +++++++++++++++++++++++-----------------
>   1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 70a2bc01e41e..09a1d5ca872f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2341,20 +2341,35 @@ static const struct attribute_group *nvme_subsys_attrs_groups[] = {
>   	NULL,
>   };
>
> -static int nvme_active_ctrls(struct nvme_subsystem *subsys)
> +static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
> +		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   {
> -	int count = 0;
> -	struct nvme_ctrl *ctrl;
> +	struct nvme_ctrl *tmp;
>
>   	lockdep_assert_held(&nvme_subsystems_lock);
>
> -	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> -		if (ctrl->state != NVME_CTRL_DELETING &&
> -		    ctrl->state != NVME_CTRL_DEAD)
> -			count++;
> +	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry) {
> +		if (ctrl->state == NVME_CTRL_DELETING ||
> +		    ctrl->state == NVME_CTRL_DEAD)
> +			continue;
> +
> +		if (tmp->cntlid == ctrl->cntlid) {
> +			dev_err(ctrl->device,
> +				"Duplicate cntlid %u with %s, rejecting\n",
> +				ctrl->cntlid, dev_name(tmp->device));
> +			return false;
> +		}
> +
> +		if ((id->cmic & (1 << 1)) ||
> +		    (ctrl->opts && ctrl->opts->discovery_nqn))
> +		    	continue;
> +
> +		dev_err(ctrl->device,
> +			"Subsystem does not support multiple controllers\n");
> +		return false;
>   	}
>
> -	return count;
> +	return true;
>   }
>
>   static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> @@ -2397,15 +2412,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   		__nvme_release_subsystem(subsys);
>   		subsys = found;
>
> -		/*
> -		 * Verify that the subsystem actually supports multiple
> -		 * controllers, else bail out.
> -		 */
> -		if (!(ctrl->opts && ctrl->opts->discovery_nqn) &&
> -		    nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
> -			dev_err(ctrl->device,
> -				"ignoring ctrl due to duplicate subnqn (%s).\n",
> -				subsys->subnqn);
> +		if (!nvme_validate_cntlid(subsys, ctrl, id)) {
>   			ret = -EINVAL;
>   			goto out_put_subsystem;
>   		}
>
