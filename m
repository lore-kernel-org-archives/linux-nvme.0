From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 25 Jan 2018 10:33:41 +0800
Subject: [PATCH RESENT] nvme-pci: introduce RECONNECTING state to mark
 initializing procedure
In-Reply-To: <1516629796-2919-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1516629796-2919-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <73d8d789-b7af-85b1-0c5e-7cbc002c1c43@oracle.com>

Hi Keith

If you have time, can have a look at this.
That's really appreciated and thanks in advance.
:)

Jianchao

On 01/22/2018 10:03 PM, Jianchao Wang wrote:
> After Sagi's commit (nvme-rdma: fix concurrent reset and reconnect),
> both nvme-fc/rdma have following pattern:
> RESETTING    - quiesce blk-mq queues, teardown and delete queues/
>                connections, clear out outstanding IO requests...
> RECONNECTING - establish new queues/connections and some other
>                initializing things.
> Introduce RECONNECTING to nvme-pci transport to do the same mark.
> Then we get a coherent state definition among nvme pci/rdma/fc
> transports.
> 
> Suggested-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: James Smart <james.smart at broadcom.com>
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> ---
>  drivers/nvme/host/core.c |  2 +-
>  drivers/nvme/host/pci.c  | 19 +++++++++++++++++--
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 230cc09..23b3e53 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -242,7 +242,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  	switch (new_state) {
>  	case NVME_CTRL_ADMIN_ONLY:
>  		switch (old_state) {
> -		case NVME_CTRL_RESETTING:
> +		case NVME_CTRL_RECONNECTING:
>  			changed = true;
>  			/* FALLTHRU */
>  		default:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 45f843d..05344be 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1138,9 +1138,14 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
>  	 */
>  	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
>  
> -	/* If there is a reset ongoing, we shouldn't reset again. */
> -	if (dev->ctrl.state == NVME_CTRL_RESETTING)
> +	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
> +	switch (dev->ctrl.state) {
> +	case NVME_CTRL_RESETTING:
> +	case NVME_CTRL_RECONNECTING:
>  		return false;
> +	default:
> +		break;
> +	}
>  
>  	/* We shouldn't reset unless the controller is on fatal error state
>  	 * _or_ if we lost the communication with it.
> @@ -2304,6 +2309,16 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
>  		nvme_dev_disable(dev, false);
>  
> +	/*
> +	 * Introduce RECONNECTING state from nvme-fc/rdma transports to mark the
> +	 * initializing procedure here.
> +	 */
> +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RECONNECTING)) {
> +		dev_warn(dev->ctrl.device,
> +			"failed to mark controller RECONNECTING\n");
> +		goto out;
> +	}
> +
>  	result = nvme_pci_enable(dev);
>  	if (result)
>  		goto out;
> 
