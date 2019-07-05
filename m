From: maxg@mellanox.com (Max Gurtovoy)
Date: Fri, 5 Jul 2019 15:20:30 +0300
Subject: [PATCH v2 2/2] nvmet-loop: Flush nvme_delete_wq when removing the
 port
In-Reply-To: <20190703230304.22905-3-logang@deltatee.com>
References: <20190703230304.22905-1-logang@deltatee.com>
 <20190703230304.22905-3-logang@deltatee.com>
Message-ID: <bbbfdcda-5acc-a02c-565a-929180ab6c0c@mellanox.com>


On 7/4/2019 2:03 AM, Logan Gunthorpe wrote:
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
> ---
>   drivers/nvme/target/loop.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 9e211ad6bdd3..da9cd07461fb 100644
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

Looks good:

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
