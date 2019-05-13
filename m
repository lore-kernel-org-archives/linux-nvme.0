From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Mon, 13 May 2019 12:25:19 -0600
Subject: [PATCH 2/2] nvme: validate cntlid during controller initialisation
In-Reply-To: <20190513062510.756-3-hch@lst.de>
References: <20190513062510.756-1-hch@lst.de> <20190513062510.756-3-hch@lst.de>
Message-ID: <e90ee6c7-8742-6f21-26c7-e0f578b419be@intel.com>



On 5/13/2019 12:25 AM, Christoph Hellwig wrote:
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

Replace whitespace with tab

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
