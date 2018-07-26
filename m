From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 26 Jul 2018 13:20:57 -0400
Subject: [PATCH 5/9] nvme: add ANA support
In-Reply-To: <20180726153505.4153-6-hch@lst.de>
References: <20180726153505.4153-1-hch@lst.de>
 <20180726153505.4153-6-hch@lst.de>
Message-ID: <20180726172056.GA15917@redhat.com>

On Thu, Jul 26 2018 at 11:35am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Add support for Asynchronous Namespace Access as specified in NVMe 1.3
> TP 4004.  With ANA each namespace attached to a controller belongs to an
> ANA group that describes the characteristics of accessing the namespaces
> through this controller.  In the optimized and non-optimized states
> namespaces can be accessed regularly, although in a multi-pathing
> environment we should always prefer to access a namespace through a
> controller where an optimized relationship exists.  Namespaces in
> Inaccessible, Permanent-Loss or Change state for a given controller
> should not be accessed.
> 
> The states are updated through reading the ANA log page, which is read
> once during controller initialization, whenever the ANA change notice
> AEN is received, or when one of the ANA specific status codes that
> signal a state change is received on a command.
> 
> The ANA state is kept in the nvme_ns structure, which makes the checks in
> the fast path very simple.  Updating the ANA state when reading the log
> page is also very simple, the only downside is that finding the initial
> ANA state when scanning for namespaces is a bit cumbersome.
> 
> The gendisk for a ns_head is only registered once a life path for it
> exists.  Without that the kernel would hang during partition scanning.
> 
> Includes fixes and improvements from Hannes Reinecke.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c      |  42 ++++-
>  drivers/nvme/host/multipath.c | 342 ++++++++++++++++++++++++++++++++--
>  drivers/nvme/host/nvme.h      |  51 ++++-
>  3 files changed, 408 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 456d37a02ea3..e62592c949ab 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1035,18 +1035,18 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>  EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>  
>  #define NVME_AEN_SUPPORTED \
> -	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT)
> +	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE)
>  
>  static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>  {
> -	u32 result;
> +	u32 supported = ctrl->oaes & NVME_AEN_SUPPORTED, result;
>  	int status;
>  
> -	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT,
> -			ctrl->oaes & NVME_AEN_SUPPORTED, NULL, 0, &result);
> +	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported, NULL,
> +			0, &result);
>  	if (status)
>  		dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
> -			 ctrl->oaes & NVME_AEN_SUPPORTED);
> +			 supported);
>  }
>  
>  static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
> @@ -2370,6 +2370,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	nvme_set_queue_limits(ctrl, ctrl->admin_q);
>  	ctrl->sgls = le32_to_cpu(id->sgls);
>  	ctrl->kas = le16_to_cpu(id->kas);
> +	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>  
>  	if (id->rtd3e) {
>  		/* us -> s */
> @@ -2429,8 +2430,12 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
>  	}
>  
> +	ret = nvme_mpath_init(ctrl, id);
>  	kfree(id);
>  
> +	if (ret < 0)
> +		return ret;
> +
>  	if (ctrl->apst_enabled && !prev_apst_enabled)
>  		dev_pm_qos_expose_latency_tolerance(ctrl->device);
>  	else if (!ctrl->apst_enabled && prev_apst_enabled)
> @@ -2649,6 +2654,10 @@ static struct attribute *nvme_ns_id_attrs[] = {
>  	&dev_attr_nguid.attr,
>  	&dev_attr_eui.attr,
>  	&dev_attr_nsid.attr,
> +#ifdef CONFIG_NVME_MULTIPATH
> +	&dev_attr_ana_grpid.attr,
> +	&dev_attr_ana_state.attr,
> +#endif
>  	NULL,
>  };
>  
> @@ -2671,6 +2680,14 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
>  		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
>  			return 0;
>  	}
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
> +		if (dev_to_disk(dev)->fops != &nvme_fops) /* per-path attr */
> +			return 0;
> +		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
> +			return 0;
> +	}
> +#endif
>  	return a->mode;
>  }
>  

I'm at a loss as to why ANA code in host core needs to be wrapped by
CONFIG_NVME_MULTIPATH (or why the mechanics of ANA support cannot be
decoupled from multipath.c).  I mean it may keep things clearer for this
particular implementation but it obviously prevents any more generic ANA
handling (decoupled from all the CONFIG_NVME_MULTIPATH code).  That is
likely very much by design.

Just seems unecessary but yet inkeeping with one NVMe multipath to rule
them all.  Unfortunate.  Especially in that I thought Hannes had a
vision for how to keep ANA more analogous to scsi_dh_alua -- meaning
capabilties are added to influence behavior of NVMe if the NVMe device
advertises support for those capabilities.

Making it all so tightly coupled to the CONFIG_NVME_MULTIPATH code is
obviously easier to reason through and may be appropriate for now (just
to get it all working).  I just see it as artificially limiting and
frankly wrong.

Mike
