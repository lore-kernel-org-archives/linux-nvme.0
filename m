From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 10:09:01 +0200
Subject: [PATCH 09/10] nvmet: support configuring ANA groups
In-Reply-To: <20180606143311.23076-10-hch@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
 <20180606143311.23076-10-hch@lst.de>
Message-ID: <20180607100901.5d7e92ab@pentland.suse.de>

On Wed,  6 Jun 2018 16:33:10 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Allow creating non-default ANA groups (group ID > 1).  Groups are
> created either by assigning the group ID to a namespace, or by
> creating a configfs group object under a specific port.  All
> namespaces assigned to a group that doesn't have a configfs object
> for a given port are marked as inaccessible.
> 
> Allow changing the ANA state on a per-port basis by creating an
> ana_groups directory under each port, and another directory with an
> ana_state file in it.  The default ANA group 1 directory is created
> automatically for each port.
> 
> For all changes in ANA configuration the ANA change AEN is sent.  We
> only keep a global changecount instead of additional per-group
> changecounts to keep the implementation as simple as possible.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/target/admin-cmd.c |   1 +
>  drivers/nvme/target/configfs.c  | 181
> +++++++++++++++++++++++++++++++++++++++-
> drivers/nvme/target/core.c      |  24 ++++++
> drivers/nvme/target/nvmet.h     |  30 ++++++- 4 files changed, 232
> insertions(+), 4 deletions(-)
> 
[ .. ]
> @@ -921,6 +1089,17 @@ static struct config_group
> *nvmet_ports_make(struct config_group *group, "referrals",
> &nvmet_referrals_type);
> configfs_add_default_group(&port->referrals_group, &port->group); 
> +	config_group_init_type_name(&port->ana_groups_group,
> +			"ana_groups", &nvmet_ana_groups_type);
> +	configfs_add_default_group(&port->ana_groups_group,
> &port->group); +
> +	port->ana_group1.port = port;
> +	port->ana_group1.grpid = 1;

NVMET_DEFAULT_ANA_GRPID ?

And maybe rename 'ana_group1' to 'ana_default_group' ?

> +	config_group_init_type_name(&port->ana_group1.group,
> +			"1", &nvmet_ana_group_type);

snprintf(grpname, "%d", NVMET_DEFAULT_ANA_GRPID); ?

> +	configfs_add_default_group(&port->ana_group1.group,
> +			&port->ana_groups_group);
> +
>  	return &port->group;
>  }
>  
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 72c1df24346a..72c573c0a8df 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -193,6 +193,30 @@ static void nvmet_ns_changed(struct nvmet_subsys
> *subsys, u32 nsid) }
>  }
>  
> +void nvmet_send_ana_event(struct nvmet_subsys *subsys)
> +{
> +	struct nvmet_ctrl *ctrl;
> +
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (nvmet_aen_disabled(ctrl,
> NVME_AEN_CFG_ANA_CHANGE))
> +			continue;
> +		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
> +				NVME_AER_NOTICE_ANA, NVME_LOG_ANA);
> +	}
> +	mutex_unlock(&subsys->lock);
> +}
> +

Isn't this sending too many AENs?
We're changing the ANA state per _port_, which is linked to individual
controllers.
But controllers which are _not_ on that port won't be affected by the
ANA change, so in theory we shouldn't send ANA AENs for not-affected
controllers.

Can't we just add a pointer to the port in the nvmet_ctrl structure and
filter according to the affected ports?

Cheers,

Hannes
