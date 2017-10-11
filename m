From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 14:57:31 +0300
Subject: [PATCH 5/9] nvme: track subsystems
In-Reply-To: <20170925134031.10548-6-hch@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-6-hch@lst.de>
Message-ID: <1535c6f9-8ddf-ab30-2bbd-5d9ce626b913@grimberg.me>

> @@ -2230,7 +2315,7 @@ static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
>   {
>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>   
> -	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subnqn);
> +	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subsys->subnqn);
>   }
>   static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
>   
> @@ -2770,12 +2855,22 @@ EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
>   static void nvme_free_ctrl(struct kref *kref)
>   {
>   	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
> +	struct nvme_subsystem *subsys = ctrl->subsys;
>   
>   	put_device(ctrl->device);
>   	nvme_release_instance(ctrl);
>   	ida_destroy(&ctrl->ns_ida);
>   
> +	if (subsys) {
> +		mutex_lock(&subsys->lock);
> +		list_del(&ctrl->subsys_entry);
> +		mutex_unlock(&subsys->lock);
> +	}
> +

When can this happen? can a controller not have a subsys?
