From: keith.busch@intel.com (Keith Busch)
Date: Fri, 5 May 2017 11:27:42 -0400
Subject: [PATCH] nvme: Add support for FW activation without reset
In-Reply-To: <3c020871fbee817c9a905cb69df7ade4f978c581.1493971901.git.a.dawn@samsung.com>
References: <CGME20170505114235epcas1p37200fbb3f181c1c840ab3c46b95691f1@epcas1p3.samsung.com>
 <3c020871fbee817c9a905cb69df7ade4f978c581.1493971901.git.a.dawn@samsung.com>
Message-ID: <20170505152742.GA1434@localhost.localdomain>

On Fri, May 05, 2017@05:11:55PM +0530, Arnav dawn wrote:
> This patch adds support for AER handling to activate firmware
> without controller reset.

I agree with the feature in principle, but have some comments on the
implementation.

> +static void nvme_fw_act_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl =
> +		container_of(work, struct nvme_ctrl, fw_act_work);
> +	u32 csts, ret;

IO not being possible in this state, shouldn't we call nvme_stop_queues
and restart after CSTS.PP clears so we don't risk IO timeout while
activation is occuring?

> +	while (1) {
> +		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts);
> +		if (ret)
> +			return;
> +
> +		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
> +					&ctrl->ctrl_config);
> +		if (ret)
> +			return;
> +
> +		if ((ctrl->ctrl_config & NVME_CC_ENABLE)
> +				&& !(csts & NVME_CSTS_PP)) {

In case the the drive is removed during the event, append to the 'if':

	|| (csts == ~0)


> +			ctrl->lfu_timeout = 0;
> +			return;
> +		}
> +		if (time_after(jiffies, ctrl->lfu_timeout)) {
> +			dev_warn(ctrl->device,
> +				"Fw activation timeout, reset controller\n");

The log warns that it will reset the controller but that's not
happening.

> +			return;
> +		}
> +		msleep(100);
> +	}
> +}

At the end of this function, we should get the firmware information log
page to re-arm the event. Or are you counting on user space to do that?

> +	case NVME_AER_ERR_FW_IMG_LOAD:
> +		dev_warn(ctrl->device, "FW image load error\n");
> +		cancel_work_sync(&ctrl->fw_act_work);

This is executing in irq context, and you can't sync with work in that
state.
