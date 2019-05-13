From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 13 May 2019 15:15:37 +0000
Subject: [PATCH 1/2] nvme: change locking for the per-subsystem controller
 list
References: <20190513062510.756-1-hch@lst.de> <20190513062510.756-2-hch@lst.de>
Message-ID: <SN6PR04MB4527D9CE64D51E7A1786DDB8860F0@SN6PR04MB4527.namprd04.prod.outlook.com>

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.

On 05/12/2019 11:26 PM, Christoph Hellwig wrote:
> Life becomes a lot simpler if we just use the global
> nvme_subsystems_lock to protect this list.  Given that it is only
> accessed during controller probing and removal that isn't a scalability
> problem either.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c | 32 ++++++++++++++------------------
>   1 file changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index eebaeadaa800..70a2bc01e41e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2346,13 +2346,13 @@ static int nvme_active_ctrls(struct nvme_subsystem *subsys)
>   	int count = 0;
>   	struct nvme_ctrl *ctrl;
>
> -	mutex_lock(&subsys->lock);
> +	lockdep_assert_held(&nvme_subsystems_lock);
> +
>   	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>   		if (ctrl->state != NVME_CTRL_DELETING &&
>   		    ctrl->state != NVME_CTRL_DEAD)
>   			count++;
>   	}
> -	mutex_unlock(&subsys->lock);
>
>   	return count;
>   }
> @@ -2394,6 +2394,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	mutex_lock(&nvme_subsystems_lock);
>   	found = __nvme_find_get_subsystem(subsys->subnqn);
>   	if (found) {
> +		__nvme_release_subsystem(subsys);
> +		subsys = found;
> +
>   		/*
>   		 * Verify that the subsystem actually supports multiple
>   		 * controllers, else bail out.
> @@ -2402,14 +2405,10 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   		    nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
>   			dev_err(ctrl->device,
>   				"ignoring ctrl due to duplicate subnqn (%s).\n",
> -				found->subnqn);
> -			nvme_put_subsystem(found);
> +				subsys->subnqn);
>   			ret = -EINVAL;
> -			goto out_unlock;
> +			goto out_put_subsystem;
>   		}
> -
> -		__nvme_release_subsystem(subsys);
> -		subsys = found;
>   	} else {
>   		ret = device_add(&subsys->dev);
>   		if (ret) {
> @@ -2421,23 +2420,20 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   		list_add_tail(&subsys->entry, &nvme_subsystems);
>   	}
>
> -	ctrl->subsys = subsys;
> -	mutex_unlock(&nvme_subsystems_lock);
> -
>   	if (sysfs_create_link(&subsys->dev.kobj, &ctrl->device->kobj,
>   			dev_name(ctrl->device))) {
>   		dev_err(ctrl->device,
>   			"failed to create sysfs link from subsystem.\n");
> -		/* the transport driver will eventually put the subsystem */
> -		return -EINVAL;
> +		goto out_put_subsystem;
>   	}
>
> -	mutex_lock(&subsys->lock);
> +	ctrl->subsys = subsys;
>   	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
> -	mutex_unlock(&subsys->lock);
> -
> +	mutex_unlock(&nvme_subsystems_lock);
>   	return 0;
>
> +out_put_subsystem:
> +	nvme_put_subsystem(subsys);
>   out_unlock:
>   	mutex_unlock(&nvme_subsystems_lock);
>   	put_device(&subsys->dev);
> @@ -3695,10 +3691,10 @@ static void nvme_free_ctrl(struct device *dev)
>   	__free_page(ctrl->discard_page);
>
>   	if (subsys) {
> -		mutex_lock(&subsys->lock);
> +		mutex_lock(&nvme_subsystems_lock);
>   		list_del(&ctrl->subsys_entry);
> -		mutex_unlock(&subsys->lock);
>   		sysfs_remove_link(&subsys->dev.kobj, dev_name(ctrl->device));
> +		mutex_unlock(&nvme_subsystems_lock);
>   	}
>
>   	ctrl->ops->free_ctrl(ctrl);
>
