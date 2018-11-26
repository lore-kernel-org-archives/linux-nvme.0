From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Nov 2018 08:58:17 -0700
Subject: [PATCH] nvme: Fix PCIe surprise removal scenario
In-Reply-To: <20181123155810.60246-1-igor.j.konopko@intel.com>
References: <20181123155810.60246-1-igor.j.konopko@intel.com>
Message-ID: <20181126155816.GQ26707@localhost.localdomain>

On Fri, Nov 23, 2018@07:58:10AM -0800, Igor Konopko wrote:
> This patch fixes kernel OOPS for surprise removal
> scenario for PCIe connected NVMe drives.
> 
> After latest changes, when PCIe device is not present,
> nvme_dev_remove_admin() calls blk_cleanup_queue() on
> admin queue, which frees hctx for that queue.
> Moment later, on the same path nvme_kill_queues()
> calls blk_mq_unquiesce_queue() on admin queue and
> tries to access hctx of it, which leads to
> following OOPS scenario:
> 
> Oops: 0000 [#1] SMP PTI
> RIP: 0010:sbitmap_any_bit_set+0xb/0x40
> Call Trace:
>  blk_mq_run_hw_queue+0xd5/0x150
>  blk_mq_run_hw_queues+0x3a/0x50
>  nvme_kill_queues+0x26/0x50
>  nvme_remove_namespaces+0xb2/0xc0
>  nvme_remove+0x60/0x140
>  pci_device_remove+0x3b/0xb0
> 
> Fixes: cb4bfda62afa2 ("nvme-pci: fix hot removal during error handling")
> Signed-off-by: Igor Konopko <igor.j.konopko at intel.com>

Thanks Igor, my previous proposal was a bit flawed, and this patch looks
good. For the future, you should adjust your commit log formatting to
use the more standard 72 character width.

The fix should go in for the next rc for sure. Maybe longer term, if
a request_queue has an active reference, it might make sense to have
blk-mq's APIs consistently handle these sorts of things.

Reviewed-by: Keith Busch <keith.busch at intel.com>


> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 65c42448e904..5aff95389694 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3601,7 +3601,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  	down_read(&ctrl->namespaces_rwsem);
>  
>  	/* Forcibly unquiesce queues to avoid blocking dispatch */
> -	if (ctrl->admin_q)
> +	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>  		blk_mq_unquiesce_queue(ctrl->admin_q);
>  
>  	list_for_each_entry(ns, &ctrl->namespaces, list)
> -- 
> 2.14.5
