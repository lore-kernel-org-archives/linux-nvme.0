From: luto@kernel.org (Andy Lutomirski)
Date: Sat, 24 Jun 2017 09:25:19 -0700
Subject: [PATCH] nvme: explicitly disable APST on quirked devices
In-Reply-To: <CAAd53p7xyEOU35S7QshC4eqg9FeJW+GmncQS=zGfzYC98DshZQ@mail.gmail.com>
References: <20170623061942.5225-1-kai.heng.feng@canonical.com>
 <CALCETrV6HTiJ6E9dPKBZB2dykouqM0J5At_gQ3WC_itySnsiiA@mail.gmail.com>
 <CAAd53p7xyEOU35S7QshC4eqg9FeJW+GmncQS=zGfzYC98DshZQ@mail.gmail.com>
Message-ID: <CALCETrWM3LcJbeEbRBLh7ojZgpt8w8mWd67PDXq--fAzMAYWBw@mail.gmail.com>

On Sat, Jun 24, 2017 at 12:47 AM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> On Sat, Jun 24, 2017@1:17 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> On Thu, Jun 22, 2017 at 11:19 PM, Kai-Heng Feng
>> <kai.heng.feng@canonical.com> wrote:
>>> A user reports APST is enabled, even when the NVMe is quirked or with
>>> option "default_ps_max_latency_us=0".
>>>
>>> The current logic will not set APST if the device is quirked. But the
>>> NVMe in question will enable APST automatically.
>>>
>>> Separate the logic "apst is supported" and "to enable apst", so we can
>>> use the latter one to explicitly disable APST at initialiaztion.
>>>
>>> BugLink: https://bugs.launchpad.net/bugs/1699004
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng at canonical.com>
>>> ---
>>>  drivers/nvme/host/core.c | 25 +++++++++++++++++--------
>>>  drivers/nvme/host/nvme.h |  1 +
>>>  2 files changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 0ddd6b9af7fc..c459d15d18f5 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -1477,6 +1477,14 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
>>>         if (!ctrl->apsta)
>>>                 return;
>>>
>>> +       if (!ctrl->apst_enabled) {
>>> +               if (ctrl->state == NVME_CTRL_NEW ||
>>> +                   ctrl->state == NVME_CTRL_RESETTING)
>>> +                       dev_info(ctrl->device, "Disable APST at initialization\n");
>>> +               else
>>> +                       return;
>>> +       }
>>> +
>>
>> Is this change really necessary?  ISTM that, if we want to optimize
>> the case where we're not changing anything, we should do it more
>> generally.
>
> Do you mean combining the check on ctrl->apsta and ctrl->apst_enabled
> if we do nothing and just want to return?

No, I mean just not adding that code.  Isn't the intended behavior that:

 - !apsta: do nothing
 - apsta && !apst_enabled: do the set_feature call to turn off APST
 - apsta && apst_enabled: do what the max_latency says to do

The block of code you're adding adds a dev_info() that seems to be
unnecessary and skips re-disabling APST when not in NVME_CTRL_NEW or
NVME_CTRL_RESETTING, which also seems unnecessary.

>>>         } else {
>>> -               ctrl->apsta = id->apsta;
>>> +               ctrl->apst_enabled = true;
>>
>> Shouldn't this be ctrl->apst_enabled = id->apsta?
>>
>> The way you have it could cause us to do the wrong thing if id->apsta
>> somehow changes between identifications.
>
> You are right. It should be initialized with id->apsta.
>
> I am curious though, when does NVMe do multiple identifications?

Suspend/resume, I think, and probably at other times.

>
>>
>>
>>>         memcpy(ctrl->psd, id->psd, sizeof(ctrl->psd));
>>>
>>> @@ -1760,9 +1769,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>>>
>>>         kfree(id);
>>>
>>> -       if (ctrl->apsta && !prev_apsta)
>>> +       if (ctrl->apst_enabled && !prev_apst_enabled)
>>>                 dev_pm_qos_expose_latency_tolerance(ctrl->device);
>>> -       else if (!ctrl->apsta && prev_apsta)
>>> +       else if (!ctrl->apst_enabled && prev_apst_enabled)
>>>                 dev_pm_qos_hide_latency_tolerance(ctrl->device);
>>
>> This is also wrong unless you make the change above, I think.
>
> Thanks, I'll address these issues on later version.

Thanks.
