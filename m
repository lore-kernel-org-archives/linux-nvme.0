From: jsmart2021@gmail.com (James Smart)
Date: Mon, 24 Apr 2017 12:42:23 -0700
Subject: [PATCH v2 5/5] nvme_fc: add controller reset support
In-Reply-To: <ab68b3c3-7cce-336e-108d-062e4076c449@grimberg.me>
References: <20170411183512.9043-1-jsmart2021@gmail.com>
 <20170411183512.9043-6-jsmart2021@gmail.com>
 <ab68b3c3-7cce-336e-108d-062e4076c449@grimberg.me>
Message-ID: <39cbb355-9def-c1ad-4e97-7e3d0ea74bfb@gmail.com>

On 4/20/2017 5:56 AM, Sagi Grimberg wrote:
>
>> From: James Smart <jsmart2021 at gmail.com>
>>
> It would be very helpful to split this patch into several pieces:
> 1. fixes and cleanups
> 2. preps for teardown and establishment
> 3. delete support
> 4. reset support
> 5. reconnect support
>
> As is, its very hard to review this patch...

Understood. As Christoph has merged it as is into nvme-4.12, I'll 
address the issues that have been pointed out.

>> +#define NVME_FC_MAX_CONNECT_ATTEMPTS    1
>> +
>
> Why 1?

Agreed, pretty weak. Needs to be tied into your new 
nvmef_should_reconnect() logic.



>> +static void
>> +nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
>> +{
>> +    dev_warn(ctrl->ctrl.device,
>> +        "NVME-FC{%d}: transport association error detected: %s\n",
>> +        ctrl->cnum, errmsg);
>> +    dev_info(ctrl->ctrl.device,
>> +        "NVME-FC{%d}: resetting controller\n", ctrl->cnum);
>>
>> -        nvme_fc_destroy_admin_queue(ctrl);
>> +    if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING)) {
>> +        dev_err(ctrl->ctrl.device,
>> +            "NVME-FC{%d}: error_recovery: Couldn't change state "
>> +            "to RECONNECTING\n", ctrl->cnum);
>> +        return;
>>      }
>>
>> -    nvme_fc_ctrl_put(ctrl);
>> +    if (!queue_work(nvme_fc_wq, &ctrl->reset_work))
>> +        dev_err(ctrl->ctrl.device,
>> +            "NVME-FC{%d}: error_recovery: Failed to schedule "
>> +            "reset work\n", ctrl->cnum);
>>  }
>
> Don't you want to stop the queues and fail inflight I/O?

Those are the first actions as part of the reset work.   Failing 
inflight i/o - no, as that's a rather large amount of work for FC. 
Stopping the queues - perhaps. I'll look. In general, shouldn't really
matter as doing it now or elongating the time window to reset work
doesn't change the race. it lowers the number of other ios that may
report error, but does not eliminate it. So if some will hit it, it
doesn't matter.




>> +    /* wait for all io that had to be aborted */
>> +    spin_lock_irqsave(&ctrl->lock, flags);
>> +    while (ctrl->iocnt) {
>> +        spin_unlock_irqrestore(&ctrl->lock, flags);
>> +        msleep(1000);
>> +        spin_lock_irqsave(&ctrl->lock, flags);
>> +    }
>
> struct completion for this?

Agreed.



>> +static void
>> +nvme_fc_delete_ctrl_work(struct work_struct *work)
>> +{
>> +    struct nvme_fc_ctrl *ctrl =
>> +        container_of(work, struct nvme_fc_ctrl, delete_work);
>> +
>> +    cancel_work_sync(&ctrl->reset_work);
>> +    cancel_delayed_work_sync(&ctrl->connect_work);
>> +
>> +    /*
>> +     * kill the association on the link side.  this will block
>> +     * waiting for io to terminate
>> +     */
>> +    nvme_fc_delete_association(ctrl);
>> +
>> +    /*
>> +     * tear down the controller
>> +     * This will result in the last reference on the nvme ctrl to
>> +     * expire, calling the transport nvme_fc_nvme_ctrl_freed() callback.
>> +     * From there, the transport will tear down it's logical queues and
>> +     * association.
>> +     */
>
> Aren't you taking an extra ref in nvme_fc_del_nvme_ctrl?

I think you're right.


>> +/*
>> + * called by the nvme core layer, for sysfs interface that requests
>> + * a reset of the nvme controller
>> + */
>> +static int
>> +nvme_fc_reset_nvme_ctrl(struct nvme_ctrl *nctrl)
>> +{
>> +    struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
>> +
>> +    dev_warn(ctrl->ctrl.device,
>> +        "NVME-FC{%d}: admin requested controller reset\n", ctrl->cnum);
>
> Isn't this warn to chatty?

I don't think so. Resets are a lot like scsi device/target/host resets. 
They are destructive enough to link-side io and transactions on the link 
that you want to know when occur. You also want to know why they 
occurred. I think it's significant to know that a reset was induced by 
an admin request, not a transport-detected event. Admin requests should 
be rare so this shouldn't be an issue.

-- james
