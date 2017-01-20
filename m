From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 20 Jan 2017 10:07:42 -0800
Subject: [PATCH v2 2/2] nvme: Enable autonomous power state transitions
In-Reply-To: <20170120103030.GB23149@lst.de>
References: <cover.1484855622.git.luto@kernel.org>
 <9b150934a9d756f69ca241199af512925a4050ec.1484855622.git.luto@kernel.org>
 <20170120103030.GB23149@lst.de>
Message-ID: <CALCETrUdRHZ35FfAjN3mOjcLA4XawQbw2E7sZxe5stjJNH+0vA@mail.gmail.com>

On Fri, Jan 20, 2017@2:30 AM, Christoph Hellwig <hch@lst.de> wrote:
>
>> +static void nvme_set_latency_tolerance(struct device *dev, s32 val)
>> +{
>> +     struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +
>> +     u64 latency;
>> +
>> +     if (val == PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT ||
>> +         val == PM_QOS_LATENCY_ANY)
>> +             latency = U64_MAX;
>> +     else
>> +             latency = val;
>
> In addition to the latency vs val mixup pointed out earlier -
> can you use a switch statement here to make the code a little
> more obvious?

Sure.

>
>> +     if (ctrl->ps_max_latency_us != val) {
>> +             ctrl->ps_max_latency_us = val;
>> +             nvme_configure_apst(ctrl);
>> +     }
>> +}
>> +
>
>>       ctrl->identified = true;
>
> The ->identified field seems to never be checked anywhere.
>

See the previous patch:

+       if (!ctrl->identified) {


>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 7103bce4ba4f..1c3e170da6de 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1791,6 +1791,8 @@ static void nvme_reset_work(struct work_struct *work)
>>       if (result)
>>               goto out;
>>
>> +     nvme_configure_apst(&dev->ctrl);
>> +
>>       /*
>>        * A controller that can not execute IO typically requires user
>>        * intervention to correct. For such degraded controllers, the driver
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 557f29b1f1bb..a64b5db96fd8 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1629,6 +1629,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
>>
>>       nvme_start_keep_alive(&ctrl->ctrl);
>>
>> +     nvme_configure_apst(&ctrl->ctrl);
>> +
>
> Is there a specific reason for the exact placement of these calls here
> and not at inside nvme_init_identify?  Having all the code called
> from an existing core function would make things a lot easier in the
> future.  And if that's not possible we'll probably need comments
> on why it's placed like it is.

In the original version I had this in nvme_init_identify().  I moved
it later just in case there was a buggy device that didn't like having
APST flipped on before the queue setup was done.  I could easily move
it back to nvme_init_identify() or add a new nvme_finish_setup() or
similar.  Any preference?

--Andy
