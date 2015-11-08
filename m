From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 8 Nov 2015 12:26:04 +0200
Subject: [PATCH 7/8] nvmet: add a generic NVMe target
In-Reply-To: <1446915643-21175-8-git-send-email-hch@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1446915643-21175-8-git-send-email-hch@lst.de>
Message-ID: <563F233C.5000603@dev.mellanox.co.il>


> +void nvmet_ns_free(struct nvmet_ns *ns)
> +{
> +	struct nvmet_subsys *subsys = ns->subsys;
> +
> +	mutex_lock(&subsys->lock);
> +	if (!list_empty(&ns->dev_link))
> +		list_del_init(&ns->dev_link);
> +	mutex_unlock(&subsys->lock);
> +
> +	nvmet_put_namespace(ns);
> +}
> +
> +struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
> +{
> +	struct nvmet_ns *ns;
> +
> +	ns = kzalloc(sizeof(*ns), GFP_KERNEL);
> +	if (!ns)
> +		return NULL;
> +

This lacks also:
INIT_LIST_HEAD(&ns->dev_link);

So the list_empty() check in ns_free won't be bogus...
It causes a NULL deref on configfs rmdir.

> +	kref_init(&ns->ref);
> +	ns->nsid = nsid;
> +	ns->subsys = subsys;
> +	return ns;
> +}
