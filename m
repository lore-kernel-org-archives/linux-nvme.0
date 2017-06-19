From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Jun 2017 13:05:52 -0400
Subject: [PATCH V3 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <1497078522-5764-1-git-send-email-a.dawn@samsung.com>
References: <1497078344-5509-1-git-send-email-a.dawn@samsung.com>
 <CGME20170610070845epcas1p361081521580b9ca7bf45605249f992e2@epcas1p3.samsung.com>
 <1497078522-5764-1-git-send-email-a.dawn@samsung.com>
Message-ID: <20170619170551.GK21765@localhost.localdomain>

On Sat, Jun 10, 2017@12:38:42PM +0530, Arnav Dawn wrote:
> This patch adds support for handling Fw activation without reset
> On completion of FW-activation-starting AER, all queues are
> paused till CSTS.PP is cleared or timed out (exceeds max time for
> fw activtion MTFA). If device fails to clear CSTS.PP within MTFA,
> driver issues reset controller

 
> @@ -2268,6 +2314,24 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  		dev_info(ctrl->device, "rescanning\n");
>  		nvme_queue_scan(ctrl);
>  		break;
> +	case NVME_AER_NOTICE_FW_ACT_STARTING:
> +	{
> +		if (nvme_ctrl_pp_status(ctrl)) {
> +			if (ctrl->mtfa)
> +				ctrl->fw_act_timeout = jiffies +
> +					msecs_to_jiffies(ctrl->mtfa * 100);

Instead of adding another field to the nvme_ctrl structure, just
calculate the timeout in your nvme_fw_act_work function.

> +			else
> +				ctrl->fw_act_timeout = jiffies +
> +					msecs_to_jiffies(admin_timeout * 1000);
> +
> +			schedule_delayed_work(&ctrl->fw_act_work, 0);

If scheduling with 0 delay, why is this delayed work?
