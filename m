From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 14:36:08 +0300
Subject: [PATCH 3/4] nvmet: Add controllers to configfs
In-Reply-To: <1507635633-16665-4-git-send-email-israelr@mellanox.com>
References: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
 <1507635633-16665-4-git-send-email-israelr@mellanox.com>
Message-ID: <fc211d66-a762-8540-b2a9-9bc01a3a4c6a@grimberg.me>


> The commit show all the controllers and some info about them.
> This will allow the user to monitor the created controllers from target
> point of view.
> The "controllers" folder was added per subsystem under:
> /config/nvmet/subsystems/<SUBSYSTEM_NAME>/controllers/<CTRL_ID>/
> 
> <CTRL_ID> folder consists of:
>   - hostnqn: Host NQN
>   - port_traddr: Port Transport Address
>   - port_trsvcid: Port Transport Service ID
> 
> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/target/configfs.c | 73 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c     |  6 ++++
>   drivers/nvme/target/nvmet.h    | 10 ++++++
>   3 files changed, 89 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index b6aeb1d..a0942c3 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -469,6 +469,49 @@ static struct config_group *nvmet_ns_make(struct config_group *group,
>   	.ct_owner		= THIS_MODULE,
>   };
>   
> +static ssize_t nvmet_ctrl_hostnqn_show(struct config_item *item, char *page)
> +{
> +	struct nvmet_ctrl *ctrl = to_nvmet_ctrl(item);
> +
> +	return snprintf(page, PAGE_SIZE, "%s\n", ctrl->hostnqn);
> +}
> +
> +CONFIGFS_ATTR_RO(nvmet_ctrl_, hostnqn);
> +
> +static ssize_t nvmet_ctrl_traddr_show(struct config_item *item, char *page)
> +{
> +	struct nvmet_ctrl *ctrl = to_nvmet_ctrl(item);
> +
> +	return snprintf(page, PAGE_SIZE, "%s\n", ctrl->port->disc_addr.traddr);
> +}
> +
> +CONFIGFS_ATTR_RO(nvmet_ctrl_, traddr);
> +
> +static ssize_t nvmet_ctrl_trsvcid_show(struct config_item *item, char *page)
> +{
> +	struct nvmet_ctrl *ctrl = to_nvmet_ctrl(item);
> +
> +	return snprintf(page, PAGE_SIZE, "%s\n", ctrl->port->disc_addr.trsvcid);
> +}
> +
> +CONFIGFS_ATTR_RO(nvmet_ctrl_, trsvcid);
> +
> +static struct configfs_attribute *nvmet_ctrl_attrs[] = {
> +	&nvmet_ctrl_attr_hostnqn,
> +	&nvmet_ctrl_attr_traddr,
> +	&nvmet_ctrl_attr_trsvcid,
> +	NULL,
> +};
> +
> +static struct config_item_type nvmet_ctrl_type = {
> +	.ct_attrs		= nvmet_ctrl_attrs,
> +	.ct_owner		= THIS_MODULE,
> +};
> +
> +static struct config_item_type nvmet_controllers_type = {
> +	.ct_owner		= THIS_MODULE,
> +};
> +
>   static int nvmet_port_subsys_allow_link(struct config_item *parent,
>   		struct config_item *target)
>   {
> @@ -760,6 +803,10 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
>   	configfs_add_default_group(&subsys->allowed_hosts_group,
>   			&subsys->group);
>   
> +	config_group_init_type_name(&subsys->controllers_group,
> +			"controllers", &nvmet_controllers_type);
> +	configfs_add_default_group(&subsys->controllers_group, &subsys->group);
> +

I think nvmet_ctrl is a much better fit as a config_item, perhaps we
need a kernel API to add a config_item? Or maybe it can bring all sorts
of races?

Christoph, what are your thoughts on this?
