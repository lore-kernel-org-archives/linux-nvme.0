From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 28 Sep 2018 15:31:09 -0700
Subject: [PATCH] nvme: take node locality into account when selecting a
 path
In-Reply-To: <20180927230557.29444-1-hch@lst.de>
References: <20180927230557.29444-1-hch@lst.de>
Message-ID: <8b06c066-3a9a-84e6-2439-159d12ed64a2@grimberg.me>


> +static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
> +{
> +	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
> +	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
>   
>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>   		if (ns->ctrl->state != NVME_CTRL_LIVE ||
>   		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>   			continue;
> +
> +		distance = node_distance(node, dev_to_node(ns->ctrl->dev));

Can we make this useful also for fabrics who have device affinity
knowledge? ctrl->dev is useless for fabrics...

Perhaps make it a ctrl->ops->devnode() or something?
