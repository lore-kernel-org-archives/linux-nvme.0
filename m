From: hch@lst.de (Christoph Hellwig)
Date: Mon, 29 May 2017 19:57:07 +0200
Subject: [PATCH v2 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <1496067498-26233-1-git-send-email-a.dawn@samsung.com>
References: <1496067391-26143-1-git-send-email-a.dawn@samsung.com>
 <CGME20170529141807epcas1p259e2e9b04327285d18f2d62bb6ccbce1@epcas1p2.samsung.com>
 <1496067498-26233-1-git-send-email-a.dawn@samsung.com>
Message-ID: <20170529175707.GB25061@lst.de>

On Mon, May 29, 2017@07:48:18PM +0530, Arnav Dawn wrote:
> This patch adds support for handling FW activation without reset.
> On completion of FW-activation-starting AER, all queues are
> paused till CSTS.PP is cleared or timed out (exceeds max time for
> fw activtion MTFA). If device fails to clear CSTS.PP within MTFA,
> driver issues reset controller.
> 
> Signed-off-by: Arnav Dawn <a.dawn at samsung.com>
> ---
>  drivers/nvme/host/core.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/nvme.h |  3 ++
>  include/linux/nvme.h     |  3 ++
>  3 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 01d622e..4537346 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1610,7 +1610,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	nvme_set_queue_limits(ctrl, ctrl->admin_q);
>  	ctrl->sgls = le32_to_cpu(id->sgls);
>  	ctrl->kas = le16_to_cpu(id->kas);
> -
> +	ctrl->mtfa = le16_to_cpu(id->mtfa);
>  	ctrl->npss = id->npss;
>  	prev_apsta = ctrl->apsta;
>  	if (ctrl->quirks & NVME_QUIRK_NO_APST) {
> @@ -2279,6 +2279,45 @@ static void nvme_async_event_work(struct work_struct *work)
>  	spin_unlock_irq(&ctrl->lock);
>  }
>  
> +static void nvme_fw_act_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
> +				struct nvme_ctrl, fw_act_work);
> +	struct nvme_fw_slot_info_log *log;
> +	u32 csts;
> +
> +	nvme_stop_queues(ctrl);
> +	while (1) {
> +		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
> +			break;
> +
> +		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
> +				&ctrl->ctrl_config))
> +			break;
> +
> +		if (csts == ~0 || ((ctrl->ctrl_config & NVME_CC_ENABLE)
> +				&& !(csts & NVME_CSTS_PP)))
> +			break;

Can you factor these checks into a helper that your loop checks in
the while statement?

> +	nvme_start_queues(ctrl);
> +	ctrl->fw_act_timeout = 0;
> +	log =  kmalloc(sizeof(struct nvme_fw_slot_info_log), GFP_KERNEL);
> +	if (!log)
> +		return;
> +	if (nvme_get_log_page(ctrl, NVME_LOG_FW_SLOT, log))
> +		dev_warn(ctrl->device,
> +				"Get FW SLOT INFO log error\n");
> +	kfree(log);

So we don't do anything with the log.  It might be worth having a comment
like:

	/* read the firmware activation log to clear the AER */

for readers of the code that don't know the NVMe spec inside out.

> +	case NVME_AER_NOTICE_FW_ACT_STARTING:
> +	{
> +		u32 csts;
> +
> +		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
> +			return;
> +		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
> +					&ctrl->ctrl_config))
> +			return;
> +
> +		if ((ctrl->ctrl_config & NVME_CC_ENABLE)
> +					&& (csts & NVME_CSTS_PP)) {
> +			if (ctrl->mtfa)
> +				ctrl->fw_act_timeout = jiffies +
> +					msecs_to_jiffies(ctrl->mtfa * 100);
> +			else
> +				ctrl->fw_act_timeout = jiffies +
> +					msecs_to_jiffies(admin_timeout * 1000);
> +
> +			schedule_delayed_work(&ctrl->fw_act_work, 0);
> +		}
> +		break;

Please split this code into a helper.
