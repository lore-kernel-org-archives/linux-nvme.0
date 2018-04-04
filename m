From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 4 Apr 2018 14:52:15 +0300
Subject: [RFC PATCH 1/8] nvme-core: add new interfaces
In-Reply-To: <20180330065747.20962-2-chaitanya.kulkarni@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-2-chaitanya.kulkarni@wdc.com>
Message-ID: <8dcebc55-0bbb-299f-b715-cdc43faddfce@grimberg.me>

> +int nvme_get_ctrl_by_name(char *ctrl_name, struct nvme_ctrl **ctrl)
> +{
> +	int ret = -ENODEV;
> +	char str[256] = "/dev/";
> +	struct nvme_ctrl *ictrl = NULL;
> +	struct nvme_subsystem *isubsys = NULL;
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(isubsys, &nvme_subsystems, entry) {
> +		if (!nvme_get_subsystem(isubsys)) {
> +			pr_info("failed to get the subsystem for ctrl %s\n",
> +					ctrl_name);
> +			goto out;
> +		}
> +		mutex_unlock(&nvme_subsystems_lock);
> +
> +		list_for_each_entry(ictrl, &isubsys->ctrls, subsys_entry) {
> +			spin_lock(&ictrl->lock);
> +			nvme_get_ctrl(ictrl);
> +			strcat(str, kobject_name(&ictrl->device->kobj));
> +			if (strncmp(str, ctrl_name, strlen(ctrl_name)) == 0) {
> +				*ctrl = ictrl;
> +				if (try_module_get(ictrl->ops->module)) {
> +					spin_unlock(&ictrl->lock);
> +					mutex_lock(&nvme_subsystems_lock);
> +					ret = 0;
> +					goto out;
> +				}
> +			}
> +			nvme_put_ctrl(ictrl);
> +			strcpy(str, "/dev/");
> +			spin_unlock(&ictrl->lock);
> +		}
> +		mutex_lock(&nvme_subsystems_lock);
> +		nvme_put_subsystem(isubsys);
> +	}
> +out:
> +	mutex_unlock(&nvme_subsystems_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_get_ctrl_by_name);
> +
> +void nvme_put_ctrl_by_name(struct nvme_ctrl *ctrl)
> +{
> +	nvme_put_ctrl(ctrl);
> +	module_put(ctrl->ops->module);
> +	nvme_put_subsystem(ctrl->subsys);
> +}
> +EXPORT_SYMBOL_GPL(nvme_put_ctrl_by_name);
> +

What happens when the nvme device unplugs from the system? We have a
dangling reference to the controller.. Then when/if the device returns
it will occupy another controller name (instance id is occupied).

Do we know (or want to know) how to handle such a case?
