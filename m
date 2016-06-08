From: sagi@lightbits.io (Sagi Grimberg)
Date: Wed, 8 Jun 2016 14:59:40 +0300
Subject: [PATCH v2] NVMe: Add controller state for scheduling resets
In-Reply-To: <1464729484-14424-1-git-send-email-keith.busch@intel.com>
References: <1464729484-14424-1-git-send-email-keith.busch@intel.com>
Message-ID: <575808AC.2030004@lightbits.io>



On 01/06/16 00:18, Keith Busch wrote:
> All resets now must be submitted through the new state. This makes it
> easier to coordinate controller tasks and simplifies the reset logic.
>
> Since all resets go through the same state machine, and most of these
> don't want to block for the reset to complete, this patch makes user
> initiated resets asynchronous as well. Making user resets block until
> complete wasn't necessary in the first place.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> ---
> v1 -> v2:
>    Fix export symbol to use GPL.
>
>   drivers/nvme/host/core.c | 26 ++++++++++++++++++++++----
>   drivers/nvme/host/nvme.h |  2 ++
>   drivers/nvme/host/pci.c  | 40 ++++++++++++++++------------------------
>   3 files changed, 40 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6290477..c822977 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -66,6 +66,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>
>   	spin_lock_irq(&ctrl->lock);
>   	switch (new_state) {
> +	case NVME_CTRL_SCHED_RESET:
> +		switch (old_state) {
> +		case NVME_CTRL_NEW:
> +		case NVME_CTRL_LIVE:
> +			changed = true;
> +			/* FALLTHRU */
> +		default:
> +			break;
> +		}
>   	case NVME_CTRL_LIVE:
>   		switch (old_state) {
>   		case NVME_CTRL_RESETTING:
> @@ -77,8 +86,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		break;
>   	case NVME_CTRL_RESETTING:
>   		switch (old_state) {
> -		case NVME_CTRL_NEW:
> -		case NVME_CTRL_LIVE:
> +		case NVME_CTRL_SCHED_RESET:
>   			changed = true;
>   			/* FALLTHRU */
>   		default:
> @@ -89,6 +97,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		switch (old_state) {
>   		case NVME_CTRL_LIVE:
>   		case NVME_CTRL_RESETTING:
> +		case NVME_CTRL_SCHED_RESET:
>   			changed = true;
>   			/* FALLTHRU */
>   		default:
> @@ -1209,6 +1218,15 @@ out_unlock:
>   	return ret;
>   }
>
> +int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_SCHED_RESET))
> +		return -EBUSY;
> +
> +	return ctrl->ops->reset_ctrl(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
> +
>   static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>   		unsigned long arg)
>   {
> @@ -1222,7 +1240,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>   		return nvme_dev_user_cmd(ctrl, argp);
>   	case NVME_IOCTL_RESET:
>   		dev_warn(ctrl->device, "resetting controller\n");
> -		return ctrl->ops->reset_ctrl(ctrl);
> +		return nvme_reset_ctrl(ctrl);

Hey Keith,

So now that pci doesn't live alone in the subsystem (or won't in the
near future) this sort of change will affect the loop and rdma logic.

My understanding of this patch is that ctrl->ops->reset_ctrl is still
allowed to be synchronous, it just makes an extra state transition
(SCHED_RESET -> RESETTING instead of RESETTING immediately).

Is my understanding correct? Do you think that we should modify the
loop and rdma drivers to do async reset as well?

This also makes the different transport behave differently at the moment
which is something we should strive to avoid...
