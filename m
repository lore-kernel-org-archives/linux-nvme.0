From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 5 Oct 2018 11:10:59 -0700
Subject: [PATCH] nvme: Update node paths after adding new path
In-Reply-To: <20181005154937.24198-1-keith.busch@intel.com>
References: <20181005154937.24198-1-keith.busch@intel.com>
Message-ID: <1c5827c1-6f2b-f45e-5370-26b3a49a3d33@grimberg.me>


> The nvme namespace paths were being updated only when the current path
> was not set or nonoptimized. If a new path comes online that is a better
> path for its NUMA node, the multipath selector may continue using the
> previously set path on a potentially further node.
> 
> This patch re-runs the path assignment after successfully adding a new
> optimized path.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/multipath.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 52987052b7fc..fc3c5c2b3eca 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -321,6 +321,14 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>   		device_add_disk(&head->subsys->dev, head->disk,
>   				nvme_ns_id_attr_groups);
>   
> +	if (nvme_path_is_optimized(ns)) {
> +		int node, srcu_idx;
> +
> +		srcu_idx = srcu_read_lock(&head->srcu);
> +		for_each_node(node)
> +			__nvme_find_path(head, node);
> +		srcu_read_unlock(&head->srcu, srcu_idx);
> +	}

Any reason for interfering with all the numa nodes?

Why not simple call __nvme_find_path(head, ns->ctrl->node_id) ?
