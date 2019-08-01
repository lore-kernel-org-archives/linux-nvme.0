From: kbusch@kernel.org (Keith Busch)
Date: Thu, 1 Aug 2019 15:36:00 -0600
Subject: [PATCH 1/2] nvme: skip namespaces which are about to be removed
In-Reply-To: <20190801071644.66690-2-hare@suse.de>
References: <20190801071644.66690-1-hare@suse.de>
 <20190801071644.66690-2-hare@suse.de>
Message-ID: <20190801213600.GG15795@localhost.localdomain>

On Thu, Aug 01, 2019@12:16:43AM -0700, Hannes Reinecke wrote:
> nvme_ns_remove() will only remove the namespaces from the list at
> the very last step, so we might run into situations where we iterate
> over namespaces which are about to be deleted.
> To avoid crashes we should be skipping all namespaces with the
> NVME_NS_REMOVING flag set.

This all looks to be racing with whatever task is going to call
nvme_ns_remove().

Could we instead move these invalid namespaces off the ctrl->namespaces
list prior to calling nvme_ns_remove(), and while holding the write
lock? That way nothing can iterate the namespaces that we're deleting.
We already do that in some places, so that looks like it may be the safe
way to do this.

> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/core.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fcfff0a17a17..177fa4185775 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1303,9 +1303,12 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl)
>  	struct nvme_ns *ns;
>  
>  	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		if (test_bit(NVME_NS_REMOVING, &ns->flags))
> +			continue;
>  		if (ns->disk && nvme_revalidate_disk(ns->disk))
>  			nvme_set_queue_dying(ns);
> +	}
>  	up_read(&ctrl->namespaces_rwsem);
>  
>  	nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
> @@ -1698,6 +1701,10 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  {
>  	struct nvme_ns *ns = disk->private_data;
>  
> +	/* if ns is removing we cannot mangle with the request queue */
> +	if (test_bit(NVME_NS_REMOVING, &ns->flags))
> +		return;
> +
>  	/*
>  	 * If identify namespace failed, use default 512 byte block size so
>  	 * block layer can use before failing read/write for 0 capacity.
> @@ -2776,6 +2783,10 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	}
> +	if (test_bit(NVME_NS_REMOVING, &ns->flags)) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
>  
>  	dev_warn(ctrl->device,
>  		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
> @@ -3255,6 +3266,10 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  		if (ns->head->ns_id == nsid) {
>  			if (!kref_get_unless_zero(&ns->kref))
>  				continue;
> +			if (test_bit(NVME_NS_REMOVING, &ns->flags)) {
> +				nvme_put_ns(ns);
> +				continue;
> +			}
>  			ret = ns;
>  			break;
>  		}
> @@ -3445,6 +3460,8 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>  
>  	down_write(&ctrl->namespaces_rwsem);
>  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> +		if (test_bit(NVME_NS_REMOVING, &ns->flags))
> +			continue;
>  		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
>  			list_move_tail(&ns->list, &rm_list);
>  	}
> -- 
> 2.16.4
> 
