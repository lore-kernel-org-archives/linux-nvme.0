From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 31 Jul 2019 23:53:09 +0000
Subject: [PATCH v3 2/4] nvmet-loop: Flush nvme_delete_wq when removing the
 port
References: <20190731233534.4841-1-logang@deltatee.com>
 <20190731233534.4841-3-logang@deltatee.com>
Message-ID: <BYAPR04MB5749933ACEC902B934CA212586DF0@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good.

Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 07/31/2019 04:35 PM, Logan Gunthorpe wrote:
> After calling nvme_loop_delete_ctrl(), the controllers will not
> yet be deleted because nvme_delete_ctrl() only schedules work
> to do the delete.
>
> This means a race can occur if a port is removed but there
> are still active controllers trying to access that memory.
>
> To fix this, flush the nvme_delete_wq before returning from
> nvme_loop_remove_port() so that any controllers that might
> be in the process of being deleted won't access a freed port.
>
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/target/loop.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index b16dc3981c69..0940c5024a34 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -654,6 +654,14 @@ static void nvme_loop_remove_port(struct nvmet_port *port)
>   	mutex_lock(&nvme_loop_ports_mutex);
>   	list_del_init(&port->entry);
>   	mutex_unlock(&nvme_loop_ports_mutex);
> +
> +	/*
> +	 * Ensure any ctrls that are in the process of being
> +	 * deleted are in fact deleted before we return
> +	 * and free the port. This is to prevent active
> +	 * ctrls from using a port after it's freed.
> +	 */
> +	flush_workqueue(nvme_delete_wq);
>   }
>
>   static const struct nvmet_fabrics_ops nvme_loop_ops = {
>
