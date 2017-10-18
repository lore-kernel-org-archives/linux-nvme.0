From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Oct 2017 16:39:13 -0600
Subject: [PATCH 13/17] nvme: track subsystems
In-Reply-To: <20171018165258.23212-14-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-14-hch@lst.de>
Message-ID: <20171018223913.GA1846@localhost.localdomain>

On Wed, Oct 18, 2017@06:52:54PM +0200, Christoph Hellwig wrote:
> +
> +static void nvme_put_subsystem(struct nvme_subsystem *subsys)
> +{
> +	put_device(&subsys->dev);
> +}

<snip>

> +static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> +{
> +	struct nvme_subsystem *subsys, *found;
> +	int ret;
> +
> +	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
> +	if (!subsys)
> +		return -ENOMEM;
> +	INIT_LIST_HEAD(&subsys->ctrls);
> +	nvme_init_subnqn(subsys, ctrl, id);
> +	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
> +	memcpy(subsys->model, id->mn, sizeof(subsys->model));
> +	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
> +	subsys->vendor_id = le16_to_cpu(id->vid);
> +	mutex_init(&subsys->lock);
> +
> +	subsys->dev.class = nvme_subsys_class;
> +	subsys->dev.release = nvme_free_subsystem;
> +	dev_set_name(&subsys->dev, subsys->subnqn);
> +	device_initialize(&subsys->dev);
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	found = __nvme_find_get_subsystem(subsys->subnqn);
> +	if (found) {
> +		/*
> +		 * Verify that the subsystem actually supports multiple
> +		 * controllers, else bail out.
> +		 */
> +		if (!(id->cmic & (1 << 1))) {
> +			dev_err(ctrl->device,
> +				"ignoring ctrl due to duplicate subnqn (%s).\n",
> +				found->subnqn);
> +			nvme_put_subsystem(found);
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		kfree(subsys);
> +		subsys = found;
> +	} else {
> +		ret = device_add(&subsys->dev);
> +		if (ret) {
> +			dev_err(ctrl->device,
> +				"failed to register subsystem device.\n");
> +			goto out_unlock;
> +		}
> +		list_add_tail(&subsys->entry, &nvme_subsystems);
> +	}

I'm having some trouble with this one. The device_initialize() initializes
the kobj's reference counter, and then the device_add() takes another
reference on it.

The teardown, though, only calls put_device(). Where's the call to
device_del() supposed to go that ultimately drops the last reference
to call the .release 'nvme_free_subsystem'?
