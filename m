From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 Jan 2019 08:43:32 +0100
Subject: [PATCH] nvme-multipath: relax ANA state check
In-Reply-To: <20190125111236.5389-1-marting@netapp.com>
References: <20190125111236.5389-1-marting@netapp.com>
Message-ID: <20190128074332.GC3287@lst.de>

On Fri, Jan 25, 2019@04:42:36PM +0530, martinus.gpy@gmail.com wrote:
> From: Martin George <marting at netapp.com>
> 
> The current nvme multipath code prevents access to a namespace
> through a controller that has transitioned from ANA Optimized
> to Non-Optimized and vice versa.

Note: controllers do not have ANA states, ANA groups and thus
namespaces have states.

> As per the NVMe 1.3 TP4004
> spec, "The change from one asymmetric namespace access state
> to another asymmetric namespace access state is called a
> transition". The emphasis here is on the change itself,
> whatever the change may be. So a change from ANA Optimized to
> Non-Optimized and vice versa, are actually valid transition
> scenarios. In fact, if one were to exit and reenter the same
> state, that too is a change i.e. a change to the same state
> is also a valid transition scenario.
> 
> So remove the "old" state check during ANA state update, so
> that transition from ANA Optimized to Non-Optimized and vice
> versa, along with transition to the same state, are all
> permitted.

This description does not seem to match the patch:

>  static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>  		struct nvme_ns *ns)
>  {
> -	enum nvme_ana_state old;
> -
>  	mutex_lock(&ns->head->lock);
> -	old = ns->ana_state;
>  	ns->ana_grpid = le32_to_cpu(desc->grpid);
>  	ns->ana_state = desc->state;
>  	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
>  
> -	if (nvme_state_is_live(ns->ana_state) && !nvme_state_is_live(old))
> +	if (nvme_state_is_live(ns->ana_state))
>  		nvme_mpath_set_live(ns);

What the patch does is to always call nvme_mpath_set_live when
transitioning to a live state, where live is defined as optimized or
non-optimized, instead of limiting that call to transitions from
states that were not considered live.
