From: hare@suse.de (Hannes Reinecke)
Date: Fri, 25 Jan 2019 13:57:33 +0100
Subject: [PATCH] nvme-multipath: relax ANA state check
In-Reply-To: <20190125111236.5389-1-marting@netapp.com>
References: <20190125111236.5389-1-marting@netapp.com>
Message-ID: <d9004592-a51b-cb32-ee4b-1aa9dc60e7da@suse.de>

On 1/25/19 12:12 PM, martinus.gpy@gmail.com wrote:
> From: Martin George <marting at netapp.com>
> 
> The current nvme multipath code prevents access to a namespace
> through a controller that has transitioned from ANA Optimized
> to Non-Optimized and vice versa. As per the NVMe 1.3 TP4004
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
> 
> Signed-off-by: Martin George <marting at netapp.com>
> Signed-off-by: Gargi Srinivas <sring at netapp.com>
> ---
>   drivers/nvme/host/multipath.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index b9fff3b8ed1b..23da7beadd62 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -366,15 +366,12 @@ static inline bool nvme_state_is_live(enum nvme_ana_state state)
>   static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>   		struct nvme_ns *ns)
>   {
> -	enum nvme_ana_state old;
> -
>   	mutex_lock(&ns->head->lock);
> -	old = ns->ana_state;
>   	ns->ana_grpid = le32_to_cpu(desc->grpid);
>   	ns->ana_state = desc->state;
>   	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
>   
> -	if (nvme_state_is_live(ns->ana_state) && !nvme_state_is_live(old))
> +	if (nvme_state_is_live(ns->ana_state))
>   		nvme_mpath_set_live(ns);
>   	mutex_unlock(&ns->head->lock);
>   }
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
