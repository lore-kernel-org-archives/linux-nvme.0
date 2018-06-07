From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Jun 2018 15:49:20 +0300
Subject: [PATCH 05/10] nvme: add ANA support
In-Reply-To: <20180606143311.23076-6-hch@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
 <20180606143311.23076-6-hch@lst.de>
Message-ID: <56eca832-5b3c-9ba8-c953-924f3fb7609f@grimberg.me>



On 06/06/2018 05:33 PM, Christoph Hellwig wrote:
> Add support for Asynchronous Namespace Access as specified in NVMe 1.3
> TP 4004.  With ANA each namespace attached to a controller belongs to
> an ANA group that describes the characteristics of accessing the
> namespaces through this controller.  In the optimized and non-optimized
> states namespaces can be accessed regularly, although in a multi-pathing
> environment we should always prefer to access a namespace through a
> controller where an optimized relationship exists.  Namespaces in
> Inaccessible, Permanent-Loss or Change state for a given controller
> should not be accessed.
> 
> We keep a simple per-controller array of ANA states which is indexed
> by the ANA group ID specified in the namespace.  The states are updated
> through reading the ANA log page, which is read once during controller
> initialization, and whenever the ANA change notice AEN is received, or
> when one of the ANA specific status codes that signal a state change
> is received on a command.
> 
> There currently isn't any support for the ANA transition timeout
> yet.
> 
> Includes fixes and improvements from Hannes Reinecke.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c      |  30 +++++-
>   drivers/nvme/host/multipath.c | 211 ++++++++++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h      |  28 ++++++
>   3 files changed, 262 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2fb284d0f497..67bd73a98a1b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1041,7 +1041,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>   EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>   
>   #define NVME_AEN_SUPPORTED \
> -	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT)
> +	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE)
>   
>   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>   {
> @@ -1472,6 +1472,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>   	ns->lba_shift = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
>   	if (ns->lba_shift == 0)
>   		ns->lba_shift = 9;
> +	ns->anagrpid = le32_to_cpu(id->anagrpid);
>   	ns->noiob = le16_to_cpu(id->noiob);
>   	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
>   	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
> @@ -2375,6 +2376,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>   	nvme_set_queue_limits(ctrl, ctrl->admin_q);
>   	ctrl->sgls = le32_to_cpu(id->sgls);
>   	ctrl->kas = le16_to_cpu(id->kas);
> +	ctrl->max_namespaces = le32_to_cpu(id->mnan);
> +	ctrl->anacap = id->anacap;
> +	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
> +	ctrl->anagrpmax = le32_to_cpu(id->anagrpmax);
>   
>   	if (id->rtd3e) {
>   		/* us -> s */
> @@ -2453,6 +2458,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>   	if (ret < 0)
>   		return ret;
>   
> +	ret = nvme_configure_ana(ctrl);
> +	if (ret < 0)
> +		return ret;
> +
>   	ctrl->identified = true;
>   
>   	return 0;
> @@ -2654,6 +2663,10 @@ static struct attribute *nvme_ns_id_attrs[] = {
>   	&dev_attr_nguid.attr,
>   	&dev_attr_eui.attr,
>   	&dev_attr_nsid.attr,
> +#ifdef CONFIG_NVME_MULTIPATH
> +	&dev_attr_ana_grpid.attr,
> +	&dev_attr_ana_state.attr,
> +#endif
>   	NULL,
>   };
>   
> @@ -2676,6 +2689,14 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
>   		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
>   			return 0;
>   	}
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
> +		if (dev_to_disk(dev)->fops != &nvme_fops) /* per-path attr */
> +			return 0;
> +		if (!nvme_get_ns_from_dev(dev)->anagrpid)
> +			return 0;
> +	}
> +#endif
>   	return a->mode;
>   }
>   
> @@ -3369,6 +3390,11 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>   	case NVME_AER_NOTICE_FW_ACT_STARTING:
>   		queue_work(nvme_wq, &ctrl->fw_act_work);
>   		break;
> +	case NVME_AER_NOTICE_ANA:
> +		if (WARN_ON_ONCE(!ctrl->ana_log_buf))
> +			break;
> +		queue_work(nvme_wq, &ctrl->ana_work);
> +		break;
>   	default:
>   		dev_warn(ctrl->device, "async event result %08x\n", result);
>   	}
> @@ -3404,6 +3430,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   	nvme_stop_keep_alive(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	flush_work(&ctrl->scan_work);
> +	cancel_work_sync(&ctrl->ana_work);
>   	cancel_work_sync(&ctrl->fw_act_work);
>   	if (ctrl->ops->stop_ctrl)
>   		ctrl->ops->stop_ctrl(ctrl);
> @@ -3438,6 +3465,7 @@ static void nvme_free_ctrl(struct device *dev)
>   
>   	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
>   	kfree(ctrl->effects);
> +	nvme_deconfigure_ana(ctrl);
>   
>   	if (subsys) {
>   		mutex_lock(&subsys->lock);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 7996b98befb1..2ab55ca15cec 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1,5 +1,5 @@
>   /*
> - * Copyright (c) 2017 Christoph Hellwig.
> + * Copyright (c) 2017-2018 Christoph Hellwig.
>    *
>    * This program is free software; you can redistribute it and/or modify it
>    * under the terms and conditions of the GNU General Public License,
> @@ -41,6 +41,11 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>   	}
>   }
>   
> +static void nvme_update_ana_state(struct nvme_ns *ns, enum nvme_ana_state state)
> +{
> +	WRITE_ONCE(ns->ctrl->ana_state[ns->anagrpid], state);
> +}
> +
>   void nvme_failover_req(struct request *req)
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
> @@ -51,7 +56,31 @@ void nvme_failover_req(struct request *req)
>   	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>   	blk_mq_end_request(req, 0);
>   
> -	nvme_reset_ctrl(ns->ctrl);
> +	/*
> +	 * Reset the controller for any non-ANA error as we don't know what
> +	 * caused the error:
> +	 */
> +	switch (nvme_req(req)->status & 0x7ff) {
> +	case NVME_SC_ANA_TRANSITION:
> +		/*
> +		 * XXX: We should verify the controller doesn't die on during
> +		 * the transition.  But that means we per-group timeout from
> +		 * when we first hit the change state, so this won't be
> +		 * entirely trivial..

something is wrong with the sentence I think "that means we per-group
timeout from when..."

Not sure what you are trying to say.

> +		 */
> +		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
> +		break;
> +	case NVME_SC_ANA_PERSISTENT_LOSS:
> +		nvme_update_ana_state(ns, NVME_ANA_PERSISTENT_LOSS);
> +		break;
> +	case NVME_SC_ANA_INACCESSIBLE:
> +		nvme_update_ana_state(ns, NVME_ANA_INACCESSIBLE);
> +		break;
> +	default:
> +		nvme_reset_ctrl(ns->ctrl);
> +		break;
> +	}
> +
>   	kblockd_schedule_work(&ns->head->requeue_work);
>   }
>   
> @@ -67,12 +96,32 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
>   	up_read(&ctrl->namespaces_rwsem);
>   }
>   
> -static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head)
> +static inline enum nvme_ana_state nvme_ns_ana_state(struct nvme_ns *ns)
> +{
> +	if (!nvme_ctrl_has_ana(ns->ctrl))
> +		return NVME_ANA_OPTIMIZED;
> +	if (WARN_ON_ONCE(ns->anagrpid > ns->ctrl->anagrpmax))
> +		return 0;
> +	return READ_ONCE(ns->ctrl->ana_state[ns->anagrpid]);
> +}
> +
> +static const char *nvme_ana_state_names[] = {
> +	[0]				= "invalid state",
> +	[NVME_ANA_OPTIMIZED]		= "optimized",
> +	[NVME_ANA_NONOPTIMIZED]		= "non-optimized",
> +	[NVME_ANA_INACCESSIBLE]		= "inaccessible",
> +	[NVME_ANA_PERSISTENT_LOSS]	= "persistent-loss",
> +	[NVME_ANA_CHANGE]		= "change",
> +};
> +
> +static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head,
> +		u8 ana_state)
>   {
>   	struct nvme_ns *ns;
>   
>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
> -		if (ns->ctrl->state == NVME_CTRL_LIVE) {
> +		if (ns->ctrl->state == NVME_CTRL_LIVE &&
> +		    nvme_ns_ana_state(ns) == ana_state) {
>   			rcu_assign_pointer(head->current_path, ns);
>   			return ns;
>   		}
> @@ -85,8 +134,14 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>   {
>   	struct nvme_ns *ns = srcu_dereference(head->current_path, &head->srcu);
>   
> -	if (unlikely(!ns || ns->ctrl->state != NVME_CTRL_LIVE))
> -		ns = __nvme_find_path(head);
> +	if (likely(ns && ns->ctrl->state == NVME_CTRL_LIVE &&
> +			nvme_ns_ana_state(ns) == NVME_ANA_OPTIMIZED))
> +		return ns;
> +
> +	ns = __nvme_find_path(head, NVME_ANA_OPTIMIZED);
> +	if (!ns)
> +		ns = __nvme_find_path(head, NVME_ANA_NONOPTIMIZED);
> +	/* XXX: try an inaccessible path as last resort per 8.18.3.3 */
>   	return ns;
>   }
>   
> @@ -239,3 +294,147 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>   	blk_cleanup_queue(head->disk->queue);
>   	put_disk(head->disk);
>   }
> +
> +static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
> +{
> +	void *base = ctrl->ana_log_buf;
> +	struct nvme_ns *ns;
> +	size_t offset;
> +	int error, i;
> +
> +	/*
> +	 * If anagrpid never changes we don't need to process the namespace
> +	 * lists.
> +	 */
> +	if (ctrl->anacap & (1 << 6))
> +		groups_only = true;
> +
> +	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA,
> +			groups_only ? NVME_ANA_LOG_RGO : 0,
> +			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
> +	if (error) {
> +		dev_warn(ctrl->device, "Failed to get ANA log: %d\n", error);
> +		return error;
> +	}
> +
> +	offset = sizeof(struct nvme_ana_rsp_hdr);
> +	for (i = 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps); i++) {
> +		struct nvme_ana_group_desc *desc = base + offset;
> +		u32 grpid = le32_to_cpu(desc->grpid);
> +		u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
> +		size_t nsid_buf_size = nr_nsids * sizeof(__le32);
> +
> +		if (WARN_ON_ONCE(grpid == 0))
> +			return -EINVAL;
> +		if (WARN_ON_ONCE(grpid > ctrl->anagrpmax))
> +			return -EINVAL;
> +		if (WARN_ON_ONCE(desc->state == 0))
> +			return -EINVAL;
> +		if (WARN_ON_ONCE(desc->state > NVME_ANA_CHANGE))
> +			return -EINVAL;
> +
> +		dev_info(ctrl->device, "ANA group %d: %s.\n",
> +				grpid, nvme_ana_state_names[desc->state]);
> +		WRITE_ONCE(ctrl->ana_state[grpid], desc->state);
> +		offset += sizeof(*desc);
> +		if (!nr_nsids)
> +			continue;
> +
> +		if (WARN_ON_ONCE(groups_only))
> +			return -EINVAL;
> +		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - nsid_buf_size))
> +			return -EINVAL;
> +
> +		down_write(&ctrl->namespaces_rwsem);
> +		list_for_each_entry(ns, &ctrl->namespaces, list) {
> +			u32 nsid = le32_to_cpu(desc->nsids[n]);
> +
> +			if (ns->head->ns_id != nsid)
> +				continue;
> +			ns->anagrpid = grpid;
> +			if (++n == nr_nsids)
> +				break;
> +		}
> +		up_write(&ctrl->namespaces_rwsem);
> +		WARN_ON_ONCE(n < nr_nsids);
> +
> +		offset += nsid_buf_size;
> +		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc)))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void nvme_ana_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ana_work);
> +
> +	nvme_process_ana_log(ctrl, false);
> +	nvme_kick_requeue_lists(ctrl);

Won't it make sense to kick the requeue list only for namespaces that
are involved in ana state change? Won't attempting this on all
the namespaces might result in retry count increment for namespaces
that are inaccessible? those retries are finite by nvme_max_retries...
