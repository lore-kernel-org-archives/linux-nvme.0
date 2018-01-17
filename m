From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 17 Jan 2018 11:06:03 +0200
Subject: [PATCH V4 1/2] nvme: add NVME_CTRL_RESET_PREPARE state
In-Reply-To: <1516164877-2170-2-git-send-email-jianchao.w.wang@oracle.com>
References: <1516164877-2170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1516164877-2170-2-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <11106a93-2e78-c853-e6eb-35c652dab3a9@mellanox.com>

hi Jianchao Wang,

On 1/17/2018 6:54 AM, Jianchao Wang wrote:
> Currently, the ctrl->state will be changed to NVME_CTRL_RESETTING
> before queue the reset work. This is not so strict. There could be
> a big gap before the reset_work callback is invoked. In addition,
> there is some disable work in the reset_work callback, strictly
> speaking, not part of reset work, and could lead to some confusion.
> 
> In addition, after set state to RESETTING and disable procedure,
> nvme-rdma/fc use NVME_CTRL_RECONNECTING to mark the setup and
> reconnect procedure. The RESETTING state has been narrowed.
> 
> This patch add NVME_CTRL_RESET_PREPARE state to mark the reset_work
> or error recovery work, scheduling gap and disable procedure.
> After that,
>   - For nvme-pci, nvmet-loop, set state to RESETTING, start
>     initialization.
>   - For nvme-rdma, nvme-fc, set state to RECONNECTING, start
>     initialization or reconnect.
> 
> Suggested-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> ---
>   drivers/nvme/host/core.c   | 18 +++++++++++++++---
>   drivers/nvme/host/fc.c     |  4 ++--
>   drivers/nvme/host/nvme.h   |  8 ++++++++
>   drivers/nvme/host/pci.c    | 25 +++++++++++++++++++++----
>   drivers/nvme/host/rdma.c   |  2 +-
>   drivers/nvme/target/loop.c |  5 +++++
>   6 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 230cc09..87d209f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -87,7 +87,7 @@ static __le32 nvme_get_log_dw10(u8 lid, size_t size)
>   
>   int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>   {
> -	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESET_PREPARE))
>   		return -EBUSY;
>   	if (!queue_work(nvme_wq, &ctrl->reset_work))
>   		return -EBUSY;
> @@ -260,7 +260,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   			break;
>   		}
>   		break;
> -	case NVME_CTRL_RESETTING:
> +	case NVME_CTRL_RESET_PREPARE:
>   		switch (old_state) {
>   		case NVME_CTRL_NEW:
>   		case NVME_CTRL_LIVE:
> @@ -271,10 +271,20 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   			break;
>   		}
>   		break;
> +
> +	case NVME_CTRL_RESETTING:
> +		switch (old_state) {
> +		case NVME_CTRL_RESET_PREPARE:
> +			changed = true;
> +			/* FALLTHRU */
> +		default:
> +			break;
> +		}
> +		break;
>   	case NVME_CTRL_RECONNECTING:
>   		switch (old_state) {
>   		case NVME_CTRL_LIVE:
> -		case NVME_CTRL_RESETTING:
> +		case NVME_CTRL_RESET_PREPARE:

As I suggested in V3, please don't allow this transition.
We'll move to NVME_CTRL_RECONNECTING from NVME_CTRL_RESETTING.

I look on it like that:

NVME_CTRL_RESET_PREPARE - "suspend" state
NVME_CTRL_RESETTING - "resume" state

you don't reconnect from "suspend" state, you must "resume" before you 
reconnect.


>   			changed = true;
>   			/* FALLTHRU */
>   		default:
> @@ -286,6 +296,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		case NVME_CTRL_LIVE:
>   		case NVME_CTRL_ADMIN_ONLY:
>   		case NVME_CTRL_RESETTING:
> +		case NVME_CTRL_RESET_PREPARE:
>   		case NVME_CTRL_RECONNECTING:
>   			changed = true;
>   			/* FALLTHRU */
> @@ -2660,6 +2671,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
>   		[NVME_CTRL_LIVE]	= "live",
>   		[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
>   		[NVME_CTRL_RESETTING]	= "resetting",
> +		[NVME_CTRL_RESET_PREPARE]	= "reset-prepare",
>   		[NVME_CTRL_RECONNECTING]= "reconnecting",
>   		[NVME_CTRL_DELETING]	= "deleting",
>   		[NVME_CTRL_DEAD]	= "dead",
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 306aee4..1ba0669 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -546,7 +546,7 @@ nvme_fc_resume_controller(struct nvme_fc_ctrl *ctrl)
>   		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
>   		break;
>   
> -	case NVME_CTRL_RESETTING:
> +	case NVME_CTRL_RESET_PREPARE:
>   		/*
>   		 * Controller is already in the process of terminating the
>   		 * association. No need to do anything further. The reconnect
> @@ -789,7 +789,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
>   		 */
>   		break;
>   
> -	case NVME_CTRL_RESETTING:
> +	case NVME_CTRL_RESET_PREPARE:
>   		/*
>   		 * Controller is already in the process of terminating the
>   		 * association.  No need to do anything further. The reconnect
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a44eeca..e4cae21 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -116,10 +116,18 @@ static inline struct nvme_request *nvme_req(struct request *req)
>    */
>   #define NVME_QUIRK_DELAY_AMOUNT		2300
>   
> +/*
> + * RESET_PREPARE - mark the state of scheduling gap and disable procedure
> + * RESETTING     - nvme-pci, nvmet loop use it to mark the state of setup
> + *				   procedure
> + * RECONNECTING  - nvme-fc, nvme-rdma use it to mark the state of setup
> + *				   and reconnect procedure
> + */
>   enum nvme_ctrl_state {
>   	NVME_CTRL_NEW,
>   	NVME_CTRL_LIVE,
>   	NVME_CTRL_ADMIN_ONLY,    /* Only admin queue live */
> +	NVME_CTRL_RESET_PREPARE,
>   	NVME_CTRL_RESETTING,
>   	NVME_CTRL_RECONNECTING,
>   	NVME_CTRL_DELETING,
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 45f843d..f4b47b9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1139,8 +1139,13 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
>   	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
>   
>   	/* If there is a reset ongoing, we shouldn't reset again. */
> -	if (dev->ctrl.state == NVME_CTRL_RESETTING)
> +	switch (dev->ctrl.state) {
> +	case NVME_CTRL_RESETTING:
> +	case NVME_CTRL_RESET_PREPARE:
>   		return false;
> +	default:
> +		break;
> +	}
>   
>   	/* We shouldn't reset unless the controller is on fatal error state
>   	 * _or_ if we lost the communication with it.
> @@ -2181,9 +2186,16 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	if (pci_is_enabled(pdev)) {
>   		u32 csts = readl(dev->bar + NVME_REG_CSTS);
>   
> -		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> -		    dev->ctrl.state == NVME_CTRL_RESETTING)
> +		switch (dev->ctrl.state) {
> +		case NVME_CTRL_LIVE:
> +		case NVME_CTRL_RESETTING:
> +		case NVME_CTRL_RESET_PREPARE:
>   			nvme_start_freeze(&dev->ctrl);
> +			break;
> +		default:
> +			break;
> +		}
> +
>   		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
>   			pdev->error_state  != pci_channel_io_normal);
>   	}
> @@ -2294,7 +2306,7 @@ static void nvme_reset_work(struct work_struct *work)
>   	int result = -ENODEV;
>   	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
>   
> -	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
> +	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESET_PREPARE))
>   		goto out;
>   
>   	/*
> @@ -2304,6 +2316,11 @@ static void nvme_reset_work(struct work_struct *work)
>   	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
>   		nvme_dev_disable(dev, false);
>   
> +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> +		WARN_ON_ONCE(dev->ctrl.state != NVME_CTRL_DELETING);
> +		goto out;
> +	}
> +
>   	result = nvme_pci_enable(dev);
>   	if (result)
>   		goto out;
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index d49b1e7..6b5f2f4 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -985,7 +985,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>   
>   static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
>   {
> -	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESET_PREPARE))
>   		return;

We can add a NVME_CTRL_RESET_PREPARE --> NVME_CTRL_RESETTING transition 
and then move to NVME_CTRL_RECONNECTING (in nvme_rdma_reset_ctrl_work 
and nvme_rdma_error_recovery_work).
I want to add an ability to recover from device removal (actually wanted 
to send it today but I'm waiting to see what will happen with this 
patchset) for RDMA and your approach (enable transition to from both 
"suspend" and "resume" to "reconnect") might be problematic.

Sagi/Christoph ?

>   
>   	queue_work(nvme_wq, &ctrl->err_work);
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index fdfcc96..cbc9249 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -481,6 +481,11 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
>   	nvme_stop_ctrl(&ctrl->ctrl);
>   	nvme_loop_shutdown_ctrl(ctrl);
>   
> +	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING);
> +	if (!changed) {
> +		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
> +		return;
> +	}
>   	ret = nvme_loop_configure_admin_queue(ctrl);
>   	if (ret)
>   		goto out_disable;
> 
