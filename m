From: edmund.nadolski@intel.com (Nadolski, Edmund)
Date: Thu, 1 Aug 2019 12:15:01 -0600
Subject: [PATCH 2/2] nvme: do not remove namespaces during reset
In-Reply-To: <20190801071644.66690-3-hare@suse.de>
References: <20190801071644.66690-1-hare@suse.de>
 <20190801071644.66690-3-hare@suse.de>
Message-ID: <c9d68268-62f4-80df-f926-c04a2ce4a81c@intel.com>

On 8/1/2019 1:16 AM, Hannes Reinecke wrote:
> Whenever the controller is resetting or connecting we cannot make
> any decisions about the attached namespaces, and consequently we
> shouldn't remove them. So skip namespace removal during reset;
> a scan will be triggered anyway after reconnecting which will
> clean up any stale namespaces.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/core.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)

LGTM.

Ed

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 177fa4185775..b24cf21f34d0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3410,7 +3410,7 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	return ret;
>   }
>   
> -static void nvme_ns_remove(struct nvme_ns *ns)
> +static void __nvme_ns_remove(struct nvme_ns *ns)
>   {
>   	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>   		return;
> @@ -3439,6 +3439,21 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	nvme_put_ns(ns);
>   }
>   
> +static void nvme_ns_remove(struct nvme_ns *ns)
> +{
> +	/*
> +	 * We cannot make any assumptions about namespaces during
> +	 * reset; in particular we shouldn't attempt to remove them
> +	 * as I/O might still be queued to them.
> +	 * So ignore this call during reset and rely on the
> +	 * rescan after reset to clean up things again.
> +	 */
> +	if (ns->ctrl->state == NVME_CTRL_RESETTING ||
> +	    ns->ctrl->state == NVME_CTRL_CONNECTING)
> +		return;
> +	__nvme_ns_remove(ns);
> +}
> +
>   static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   {
>   	struct nvme_ns *ns;
> @@ -3458,6 +3473,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   	struct nvme_ns *ns, *next;
>   	LIST_HEAD(rm_list);
>   
> +	if (ctrl->state == NVME_CTRL_RESETTING ||
> +	    ctrl->state == NVME_CTRL_CONNECTING)
> +		return;
> +
>   	down_write(&ctrl->namespaces_rwsem);
>   	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
>   		if (test_bit(NVME_NS_REMOVING, &ns->flags))
> @@ -3468,7 +3487,7 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   	up_write(&ctrl->namespaces_rwsem);
>   
>   	list_for_each_entry_safe(ns, next, &rm_list, list)
> -		nvme_ns_remove(ns);
> +		__nvme_ns_remove(ns);
>   
>   }
>   
> @@ -3618,7 +3637,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   	up_write(&ctrl->namespaces_rwsem);
>   
>   	list_for_each_entry_safe(ns, next, &ns_list, list)
> -		nvme_ns_remove(ns);
> +		__nvme_ns_remove(ns);
>   }
>   EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>   
> 
