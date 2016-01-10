From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 10 Jan 2016 14:44:55 +0200
Subject: [PATCH RFC] nvme-core: Log the ctrl device instance name
In-Reply-To: <1452416444-22714-1-git-send-email-sagig@mellanox.com>
References: <1452416444-22714-1-git-send-email-sagig@mellanox.com>
Message-ID: <56925247.8080409@dev.mellanox.co.il>


>   	if (nvme_identify_ns(ns->ctrl, ns->ns_id, &id)) {
> -		dev_warn(ns->ctrl->dev, "%s: Identify failure nvme%dn%d\n",
> +		dev_warn(ns->ctrl->device, "%s: Identify failure nvme%dn%d\n",
>   				__func__, ns->ctrl->instance, ns->ns_id);

Oops,

That ought to be replaced with:
		dev_warn(disk_to_dev(ns->disk, "%s: Identify failure\n",
				__func__);
