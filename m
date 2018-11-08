From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Nov 2018 10:32:24 +0100
Subject: [PATCH 2/3] nvme-multipath: Select paths based on NUMA locality
In-Reply-To: <20181102095641.28504-3-hare@suse.de>
References: <20181102095641.28504-1-hare@suse.de>
 <20181102095641.28504-3-hare@suse.de>
Message-ID: <20181108093224.GA4624@lst.de>

On Fri, Nov 02, 2018@10:56:40AM +0100, Hannes Reinecke wrote:
> This patch creates a per-controller map to hold the NUMA locality
> information. With that we can route I/O to the controller which is
> 'nearest' to the issuing CPU and decrease the latency there.

Well, that isn't really true.  The only think it does is that it
caches the result of 'node_distance(node, ns->ctrl->numa_node)'
for each [node, ctrl] tuple, and adds a sysfs file to export that.

Please update the description.  This also mean on its own the
patch isn't all that useful.

> +void nvme_set_ctrl_node(struct nvme_ctrl *ctrl, int numa_node)
> +{
> +	ctrl->numa_node = numa_node;
> +	if (numa_node == NUMA_NO_NODE)
> +		return;

I don't think adding special cases for this degenerate case is a good
idea.  Or is there a really good reason for keeping the !ctrl->node_map
case around?

> +	ctrl->node_map = kzalloc(num_possible_nodes() * sizeof(int),
> +				 GFP_KERNEL);

This should use kcalloc, and needs to check the return value.

> -		distance = node_distance(node, ns->ctrl->numa_node);
> +		distance = ns->ctrl->node_map ?
> +			ns->ctrl->node_map[node] : INT_MAX;

If we have to keep the special case please make this a proper if/else.

> +void nvme_mpath_balance_subsys(struct nvme_subsystem *subsys)

This name seems a little odd.  Why not
nvme_mpath_calculate_node_distances or something similar that
describes what it actually does?

> +{
> +	struct nvme_ctrl *ctrl;
> +	int node;
> +
> +	mutex_lock(&subsys->lock);
> +
> +	/*
> +	 * Reset set NUMA distance
> +	 *    During creation the NUMA distance is only set
> +	 *    per controller, so after connecting the other
> +	 *    controllers the NUMA information on the existing
> +	 *    ones is incorrect.
> +	 */

Please keep the comment above the function.

> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		for_each_node(node) {
> +			if (!ctrl->node_map)
> +				continue;

If we want to keep the special case the !ctrl->node_map should be moved
outside the inner loop.
