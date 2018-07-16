From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 16 Jul 2018 19:09:04 +0800
Subject: [PATCHv4 3/4] nvme: Introduce frozen controller state
In-Reply-To: <20180713205609.19701-4-keith.busch@intel.com>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-4-keith.busch@intel.com>
Message-ID: <20180716110903.GC25386@ming.t460p>

On Fri, Jul 13, 2018@02:56:08PM -0600, Keith Busch wrote:
> This patch creates a new controller state that transport specific drivers
> can set their controller to prior to starting the controller to have the
> start_work handle frozen request queues and update the hardware contexts.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 21 ++++++++++++++++++++-
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6fed8a454843..7ce339c3fcc4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -288,11 +288,21 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  			break;
>  		}
>  		break;
> +	case NVME_CTRL_FROZEN:
> +		switch (old_state) {
> +		case NVME_CTRL_CONNECTING:
> +			changed = true;
> +			/* FALLTHRU */
> +		default:
> +			break;
> +		}
> +		break;
>  	case NVME_CTRL_LIVE:
>  		switch (old_state) {
>  		case NVME_CTRL_NEW:
>  		case NVME_CTRL_RESETTING:
>  		case NVME_CTRL_CONNECTING:
> +		case NVME_CTRL_FROZEN:
>  			changed = true;
>  			/* FALLTHRU */
>  		default:
> @@ -304,6 +314,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  		case NVME_CTRL_NEW:
>  		case NVME_CTRL_LIVE:
>  		case NVME_CTRL_ADMIN_ONLY:
> +		case NVME_CTRL_FROZEN:
>  			changed = true;
>  			/* FALLTHRU */
>  		default:
> @@ -3435,16 +3446,24 @@ void nvme_start_work(struct work_struct *work)
>  	if (ctrl->kato)
>  		nvme_start_keep_alive(ctrl);
>  
> +	if (ctrl->state == NVME_CTRL_FROZEN) {
> +		nvme_wait_freeze(ctrl);
> +		blk_mq_update_nr_hw_queues(ctrl->tagset, ctrl->queue_count - 1);
> +		nvme_unfreeze(ctrl);
> +		if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> +			return;
> +	}
> +

Now you move unfreezing into start work function, seems this way can't
guarantee that nvme_unfreeze() is strictly paired with nvme_start_freeze() done
in nvme_dev_disable().

In V3, this issue can be avoided by patch of '[PATCHv3 3/9] nvme: Move all IO out of
controller reset'.

Thanks,
Ming
