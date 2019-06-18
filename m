From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 18 Jun 2019 10:30:46 -0700
Subject: [PATCH 1/2] nvme: Do not remove namespaces during reset
In-Reply-To: <20190618101025.78840-2-hare@suse.de>
References: <20190618101025.78840-1-hare@suse.de>
 <20190618101025.78840-2-hare@suse.de>
Message-ID: <17c5aaa9-a8eb-f541-f136-9a728e72f428@grimberg.me>


> When a controller is resetting or reconnecting there is no way
> how we could establish the validity of any given namespace.
> So do not call nvme_ns_remove() during resetting or reconnecting
> and rely on the call to nvme_scan_queue() after reset to fixup
> things.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/core.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ba2079d217da..e872591e5fe7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3358,6 +3358,17 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   
>   static void nvme_ns_remove(struct nvme_ns *ns)
>   {
> +	/*
> +	 * We cannot make any assumptions about namespaces during
> +	 * reset; in particular we shouldn't attempt to remove them
> +	 * as I/O might still be queued to them.
> +	 * So ignore this call during reset and rely on the
> +	 * rescan after reset to clean up things again.
> +	 */
> +	if (ns->ctrl->state == NVME_CTRL_RESETTING ||
> +	    ns->ctrl->state == NVME_CTRL_CONNECTING)
> +		return;
> +

This is conflicting with the commit log, this condition needs to
go to the call site.
