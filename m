From: emilne@redhat.com (Ewan D. Milne)
Date: Thu, 03 Jan 2019 15:24:26 -0500
Subject: [PATCHv2] nvme-multipath: round-robin I/O policy
In-Reply-To: <20181221141330.96599-1-hare@suse.de>
References: <20181221141330.96599-1-hare@suse.de>
Message-ID: <4f9a3072c6f3a08000346894fbcf9269ff869241.camel@redhat.com>

On Fri, 2018-12-21@15:13 +0100, Hannes Reinecke wrote:
> Implement a simple round-robin I/O policy for multipathing.
> Path selection is done in two rounds, first iterating across all
> optimized paths, and, if that doesn't return any valid paths,
> then iterate over all optimized and non-optimized paths.
> If no paths are found we're using the existing algorithm.
> This patch also implements a sysfs attribute 'iopolicy' to switch
> between the current, NUMA-aware I/O policy and the 'round-robin'
> I/O policy.
> The original NUMA-aware I/O policy is kept as a default.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>

This works fine for me, and resolves the hang I saw in the earlier
version when all the paths were taken down.  I have one comment about
the state checking in this version, see below...

> ---
>  drivers/nvme/host/core.c      |   6 +++
>  drivers/nvme/host/multipath.c | 100 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/nvme.h      |  12 +++++
>  3 files changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 08f2c92602f4..7603aaa8217e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2275,6 +2275,9 @@ static struct attribute *nvme_subsys_attrs[] = {
>  	&subsys_attr_serial.attr,
>  	&subsys_attr_firmware_rev.attr,
>  	&subsys_attr_subsysnqn.attr,
> +#ifdef CONFIG_NVME_MULTIPATH
> +	&subsys_attr_iopolicy.attr,
> +#endif
>  	NULL,
>  };
>  
> @@ -2327,6 +2330,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
>  	subsys->vendor_id = le16_to_cpu(id->vid);
>  	subsys->cmic = id->cmic;
> +#ifdef CONFIG_NVME_MULTIPATH
> +	subsys->iopolicy = NVME_IOPOLICY_NUMA;
> +#endif
>  
>  	subsys->dev.class = nvme_subsys_class;
>  	subsys->dev.release = nvme_release_subsystem;
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 183ec17ba067..69cccdaea62e 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -141,7 +141,10 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>  		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>  			continue;
>  
> -		distance = node_distance(node, ns->ctrl->numa_node);
> +		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
> +			distance = node_distance(node, ns->ctrl->numa_node);
> +		else
> +			distance = LOCAL_DISTANCE;
>  
>  		switch (ns->ana_state) {
>  		case NVME_ANA_OPTIMIZED:
> @@ -168,6 +171,54 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>  	return found;
>  }
>  
> +static struct nvme_ns *__nvme_rr_next_path(struct nvme_ns_head *head, int node,
> +					   struct nvme_ns *old)
> +{
> +	struct nvme_ns *ns, *found = NULL;
> +	bool try_nonoptimized = false;
> +
> +	if (!old)
> +		return NULL;
> +retry:
> +	ns = old;
> +	do {
> +		ns = list_next_or_null_rcu(&head->list, &ns->siblings,
> +					   struct nvme_ns, siblings);
> +		if (!ns) {
> +			ns = list_first_or_null_rcu(&head->list, struct nvme_ns,
> +						    siblings);
> +			if (!ns)
> +				return NULL;
> +
> +			if (ns == old)
> +				/*
> +				 * The list consists of just one entry.
> +				 * Sorry for the noise :-)
> +				 */
> +				return old;
> +		}
> +		if (ns->disk && ns->ctrl->state == NVME_CTRL_LIVE) {

__nvme_find_path() also checks test_bit(NVME_NS_ANA_PENDING, &ns->flags)
in addition to the NVME_CTRL_LIVE state check, maybe this would be needed
here as well?  (i.e. don't select a path that has just received an ANA error
and has the ana_work queued to get the updated ANA state, and queue if
necessary until a usable up-to-date path is found?)

-Ewan

> +			if (ns->ana_state == NVME_ANA_OPTIMIZED) {
> +				found = ns;
> +				break;
> +			}
> +			if (try_nonoptimized &&
> +			    ns->ana_state == NVME_ANA_NONOPTIMIZED) {
> +				found = ns;
> +				break;
> +			}
> +		}
> +	} while (ns != old);
> +
> +	if (found)
> +		rcu_assign_pointer(head->current_path[node], found);
> +	else if (!try_nonoptimized) {
> +		try_nonoptimized = true;
> +		goto retry;
> +	}
> +	return found;
> +}
> +
>  static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
>  {
>  	return ns->ctrl->state == NVME_CTRL_LIVE &&
> @@ -180,6 +231,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>  	struct nvme_ns *ns;
>  
>  	ns = srcu_dereference(head->current_path[node], &head->srcu);
> +	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
> +		ns = __nvme_rr_next_path(head, node, ns);
>  	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
>  		ns = __nvme_find_path(head, node);
>  	return ns;
> @@ -471,6 +524,51 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl)
>  	cancel_work_sync(&ctrl->ana_work);
>  }
>  
> +#define SUBSYS_ATTR_RW(_name, _mode, _show, _store)  \
> +	struct device_attribute subsys_attr_##_name =	\
> +		__ATTR(_name, _mode, _show, _store)
> +
> +static const char *nvme_iopolicy_names[] = {
> +	[NVME_IOPOLICY_UNKNOWN] = "unknown",
> +	[NVME_IOPOLICY_NUMA] = "numa",
> +	[NVME_IOPOLICY_RR] = "round-robin",
> +};
> +
> +static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_subsystem *subsys =
> +		container_of(dev, struct nvme_subsystem, dev);
> +	int iopolicy = NVME_IOPOLICY_UNKNOWN;
> +
> +	if (iopolicy < ARRAY_SIZE(nvme_iopolicy_names))
> +		iopolicy = READ_ONCE(subsys->iopolicy);
> +	return sprintf(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
> +}
> +
> +static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	enum nvme_iopolicy iopolicy = NVME_IOPOLICY_UNKNOWN;
> +	struct nvme_subsystem *subsys =
> +		container_of(dev, struct nvme_subsystem, dev);
> +
> +	if (!strncmp(buf, nvme_iopolicy_names[NVME_IOPOLICY_NUMA],
> +		     strlen(nvme_iopolicy_names[NVME_IOPOLICY_NUMA])))
> +		iopolicy = NVME_IOPOLICY_NUMA;
> +	else if (!strncmp(buf, nvme_iopolicy_names[NVME_IOPOLICY_RR],
> +		     strlen(nvme_iopolicy_names[NVME_IOPOLICY_RR])))
> +		iopolicy = NVME_IOPOLICY_RR;
> +
> +	if (iopolicy == NVME_IOPOLICY_UNKNOWN)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> +	return count;
> +}
> +SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
> +		      nvme_subsys_iopolicy_show, nvme_subsys_iopolicy_store);
> +
>  static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
>  		char *buf)
>  {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2b36ac922596..e24b51a608de 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -246,6 +246,14 @@ struct nvme_ctrl {
>  	unsigned long discard_page_busy;
>  };
>  
> +#ifdef CONFIG_NVME_MULTIPATH
> +enum nvme_iopolicy {
> +	NVME_IOPOLICY_UNKNOWN,
> +	NVME_IOPOLICY_NUMA,
> +	NVME_IOPOLICY_RR,
> +};
> +#endif
> +
>  struct nvme_subsystem {
>  	int			instance;
>  	struct device		dev;
> @@ -265,6 +273,9 @@ struct nvme_subsystem {
>  	u8			cmic;
>  	u16			vendor_id;
>  	struct ida		ns_ida;
> +#ifdef CONFIG_NVME_MULTIPATH
> +	enum nvme_iopolicy	iopolicy;
> +#endif
>  };
>  
>  /*
> @@ -486,6 +497,7 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
>  
>  extern struct device_attribute dev_attr_ana_grpid;
>  extern struct device_attribute dev_attr_ana_state;
> +extern struct device_attribute subsys_attr_iopolicy;
>  
>  #else
>  static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
