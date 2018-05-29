From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 14:38:29 +0200
Subject: [PATCH 03/10] nvme: Only update capacity for optimized or
 non-optimized paths
In-Reply-To: <20180529101431.62271-4-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-4-hare@suse.de>
Message-ID: <20180529123829.GA7376@lst.de>

On Tue, May 29, 2018@12:14:24PM +0200, Hannes Reinecke wrote:
> As per ANA spec paths in 'inaccessible' or 'persistent-loss' state
> might return a capacity of '0'. So when an inaccessible path is
> detected last it might overwrite the actual capacity with '0',
> rendering the device unuseable.
> Hence we should only be updating the capacity if we are sure that
> we've read the correct one.

That clause in the ANA spec only affects the NUSE and NVMCAP fields,
which we never look at in the linux nvme driver.


> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/core.c      |  4 +++-
>  drivers/nvme/host/multipath.c |  9 ---------
>  drivers/nvme/host/nvme.h      | 13 +++++++++++++
>  3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1be424053f47..cc43bb685e63 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1457,7 +1457,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
>  		capacity = 0;
>  
> -	set_capacity(disk, capacity);
> +	if (nvme_ns_ana_state(ns) == NVME_ANA_OPTIMIZED ||
> +	    nvme_ns_ana_state(ns) == NVME_ANA_NONOPTIMIZED)
> +		set_capacity(disk, capacity);
>  	nvme_config_discard(ns);
>  	blk_mq_unfreeze_queue(disk->queue);
>  }
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 2fcaf50d84e2..a5f43d164b19 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -108,15 +108,6 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
>  	up_read(&ctrl->namespaces_rwsem);
>  }
>  
> -static inline enum nvme_ana_state nvme_ns_ana_state(struct nvme_ns *ns)
> -{
> -	if (!nvme_ctrl_has_ana(ns->ctrl))
> -		return NVME_ANA_OPTIMIZED;
> -	if (WARN_ON_ONCE(ns->anagrpid > ns->ctrl->anagrpmax))
> -		return 0;
> -	return READ_ONCE(ns->ctrl->ana_state[ns->anagrpid]);
> -}
> -
>  static const char *nvme_ana_state_names[] = {
>  	[0]				= "invalid state",
>  	[NVME_ANA_OPTIMIZED]		= "optimized",
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 53cb7f8a6267..8572f106d6ac 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -485,6 +485,15 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
>  		kblockd_schedule_work(&head->requeue_work);
>  }
>  
> +static inline enum nvme_ana_state nvme_ns_ana_state(struct nvme_ns *ns)
> +{
> +	if (!nvme_ctrl_has_ana(ns->ctrl))
> +		return NVME_ANA_OPTIMIZED;
> +	if (WARN_ON_ONCE(ns->anagrpid > ns->ctrl->anagrpmax))
> +		return 0;
> +	return READ_ONCE(ns->ctrl->ana_state[ns->anagrpid]);
> +}
> +
>  extern struct device_attribute dev_attr_ana_grpid;
>  extern struct device_attribute dev_attr_ana_state;
>  
> @@ -534,6 +543,10 @@ static inline int nvme_configure_ana(struct nvme_ctrl *ctrl)
>  static inline void nvme_deconfigure_ana(struct nvme_ctrl *ctrl)
>  {
>  }
> +static inline enum nvme_ana_state nvme_ns_ana_state(struct nvme_ns *ns)
> +{
> +	return NVME_ANA_OPTIMIZED;
> +}
>  #endif /* CONFIG_NVME_MULTIPATH */
>  
>  #ifdef CONFIG_NVM
> -- 
> 2.12.3
---end quoted text---
