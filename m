From: luto@amacapital.net (Andy Lutomirski)
Date: Thu, 19 Jan 2017 21:17:09 -0800
Subject: [PATCH v2 2/2] nvme: Enable autonomous power state transitions
In-Reply-To: <20170119201530.GA31954@localhost.localdomain>
References: <cover.1484855622.git.luto@kernel.org>
 <9b150934a9d756f69ca241199af512925a4050ec.1484855622.git.luto@kernel.org>
 <20170119201530.GA31954@localhost.localdomain>
Message-ID: <CALCETrUaHmvrSrDHL5ysri+dXZq8iqGWzJdusVxPMxdsuieZhQ@mail.gmail.com>

On Thu, Jan 19, 2017@12:15 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Thu, Jan 19, 2017@11:55:44AM -0800, Andy Lutomirski wrote:
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
>> +
>> +     if (ctrl->ps_max_latency_us != val) {
>> +             ctrl->ps_max_latency_us = val;
>
> Did you mean to use 'latency' here instead of 'val'? Otherwise, I don't
> see why the latency variable exists.

D'oh!  I'm a bit surprised the compiler didn't warn.

As a practical matter, this probably had no effect in my testing
because the two magic values would have ended up being rather large
s32 values, so the effect would be the same.  v3 coming, though.
