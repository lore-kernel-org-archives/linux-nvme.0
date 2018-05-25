From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 15:00:57 +0200
Subject: [PATCHv3 3/9] nvme: Move all IO out of controller reset
In-Reply-To: <20180524203500.14081-4-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-4-keith.busch@intel.com>
Message-ID: <20180525130057.GF23463@lst.de>

On Thu, May 24, 2018@02:34:54PM -0600, Keith Busch wrote:
> IO may be retryable, so don't wait for them in the reset path.

Can't parse this.


> These
> commands may trigger a reset if that IO expires without a completion,

What are "these commands"?

> placing it on the requeue list, so waiting for these would deadlock the
> reset handler.
> 
> To fix the theoretical deadlock, this patch unblocks IO submission from

How did you find it if it is theoretical?

> the reset_work as before, but moves the waiting to the scan_work, where
> waiting for IO is safe so that reset_work may proceed to completion. Since
> unfreezing the queues now happens in the controller LIVE state, nvme_dev
> now tracks if the queues were frozen now to prevent incorrect freeze
> depths.
> 
> This patch is also renaming the function 'nvme_dev_add' to a
> more appropriate name that describes what it's actually doing:
> nvme_alloc_io_tags.

Can you split this out into a separate patch?

> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c |  2 ++
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  | 46 +++++++++++++++++++++++++++++++---------------
>  3 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 33034e469bbc..0f0eb85c64b8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3175,6 +3175,8 @@ static void nvme_scan_work(struct work_struct *work)
>  	struct nvme_id_ctrl *id;
>  	unsigned nn;
>  
> +	if (ctrl->ops->update_hw_ctx)
> +		ctrl->ops->update_hw_ctx(ctrl);

nvme_scan_work gets kicked from all kinds of places including
ioctls and AERs. I don't think the code you added below should
be called from all of them.

> +static void nvme_pci_update_hw_ctx(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_dev *dev = to_nvme_dev(ctrl);
> +	bool unfreeze;
> +
> +	mutex_lock(&dev->shutdown_lock);
> +	unfreeze = dev->queues_froze;
> +	mutex_unlock(&dev->shutdown_lock);

No need to take a mutex here is you sample as single <= register
sized value.

> +	if (!unfreeze)
> +		return;

But this whole scheme stinks to me.  For one we are adding more ad-hoc
state outside the state machine, second it all seems very "ad-hoc".

> +
> +	nvme_wait_freeze(&dev->ctrl);
> +	blk_mq_update_nr_hw_queues(ctrl->tagset, dev->online_queues - 1);
> +	nvme_free_queues(dev, dev->online_queues);
> +	nvme_unfreeze(&dev->ctrl);
> +
> +	mutex_lock(&dev->shutdown_lock);
> +	dev->queues_froze = false;
> +	mutex_unlock(&dev->shutdown_lock);

Same here.  Simple READ_ONCE/WRITE_ONCE will give you the right
memory barriers with no need for the lock.

Also except for the nvme_free_queues this all is generic code,
so I think we want this in the core.

And I wonder where this would fit better than the scan work, but I
can't think of anything else but an entirely new work_struct, which
isn't all that great either.

> @@ -2211,7 +2228,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	     dev->ctrl.state == NVME_CTRL_RESETTING)) {
>  		u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
> -		nvme_start_freeze(&dev->ctrl);
> +		if (!dev->queues_froze)	{
> +			nvme_start_freeze(&dev->ctrl);
> +			dev->queues_froze = true;
> +		}

And this sounds like another indicator for a new FROZEN state.  Once
the ctrl already is frozen we really shouldn't even end up in here
anymore.
