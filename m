From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Dec 2017 23:39:20 +0100
Subject: [PATCH 3/4] nvmet: Add controllers to configfs
In-Reply-To: <1510576183-17215-4-git-send-email-israelr@mellanox.com>
References: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
 <1510576183-17215-4-git-send-email-israelr@mellanox.com>
Message-ID: <20171204223920.GC19672@lst.de>

On Mon, Nov 13, 2017@12:29:42PM +0000, Israel Rukshin wrote:
> The commit show all the controllers and some info about them.
> This will allow the user to monitor the created controllers from target
> point of view.
> The "controllers" folder was added per subsystem under:
> /config/nvmet/subsystems/<SUBSYSTEM_NAME>/controllers/<CTRL_ID>/
> 
> <CTRL_ID> folder consists of:
>  - hostnqn: Host NQN

This makes sense.

>  - port_traddr: Port Transport Address
>  - port_trsvcid: Port Transport Service ID

These are port properties.  You probably want to create a symlink
to the port from the controller directory instead.

> +void nvmet_ctrl_configfs_del(struct nvmet_ctrl *ctrl)
> +{
> +	if (d_inode(ctrl->group.cg_item.ci_dentry))
> +		configfs_unregister_group(&ctrl->group);
> +}

Are we even guaranteed that the denty is still around?  What happens
if you do a drop of all caches after the manual removal and then
?xecute this path later?
> +	int res = 0;
> +	char name[CONFIGFS_ITEM_NAME_LEN];
> +
> +	sprintf(name, "%d", ctrl->cntlid);
> +	pr_debug("Adding controller %s to configfs\n", name);
> +
> +	config_group_init_type_name(&ctrl->group, name, &nvmet_ctrl_type);
> +

Hmm - we probably should either add varargs to config_group_init_type_name
or just open code it.  config_item_set_name takes varargs, so having
this static buffer is a little silly.  I'll take a look at the configfs
side.
