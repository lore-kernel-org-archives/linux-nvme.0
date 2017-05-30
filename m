From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 14:38:50 +0300
Subject: [PATCH v2 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <1496067498-26233-1-git-send-email-a.dawn@samsung.com>
References: <1496067391-26143-1-git-send-email-a.dawn@samsung.com>
 <CGME20170529141807epcas1p259e2e9b04327285d18f2d62bb6ccbce1@epcas1p2.samsung.com>
 <1496067498-26233-1-git-send-email-a.dawn@samsung.com>
Message-ID: <d480fd9e-b002-326d-1ee6-dd0f0694b4e1@grimberg.me>



On 29/05/17 17:18, Arnav Dawn wrote:
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
> +
> +		if (time_after(jiffies, ctrl->fw_act_timeout)) {
> +			dev_warn(ctrl->device,
> +				"Fw activation timeout, reset controller\n");
> +			ctrl->ops->reset_ctrl(ctrl);
> +			break;

this triggers controller reset with the request queues stopped, which is
different than all the rest of the call sites. I didn't find anything
wrong with stopping the queues twice although I vaguely remember having
issues with these sort of flows in the past, but things changed since then.

> +		}
> +		msleep(100);
> +	}
> +	nvme_start_queues(ctrl);
> +	ctrl->fw_act_timeout = 0;

Why is this needed?

> +	log =  kmalloc(sizeof(struct nvme_fw_slot_info_log), GFP_KERNEL);
> +	if (!log)
> +		return;
> +	if (nvme_get_log_page(ctrl, NVME_LOG_FW_SLOT, log))
> +		dev_warn(ctrl->device,
> +				"Get FW SLOT INFO log error\n");
> +	kfree(log);
> +}
> +
>  void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  		union nvme_result *res)
>  {
> @@ -2305,6 +2344,34 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  		dev_info(ctrl->device, "rescanning\n");
>  		nvme_queue_scan(ctrl);
>  		break;
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
> +	}
> +	case NVME_AER_ERR_FW_IMG_LOAD:
> +		dev_warn(ctrl->device, "FW image load error\n");
> +		cancel_delayed_work(&ctrl->fw_act_work);
> +		ctrl->fw_act_timeout = 0;

Why is this needed?

> +		break;
>  	default:
>  		dev_warn(ctrl->device, "async event result %08x\n", result);
>  	}
> @@ -2351,6 +2418,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
>  {
>  	flush_work(&ctrl->async_event_work);
>  	flush_work(&ctrl->scan_work);
> +	cancel_delayed_work(&ctrl->fw_act_work);

Shouldn't this be cancel_delayed_work_sync?
