From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 9 Nov 2017 13:33:16 +0200
Subject: [PATCH 1/5] nvme: track subsystems
In-Reply-To: <20171102183034.9320-2-hch@lst.de>
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-2-hch@lst.de>
Message-ID: <fbacd62b-4228-60cb-a382-9c88daadb336@grimberg.me>


> +static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> +{
> +	struct nvme_subsystem *subsys, *found;
> +	int ret;
> +
> +	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
> +	if (!subsys)
> +		return -ENOMEM;
> +	ret = ida_simple_get(&nvme_subsystems_ida, 0, 0, GFP_KERNEL);
> +	if (ret < 0) {
> +		kfree(subsys);
> +		return ret;
> +	}
> +	subsys->instance = ret;
> +	mutex_init(&subsys->lock);
> +	kref_init(&subsys->ref);
> +	INIT_LIST_HEAD(&subsys->ctrls);
> +	nvme_init_subnqn(subsys, ctrl, id);
> +	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
> +	memcpy(subsys->model, id->mn, sizeof(subsys->model));
> +	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
> +	subsys->vendor_id = le16_to_cpu(id->vid);
> +	subsys->cmic = id->cmic;
> +
> +	subsys->dev.class = nvme_subsys_class;
> +	subsys->dev.release = nvme_release_subsystem;
> +	dev_set_name(&subsys->dev, "nvme-subsys%d", subsys->instance);
> +	device_initialize(&subsys->dev);
> +

Any reason to do all this before we know if we found an existing 
subsystem? Also can the enumeration become with "holes" because you
acquire a subsystem ida temporarily and free it (and another subsystem
just came in)? Not a big issue though...
