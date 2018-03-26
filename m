From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 26 Mar 2018 10:52:52 +0300
Subject: [PATCH rfc 3/3] nvmet: Add port transport active flag
In-Reply-To: <20180322190303.10951-4-sagi@grimberg.me>
References: <20180322190303.10951-1-sagi@grimberg.me>
 <20180322190303.10951-4-sagi@grimberg.me>
Message-ID: <658c0e8d-cdc7-ab48-e4ad-c5ebdcbcbb11@mellanox.com>



On 3/22/2018 9:03 PM, Sagi Grimberg wrote:
> From: Israel Rukshin <israelr at mellanox.com>
> 
> trstate port flag means that nvmet transport is active and ready for

*tractive

this is the configfs attribute name.

> receiving requests from host. It differ from enabled port state (port
> with subsystem symbolic link) which doesn't guarantee this. The trstate

*tractive

> flag is necessary in case the physical ports become down while nvmet ports are enabled.
> In this case the port state remains enabled but tractive flag becomes false.
> 
> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/target/configfs.c | 10 ++++++++++
>   drivers/nvme/target/core.c     |  8 ++++++++
>   drivers/nvme/target/nvmet.h    |  2 ++
>   drivers/nvme/target/rdma.c     |  8 ++++++++
>   4 files changed, 28 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index e6b2d2af81b6..460eeb0c5801 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -268,6 +268,15 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
>   
>   CONFIGFS_ATTR(nvmet_, addr_trtype);
>   
> +static ssize_t nvmet_addr_tractive_show(struct config_item *item, char *page)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +
> +	return sprintf(page, "%d\n", nvmet_is_port_active(port));
> +}
> +
> +CONFIGFS_ATTR_RO(nvmet_, addr_tractive);
> +

addr_ prefix is needed for nvmetcli. Since this is a RO attribute, I'm 
not sure we need this prefix. I guess It will be saved in the config 
file (nvmetcli save) with no reason. And "nvmetcli restore" will try to 
echo 1 in to a RO attribute.

>   /*
>    * Namespace structures & file operation functions below
>    */
> @@ -873,6 +882,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
>   	&nvmet_attr_addr_traddr,
>   	&nvmet_attr_addr_trsvcid,
>   	&nvmet_attr_addr_trtype,
> +	&nvmet_attr_addr_tractive,
>   	NULL,
>   };
>   
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index cd97ec93c1a9..fa2a02c6f0c6 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -205,6 +205,14 @@ void nvmet_disable_port(struct nvmet_port *port)
>   	port->ops = NULL;
>   }
>   
> +bool nvmet_is_port_active(struct nvmet_port *port)
> +{
> +	if (port->ops && port->ops->is_port_active)
> +		return port->ops->is_port_active(port);
> +
> +	return port->enabled;
> +}
> +
>   static void nvmet_keep_alive_timer(struct work_struct *work)
>   {
>   	struct nvmet_ctrl *ctrl = container_of(to_delayed_work(work),
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index dfba1a4ab302..b7ddb38a8210 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -212,6 +212,7 @@ struct nvmet_fabrics_ops {
>   	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
>   	void (*disc_traddr)(struct nvmet_req *req,
>   			struct nvmet_port *port, char *traddr);
> +	bool (*is_port_active)(struct nvmet_port *port);
>   };
>   
>   #define NVMET_MAX_INLINE_BIOVEC	8
> @@ -309,6 +310,7 @@ void nvmet_unregister_transport(struct nvmet_fabrics_ops *ops);
>   
>   int nvmet_enable_port(struct nvmet_port *port);
>   void nvmet_disable_port(struct nvmet_port *port);
> +bool nvmet_is_port_active(struct nvmet_port *port);
>   
>   void nvmet_referral_enable(struct nvmet_port *parent, struct nvmet_port *port);
>   void nvmet_referral_disable(struct nvmet_port *port);
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 1b7f72925e9f..80cb7298a838 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1486,6 +1486,13 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
>   	}
>   }
>   
> +static bool nvmet_rdma_is_port_active(struct nvmet_port *nport)
> +{
> +	struct nvmet_rdma_port *port = nport->priv;
> +
> +	return port->cm_id ? true : false;
> +}
> +
>   static struct nvmet_fabrics_ops nvmet_rdma_ops = {
>   	.owner			= THIS_MODULE,
>   	.type			= NVMF_TRTYPE_RDMA,
> @@ -1493,6 +1500,7 @@ static struct nvmet_fabrics_ops nvmet_rdma_ops = {
>   	.msdbd			= 1,
>   	.has_keyed_sgls		= 1,
>   	.add_port		= nvmet_rdma_add_port,
> +	.is_port_active		= nvmet_rdma_is_port_active,
>   	.remove_port		= nvmet_rdma_remove_port,
>   	.queue_response		= nvmet_rdma_queue_response,
>   	.delete_ctrl		= nvmet_rdma_delete_ctrl,
> 
