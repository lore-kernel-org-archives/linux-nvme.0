From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 31 Jul 2019 23:52:06 +0000
Subject: [PATCH v3 1/4] nvmet: Fix use-after-free bug when a port is
 removed
References: <20190731233534.4841-1-logang@deltatee.com>
 <20190731233534.4841-2-logang@deltatee.com>
Message-ID: <BYAPR04MB5749D4309C95D1318BEC505B86DF0@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good.

Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 07/31/2019 04:36 PM, Logan Gunthorpe wrote:
> When a port is removed through configfs, any connected controllers
> are still active and can still send commands. This causes a
> use-after-free bug which is detected by KASAN for any admin command
> that dereferences req->port (like in nvmet_execute_identify_ctrl).
>
> To fix this, disconnect all active controllers when a subsystem is
> removed from a port. This ensures there are no active controllers
> when the port is eventually removed.
>
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/target/configfs.c |  1 +
>   drivers/nvme/target/core.c     | 12 ++++++++++++
>   drivers/nvme/target/nvmet.h    |  3 +++
>   3 files changed, 16 insertions(+)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index cd52b9f15376..98613a45bd3b 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -675,6 +675,7 @@ static void nvmet_port_subsys_drop_link(struct config_item *parent,
>
>   found:
>   	list_del(&p->entry);
> +	nvmet_port_del_ctrls(port, subsys);
>   	nvmet_port_disc_changed(port, subsys);
>
>   	if (list_empty(&port->subsystems))
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index dad0243c7c96..b86a23aa9020 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -280,6 +280,18 @@ void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops)
>   }
>   EXPORT_SYMBOL_GPL(nvmet_unregister_transport);
>
> +void nvmet_port_del_ctrls(struct nvmet_port *port, struct nvmet_subsys *subsys)
> +{
> +	struct nvmet_ctrl *ctrl;
> +
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (ctrl->port == port)
> +			ctrl->ops->delete_ctrl(ctrl);
> +	}
> +	mutex_unlock(&subsys->lock);
> +}
> +
>   int nvmet_enable_port(struct nvmet_port *port)
>   {
>   	const struct nvmet_fabrics_ops *ops;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 6ee66c610739..c51f8dd01dc4 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -418,6 +418,9 @@ void nvmet_port_send_ana_event(struct nvmet_port *port);
>   int nvmet_register_transport(const struct nvmet_fabrics_ops *ops);
>   void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops);
>
> +void nvmet_port_del_ctrls(struct nvmet_port *port,
> +			  struct nvmet_subsys *subsys);
> +
>   int nvmet_enable_port(struct nvmet_port *port);
>   void nvmet_disable_port(struct nvmet_port *port);
>
>
