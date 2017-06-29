From: a.dawn@samsung.com (Arnav Dawn)
Date: Thu, 29 Jun 2017 18:39:51 +0530
Subject: [PATCH V3 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <5cd0e985-332d-6ab6-9a63-30a298376fb9@samsung.com>
References: <1497078344-5509-1-git-send-email-a.dawn@samsung.com>
 <CGME20170610070845epcas1p361081521580b9ca7bf45605249f992e2@epcas1p3.samsung.com>
 <1497078522-5764-1-git-send-email-a.dawn@samsung.com>
 <20170619170551.GK21765@localhost.localdomain>
 <876bfb79-9bf2-1def-2a4e-94d472c08868@samsung.com>
 <20170621133742.GA4962@localhost.localdomain>
 <7c382f8a-12cc-566b-f461-1bc40ccf751c@samsung.com>
 <20170623152546.GB7783@localhost.localdomain>
 <5cd0e985-332d-6ab6-9a63-30a298376fb9@samsung.com>
Message-ID: <dcf3e754-bd6b-87ca-a809-c51a1ca74e6f@samsung.com>



On Sunday 25 June 2017 02:49 PM, Arnav Dawn wrote:
>
> On Friday 23 June 2017 08:55 PM, Keith Busch wrote:
>> On Fri, Jun 23, 2017@05:41:21PM +0530, Arnav Dawn wrote:
>>> On Wednesday 21 June 2017 07:07 PM, Keith Busch wrote:
>>>> One last thing I noticed, it looks like the nvme_fw_act_work will break
>>>> if an IO timeout occurs while it's running since that may reset the
>>>> controller and restart IO queues.
>>> could you please clarify more?
>>> I think ,that, if an IO Timeout resets controller and restarts queue,
>>> the nvme_ctrl_pp_status will return false, ending the nvme_fw_act_work.
>> Sure, the nvme_fw_act_work will observe CSTS.PP cleared, then it restarts
>> the IO queues, but the nvme reset requires those queues to be quiesced.
> Thanks for clarifying,
> i have made following changes based on comments, please review.
>  
> 1. Added a delay of 100ms for scheduling fw_act_work,
> as work without delay could schedule almost immediately which
> may not give time to the controller to set CSTS.PP. 
> Also, Moved fw_act_timeout calculation to the fw_act_work.
>
> +       case NVME_AER_NOTICE_FW_ACT_STARTING:
> +               schedule_delayed_work(&ctrl->fw_act_work,
> msecs_to_jiffies(100));
> +               break;
> +       case NVME_AER_ERR_FW_IMG_LOAD:
> +               dev_warn(ctrl->device, "FW image load error\n");
> +               cancel_delayed_work(&ctrl->fw_act_work);
> +               break;
>
>
> 2. Added a check, that the controller is in NVME_CTRL_LIVE state
> before starting queues once PP is cleared or fw activation times out.
> This prevents starting of queues unless the controller is in Live state.
>
> +static void nvme_fw_act_work(struct work_struct *work)
> +{
> +       struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
> +                               struct nvme_ctrl, fw_act_work);
> +       struct nvme_fw_slot_info_log *log;
> +       unsigned long fw_act_timeout;
> +
> +       if (ctrl->mtfa)
> +               fw_act_timeout = jiffies +
> +                               msecs_to_jiffies(ctrl->mtfa * 100);
> +       else
> +               fw_act_timeout = jiffies +
> +                               msecs_to_jiffies(admin_timeout * 1000);
> +
> +       nvme_stop_queues(ctrl);
> +       while (nvme_ctrl_pp_status(ctrl)) {
> +               if (time_after(jiffies, fw_act_timeout)) {
> +                       dev_warn(ctrl->device,
> +                               "Fw activation timeout, reset
> controller\n");
> +                       ctrl->ops->reset_ctrl(ctrl);
> +                       break;
> +               }
> +               msleep(100);
> +       }
> +
> +       if(ctrl->state != NVME_CTRL_LIVE)
> +               return;
> +
> +       nvme_start_queues(ctrl);
> +       /* read FW slot informationi to clear the AER*/
> +       log = kmalloc(sizeof(struct nvme_fw_slot_info_log), GFP_KERNEL);
> +       if (!log)
> +               return;
> +
> +       if (nvme_get_fw_slot_info(ctrl, log))
> +               dev_warn(ctrl->device,
> +                               "Get FW SLOT INFO log error\n");
> +       kfree(log);
> +}
>
> if this is fine i will send out the next version of patch.
>
>
could you please review this, i will send out the patch if it looks ok.

Thanks
Arnav
