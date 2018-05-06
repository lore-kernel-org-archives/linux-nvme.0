From: guanjx09@163.com (Guan Junxiong)
Date: Sun, 6 May 2018 10:42:38 +0800
Subject: [PATCH 3/5] nvmet: Add ANA base support
In-Reply-To: <20180504112845.38820-4-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-4-hare@suse.de>
Message-ID: <27413a13-850b-2226-001b-4d28904950cc@163.com>

Hi Hannes,


On Friday, May 04, 2018 07:28 PM, Hannes Reinecke wrote:
> Add ANA support to the nvme target. The ANA configuration is optional,
> and doesn't interfere with existing configurations.
> Each subsystem has distinct ANA groups; if ANA groups are created
> it is required to link the ANA groups into the individual ports.
> Linking the entire subsystem will be refused if ANA groups are
> specified.
> Also this implementation has a limit of one single ANA state per
> groups, irrespective of the path. So when distinct ANA states
> are required one needs to create different ANA groups.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>
>
> +
> +static void nvmet_port_ags_drop_link(struct config_item *parent,
> +		struct config_item *target)
> +{
> +	struct nvmet_port *port = to_nvmet_port(parent->ci_parent);
> +	struct nvmet_ag *ag = to_nvmet_ag(target);
> +	struct nvmet_subsys *subsys = ag->subsys;
> +	struct nvmet_ag_link *p;
> +	int ana_active = 0;
> +
> +	down_write(&nvmet_config_sem);
> +	list_for_each_entry(p, &port->ags, entry) {
> +		if (p->ag == ag)
> +			goto found;
> +	}
> +	up_write(&nvmet_config_sem);
> +	return;
> +
> +found:
> +	list_del(&p->entry);
> +	list_del(&p->ag_list);
> +	nvmet_genctr++;
Why not nvmet_genctrl-- when dropping link?

> +
> +
> +static struct config_group *nvmet_ag_make(struct config_group *group,
> +		const char *name)
> +{
> +	struct nvmet_subsys *subsys = ag_to_subsys(&group->cg_item);
> +	struct nvmet_ag *ag, *a;
> +	int ret;
> +	u32 agid;
> +
> +	ret = kstrtou32(name, 0, &agid);
> +	if (ret)
> +		goto out;
> +
> +	ret = -EINVAL;
> +	if (agid == 0)
> +		goto out;
> +	ret = -ENOMEM;
> +	ag = nvmet_ag_alloc(subsys, agid);
> +	if (!ag)
> +		goto out;
> +	ret = -EEXIST;
> +	down_write(&nvmet_config_sem);
> +	list_for_each_entry_rcu(a, &subsys->ana_groups, entry) {
> +		if (a->grpid == agid) {
> +			nvmet_ag_free(ag);
> +			goto out;
> +		}
> +	}
> +	list_add_tail(&ag->entry, &subsys->ana_groups);
> +	up_write(&nvmet_config_sem);
> +	config_group_init_type_name(&ag->group, name, &nvmet_ag_type);
> +
> +	pr_info("adding ana groupid %d to subsystem %s\n",
> +		agid, subsys->subsysnqn);
> +	return &ag->group;
> +out:
Here should be added:? up_write(&nvmet_config_sem);
> +	return ERR_PTR(ret);


> +}
> +
> +static struct configfs_group_operations nvmet_ana_group_group_ops = {
> +	.make_group		= nvmet_ag_make,
I guess we should add :
??????????????? .drop_item? = nvmet_ag_drop,

to implement rmdir operation .



Regards

Guan Junxiong
