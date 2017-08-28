From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Mon, 28 Aug 2017 20:41:23 +0800
Subject: [PATCH 07/10] nvme: track shared namespaces
In-Reply-To: <20170823175815.3646-8-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-8-hch@lst.de>
Message-ID: <ec2a91f0-5825-9cfc-50ca-afea27fd8ef3@huawei.com>



On 2017/8/24 1:58, Christoph Hellwig wrote:
> +static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
> +		struct nvme_id_ns *id)
> +{
> +	struct nvme_ctrl *ctrl = ns->ctrl;
> +	bool is_shared = id->nmic & (1 << 0);
> +	struct nvme_ns_head *head = NULL;
> +	int ret = 0;
> +
> +	mutex_lock(&ctrl->subsys->lock);
> +	if (is_shared)
> +		head = __nvme_find_ns_head(ctrl->subsys, nsid);

If a namespace can be accessed by another subsystem,  the above line
will ignore such namespace.

Or does the NVMe/NVMf specification constrain that any namespace
can only be accessed by a subsystem?

More comments after testing will be sent later.

Thanks
Guan Junxiong
