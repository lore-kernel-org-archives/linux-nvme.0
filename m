From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 25 May 2019 22:17:12 +0900
Subject: [PATCH 3/3] nvme: quiesce admin queue for fw activation
In-Reply-To: <20190524202036.17265-4-keith.busch@intel.com>
References: <20190524202036.17265-1-keith.busch@intel.com>
 <20190524202036.17265-4-keith.busch@intel.com>
Message-ID: <20190525131710.GA342@minwooim-desktop>

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 96dac2292897..5a6d27823f7f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3604,7 +3604,10 @@ static void nvme_fw_act_work(struct work_struct *work)
>  		fw_act_timeout = jiffies +
>  				msecs_to_jiffies(admin_timeout * 1000);
>  
> +	dev_info(ctrl->device, "processing paused for fw activation\n");
>  	nvme_stop_queues(ctrl);
> +	blk_mq_quiesce_queue(ctrl->admin_q);

Keith,

Can we have an warning here to indicate if device firmware has not set
the CSTS.PP yet.  In that case, the information message that you have
introduced here may be invalid.  It would be great if we check the
CSTS.PP first, and then print it out.

If it's not necessary to have it, please feel free to let me know.
Of course, device has to prepared the processing paused status,
though :)

> +
>  	while (nvme_ctrl_pp_status(ctrl)) {
>  		if (time_after(jiffies, fw_act_timeout)) {
>  			dev_warn(ctrl->device,
> @@ -3619,7 +3622,10 @@ static void nvme_fw_act_work(struct work_struct *work)
>  	    ctrl->state != NVME_CTRL_ADMIN_ONLY)
>  		return;
>  
> +	dev_info(ctrl->device, "processing resumed\n");

Can we print it out after admin_q, io_q are unquiesced ?

> +	blk_mq_unquiesce_queue(ctrl->admin_q);
>  	nvme_start_queues(ctrl);
> +
>  	/* read FW slot information to clear the AER */
>  	nvme_get_fw_slot_info(ctrl);
>  }

I am very okay to quiesce the admin_q here.

Thanks,
