From: hch@lst.de (Christoph Hellwig)
Date: Tue, 30 Aug 2016 09:06:14 +0200
Subject: [PATCH WIP/RFC v2 6/6] nvme-rdma: use ib_client API to detect
 device removal
In-Reply-To: <a78624bcccd2262cf54d8db4aa7da753bd6b499a.1472506505.git.swise@opengridcomputing.com>
References: <cover.1472506505.git.swise@opengridcomputing.com>
 <a78624bcccd2262cf54d8db4aa7da753bd6b499a.1472506505.git.swise@opengridcomputing.com>
Message-ID: <20160830070614.GA32645@lst.de>

> +static void nvme_rdma_add_one(struct ib_device *ib_device);
> +static void nvme_rdma_remove_one(struct ib_device *ib_device,
> +				void *client_data);

Can we avoid the forward declarations?

> +static void nvme_rdma_add_one(struct ib_device *ib_device)
> +{
> +	/* devices are added dynamically as targets use them */
> +}

Is the add callback mandatory in the core?  Would be nice if we could
fix that up in an incremental patch.

> +static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
> +{
> +	struct nvme_rdma_ctrl *ctrl, *tmp;
> +
> +	pr_info("Removing resources for device %s\n", ib_device->name);
> +
> +	mutex_lock(&nvme_rdma_ctrl_mutex);
> +	list_for_each_entry_safe(ctrl, tmp, &nvme_rdma_ctrl_list, list) {
> +		int delete_ctrl;
> +
> +		if (ctrl->device->dev != ib_device)
> +			continue;

Also not important for now, but we probably should move to a per-device
list here if we move forward with this approach.

> +		mutex_unlock(&nvme_rdma_ctrl_mutex);

After unlocking nvme_rdma_ctrl_mutex we will need to restart the
list walk, as others might have changed the list (e.g. for a different
device).  Maybe we should do the per-device list from the start to
simplify this loop.

> @@ -2052,6 +2060,7 @@ static void __exit nvme_rdma_cleanup_module(void)
>  		__nvme_rdma_del_ctrl(ctrl);
>  	mutex_unlock(&nvme_rdma_ctrl_mutex);
>  
> +	ib_unregister_client(&nvme_rdma_ib_client);

We shouldn't need the deletion loop above because now ib_unregister_client
takes care of that, right?
