From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Nov 2018 10:36:09 +0100
Subject: [PATCH 3/3] nvme-multipath: automatic NUMA path balancing
In-Reply-To: <20181102095641.28504-4-hare@suse.de>
References: <20181102095641.28504-1-hare@suse.de>
 <20181102095641.28504-4-hare@suse.de>
Message-ID: <20181108093609.GA4790@lst.de>

> +void nvme_mpath_distribute_paths(struct nvme_subsystem *subsys, int num_ctrls,
> +				 struct nvme_ctrl *ctrl, int numa_node)
> +{

This function needs a comment describing it, as it isn't exactly
obvious.

> +	int node;
> +	int found_node = NUMA_NO_NODE;
> +	int max = LOCAL_DISTANCE * num_ctrls;
> +
> +	for_each_node(node) {
> +		struct nvme_ctrl *c;
> +		int sum = 0;
> +
> +		list_for_each_entry(c, &subsys->ctrls, subsys_entry)
> +			sum += c->node_map[node];
> +		if (sum > max) {
> +			max = sum;
> +			found_node = node;
> +		}
> +	}

E.g. I really don't get the LOCAL_DISTANCE magic at all..

> +void nvme_mpath_balance_node(struct nvme_subsystem *subsys,
> +			     int num_ctrls, int numa_node)
> +{
> +	struct nvme_ctrl *found = NULL, *ctrl;
> +	int max = LOCAL_DISTANCE * num_ctrls, node;

Same here.

>  void nvme_mpath_balance_subsys(struct nvme_subsystem *subsys)
>  {
>  	struct nvme_ctrl *ctrl;
> +	int num_ctrls = 0;
>  	int node;
>  
>  	mutex_lock(&subsys->lock);
>  
>  	/*
> -	 * Reset set NUMA distance
> +	 * 1. Reset set NUMA distance
>  	 *    During creation the NUMA distance is only set
>  	 *    per controller, so after connecting the other
>  	 *    controllers the NUMA information on the existing
> @@ -280,7 +325,49 @@ void nvme_mpath_balance_subsys(struct nvme_subsystem *subsys)

Ok, this function and the comments make a whole lot more sense
with the new patch.  I think your intention might be much more clear
if you merge the two patches.

> +	/*
> +	 * 2. Distribute optimal paths:
> +	 *    Only one primary paths per node.
> +	 *    Additional primary paths are moved to unassigned nodes.
> +	 */

Btw, what do you mean with 'primary' path, we don't really use that
terminology anywhere else.
