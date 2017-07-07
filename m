From: keith.busch@intel.com (Keith Busch)
Date: Fri, 7 Jul 2017 11:19:15 -0400
Subject: [PATCH v4 1/1] nvme: Add support for FW activation without reset
In-Reply-To: <1499427767-15891-1-git-send-email-a.dawn@samsung.com>
References: <1499427704-15785-1-git-send-email-a.dawn@samsung.com>
 <CGME20170707114212epcas5p20d9752501fcfb6a06c460c25a593b0e6@epcas5p2.samsung.com>
 <1499427767-15891-1-git-send-email-a.dawn@samsung.com>
Message-ID: <20170707151914.GA14788@localhost.localdomain>

On Fri, Jul 07, 2017@05:12:47PM +0530, Arnav Dawn wrote:
> +static int nvme_get_fw_slot_info(struct nvme_ctrl *dev,
> +				struct nvme_fw_slot_info_log *log)
> +{
> +	struct nvme_command c = { };
> +
> +	c.common.opcode = nvme_admin_get_log_page;
> +	c.common.nsid = cpu_to_le32(0xFFFFFFFF);
> +	c.common.cdw10[0] = cpu_to_le32(
> +		(((sizeof(struct nvme_fw_slot_info_log) / 4) - 1) << 16)
> +		| NVME_LOG_FW_SLOT);
> +
> +	if (!log)
> +		return -ENOMEM;

You check if log is not NULL here, but you already checked it before
calling the function.

I think you should just move the log allocation to the above function
instead of taking it as a parameter, anyway.

>  void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  		union nvme_result *res)
>  {
> @@ -2549,6 +2608,14 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  		dev_info(ctrl->device, "rescanning\n");
>  		nvme_queue_scan(ctrl);
>  		break;
> +	case NVME_AER_NOTICE_FW_ACT_STARTING:
> +		schedule_delayed_work(&ctrl->fw_act_work,
> +					msecs_to_jiffies(100));
> +		break;
> +	case NVME_AER_ERR_FW_IMG_LOAD:
> +		dev_warn(ctrl->device, "FW image load error\n");
> +		cancel_delayed_work(&ctrl->fw_act_work);
> +		break;

I'm still not a fan of the delayed work. Just use normal work, and remove
the NVME_AER_ERR_FW_IMG_LOAD case.

> +static inline bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
> +{
> +
> +	u32 csts;
> +
> +	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
> +		return false;
> +
> +	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
> +				&ctrl->ctrl_config))
> +		return false;

The above looks potentially racey. The ctrl->ctrl_config is the value
the driver wants to program CC to, not necessarily the current value. If
you're reading it back, that could race with a controller reset and
we'll get the wrong configuration.

Instead of reading the register, I think you can just rely on the value
of ctrl->ctrl_config to be accurate.
