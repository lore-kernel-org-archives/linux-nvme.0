From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 20 Jun 2019 09:22:01 +0800
Subject: [PATCH 1/2] nvme: Do not remove namespaces during reset
In-Reply-To: <20190618101025.78840-2-hare@suse.de>
References: <20190618101025.78840-1-hare@suse.de>
 <20190618101025.78840-2-hare@suse.de>
Message-ID: <20190620012200.GA31179@ming.t460p>

Hi Hannes,

Could you explain a bit what the user visible issue is addressed by this
patch?

On Tue, Jun 18, 2019@12:10:24PM +0200, Hannes Reinecke wrote:
> When a controller is resetting or reconnecting there is no way
> how we could establish the validity of any given namespace.
> So do not call nvme_ns_remove() during resetting or reconnecting
> and rely on the call to nvme_scan_queue() after reset to fixup
> things.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ba2079d217da..e872591e5fe7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3358,6 +3358,17 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  
>  static void nvme_ns_remove(struct nvme_ns *ns)
>  {
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
>  	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>  		return;

nvme_ns_remove() may be called from nvme_remove_invalid_namespaces()
and nvme_remove_namespaces(), in which the 'ns' to be removed is
retrieved & deleted from ctrl->namespaces.

That means if the 'ns' needs to be removed by the two mentioned
functions from scan work context again after reset is done, the removal
may never be done because the 'ns' can't be found in ctrl->namespaces.

If you want to avoid the use-after-free issue[1], I'd suggest to use
the queue refcount.

https://lore.kernel.org/linux-block/20190424110221.17435-10-ming.lei at redhat.com/

Thanks,
Ming
