From: xuehua@gmail.com (Xuehua Chen)
Date: Sun, 18 May 2014 16:58:16 -0700
Subject: A small concern on driver loading and unloading
In-Reply-To: <CAOu78O1ty-S8KyaiMamZk4HgNiEQmU0sL8v8ky=O==d5OP8Evw@mail.gmail.com>
References: <CAOu78O3CJPyyzZECbbHYZtfLR8Qc99y=byMj6qg2KOp7xLj4gg@mail.gmail.com>
 <alpine.LRH.2.03.1405181200590.5666@AMR>
 <CAOu78O1ty-S8KyaiMamZk4HgNiEQmU0sL8v8ky=O==d5OP8Evw@mail.gmail.com>
Message-ID: <CAOu78O3nkHNnOYwTBO4XBrJXFRDKoEx7vmXg1UCHkDizRFMd1Q@mail.gmail.com>

Felt this is related to the understanding of the spec. We could think
of writing 00b
means no notification and no effect for the current write operation.
Or we could think
of writing 00b means notification status changed for the current write operation
and controller needs to do something.

Didn't see spec mentioned anywhere specifically that bits not changing
means no further
notification. If the controller took the former approach, the driver
could cause undesirable
behavior. Do you know any evidence in spec supporting the latter? If yes, could
you share that?

Thanks

On Sun, May 18, 2014@1:59 PM, Xuehua Chen <xuehua@gmail.com> wrote:
>>We write whatever the previous CC values were but without CC.EN, so it
>>should not trigger another shutdown on the device.
>
>> I'm not sure we want to do either of those. The comment in the driver
>> above "nvme_disable_ctrl" indicates that changing the shutdown bits
>> might cause undesired behavior when the controller is "enabled" and in
>> a ready state.
>
> It seems that controller behaved incorrectly and should be fixed if
> writing 00b to the
> field caused undesirable behavior.
>
> From spec, 01b means "Normal shutdown notification". The spec does not
> say if the
> bits not changed, 01b means no notification. Instead, spec says 00b means
> "no notification, no effect".
>
> So using 00b seems to be safer.
>
> Thanks,
>
>
>
> On Sun, May 18, 2014@11:08 AM, Keith Busch <keith.busch@intel.com> wrote:
>> On Fri, 16 May 2014, Xuehua Chen wrote:
>>>
>>> Noticed something strange about the driver unloading and loading and
>>> would like to ask a question here.
>>>
>>> when driver is unloaded, nvme_shutdown_ctrl is called by nvme_remove.
>>>
>>> cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK) | NVME_CC_SHN_NORMAL;
>>>       writel(cc, &dev->bar->cc);
>>>
>>> This set NVME_CC_SHN_NORMAL in CC.
>>>
>>> Then during driver loading,  nvme_disable_ctrl is called, which does this.
>>>
>>> u32 cc = readl(&dev->bar->cc);
>>>
>>> if (cc & NVME_CC_ENABLE)
>>>        writel(cc & ~NVME_CC_ENABLE, &dev->bar->cc);
>>>
>>>
>>> Checked the NVME spec 1.a  and didn't find it mention anywhere that
>>> controller will reset Shutdown Notification field after shutdown
>>> complete(please correct if this is incorrect). So the bits stay there.
>>
>>
>> That should be okay: we are about to clear the shutdown bits right after
>> controller reset completes and the CSTS.RDY bit is cleared.
>>
>>
>>> When loading the driver, the NVME_CC_SHN_NORMAL is written when
>>> disabling controller. This can be confusing. Why disabling the
>>> controller and do a shutdown at the same time.
>>
>>
>> We write whatever the previous CC values were but without CC.EN, so it
>> should not trigger another shutdown on the device.
>>
>>
>>> Maybe changing
>>> writel(cc & ~NVME_CC_ENABLE, &dev->bar->cc);
>>> to
>>> writel(cc & ~NVME_CC_ENABLE & ~NVME_CC_SHN_MASK , &dev->bar->cc);
>>> is safer.
>>>
>>> Also it seems that
>>> writel(0 , &dev->bar->cc);
>>
>>
>> I'm not sure we want to do either of those. The comment in the driver
>> above "nvme_disable_ctrl" indicates that changing the shutdown bits
>> might cause undesired behavior when the controller is "enabled" and in
>> a ready state.
>>
>>
>>> can be simpler and the effects are the same. Disabling controller
>>> reset controller registers including CC to default values. All fields
>>> of the CC will be gone any way.
