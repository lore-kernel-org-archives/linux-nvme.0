From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Nov 2018 17:42:35 +0100
Subject: [PATCH 2/2] nvme-multipath: round-robin I/O policy
In-Reply-To: <20181115122927.40431-3-hare@suse.de>
References: <20181115122927.40431-1-hare@suse.de>
 <20181115122927.40431-3-hare@suse.de>
Message-ID: <20181120164235.GA3073@lst.de>

On Thu, Nov 15, 2018@01:29:27PM +0100, Hannes Reinecke wrote:
> Add a simple round-robin I/O policy for multipathing.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/multipath.c | 46 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h      |  1 +
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 1f97293380e2..fed3eea9da9a 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -177,14 +177,52 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
>  		ns->ana_state == NVME_ANA_OPTIMIZED;
>  }
>  
> +inline struct nvme_ns *__nvme_next_path(struct nvme_ns_head *head, int node,
> +					struct nvme_ns *old)

This seems to miss a static.  Also maybe put a rr in somewhere, e.g.:

static inline struct nvme_ns *
nvme_round_robin_path(struct nvme_ns_head *head, int node,
		struct nvme_ns *old)

> +	do {
> +		ns = list_next_or_null_rcu(&head->list, &old->siblings,
> +					   struct nvme_ns, siblings);
> +		if (!ns) {
> +			ns = list_first_or_null_rcu(&head->list, struct nvme_ns,
> +						    siblings);
> +			if (ns && ns == old)
> +				/*
> +				 * The list consists of just one entry.
> +				 * Sorry for the noise :-)
> +				 */
> +				return old;
> +			else if (!ns)

No need for a else after a return.

> +				break;
> +		}
> +		if (nvme_path_is_optimized(ns)) {
> +			found = ns;
> +			break;
> +		}

So you never consider non-optimized paths here?

>  inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>  {
>  	int node = numa_node_id();
>  	struct nvme_ns *ns;
>  
>  	ns = srcu_dereference(head->current_path[node], &head->srcu);
> +retry:
>  	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
>  		ns = __nvme_find_path(head, node);
> +	else if (head->subsys->iopolicy == NVME_IOPOLICY_RR) {
> +		ns = __nvme_next_path(head, node, ns);
> +		if (!ns)
> +			goto retry;
> +	}

Can you move the __nvme_find_path call for the first path into
your round robing helper so that we can make this whole thing
a little cleaner?  E.g.

	if (head->subsys->iopolicy == NVME_IOPOLICY_RR)
		return nvme_round_robin_path(head, node);
 	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
		ns = __nvme_find_path(head, node);
	return ns;

> @@ -497,6 +535,7 @@ static const char *nvme_iopolicy_names[] = {
>  	[NVME_IOPOLICY_UNKNOWN] = "unknown",
>  	[NVME_IOPOLICY_NONE] = "none",
>  	[NVME_IOPOLICY_NUMA] = "numa",
> +	[NVME_IOPOLICY_RR] = "round-robin",

I think you want to merge your I/O-policy attribute patch into this
one.  And we should probably kill all entries except for numa and
round-robin.

> +	struct nvme_subsystem *subsys =
> +		container_of(dev, struct nvme_subsystem, dev);
>  
>  	if (!strncmp(buf, "none", 4))
>  		iopolicy = NVME_IOPOLICY_NONE;
>  	else if (!strncmp(buf, "numa", 4))
>  		iopolicy = NVME_IOPOLICY_NUMA;
> +	else if (!strncmp(buf, "round-robin", 11))
> +		iopolicy = NVME_IOPOLICY_RR;

This could just loop over the above array for matches.

> +	mutex_lock(&subsys->lock);
> +	subsys->iopolicy = iopolicy;
> +	mutex_unlock(&subsys->lock);

Rather pointless to take a lock for updating a single value.
Just use WRITE_ONCE/READ_ONCE.
