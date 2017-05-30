From: a.dawn@samsung.com (Arnav Dawn)
Date: Tue, 30 May 2017 19:33:38 +0530
Subject: [PATCH v2 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <20170529175707.GB25061@lst.de>
References: <20170529175707.GB25061@lst.de>
 <CGME20170530140329epcas1p464afeb48d692b2108592a39a7593f6b3@epcas1p4.samsung.com>
Message-ID: <1496153018-8833-1-git-send-email-a.dawn@samsung.com>

> > +	nvme_stop_queues(ctrl);
> > +	while (1) {
> > +		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
> > +			break;
> > +
> > +		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
> > +				&ctrl->ctrl_config))
> > +			break;
> > +
> > +		if (csts == ~0 || ((ctrl->ctrl_config & NVME_CC_ENABLE)
> > +				&& !(csts & NVME_CSTS_PP)))
> > +			break;
> 
> Can you factor these checks into a helper that your loop checks in the while
> statement?

Sure, i'll take this in next version.

> > +	nvme_start_queues(ctrl);
> > +	ctrl->fw_act_timeout = 0;
> > +	log =  kmalloc(sizeof(struct nvme_fw_slot_info_log), GFP_KERNEL);
> > +	if (!log)
> > +		return;
> > +	if (nvme_get_log_page(ctrl, NVME_LOG_FW_SLOT, log))
> > +		dev_warn(ctrl->device,
> > +				"Get FW SLOT INFO log error\n");
> > +	kfree(log);
> 
> So we don't do anything with the log.  It might be worth having a comment
> like:
> 
> 	/* read the firmware activation log to clear the AER */
> 
> for readers of the code that don't know the NVMe spec inside out.

Agree, that'll be helpful. I'll add.


> > +	case NVME_AER_NOTICE_FW_ACT_STARTING:
> > +	{
> > +		u32 csts;
> > +
> > +		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
> > +			return;
> > +		if (ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
> > +					&ctrl->ctrl_config))
> > +			return;
> > +
> > +		if ((ctrl->ctrl_config & NVME_CC_ENABLE)
> > +					&& (csts & NVME_CSTS_PP)) {
> > +			if (ctrl->mtfa)
> > +				ctrl->fw_act_timeout = jiffies +
> > +					msecs_to_jiffies(ctrl->mtfa * 100);
> > +			else
> > +				ctrl->fw_act_timeout = jiffies +
> > +					msecs_to_jiffies(admin_timeout *
> 1000);
> > +
> > +			schedule_delayed_work(&ctrl->fw_act_work, 0);
> > +		}
> > +		break;
> 
> Please split this code into a helper.

Agree, that'll be lot cleaner.  
