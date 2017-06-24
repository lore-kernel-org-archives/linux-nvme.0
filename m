From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Sat, 24 Jun 2017 15:47:01 +0800
Subject: [PATCH] nvme: explicitly disable APST on quirked devices
In-Reply-To: <CALCETrV6HTiJ6E9dPKBZB2dykouqM0J5At_gQ3WC_itySnsiiA@mail.gmail.com>
References: <20170623061942.5225-1-kai.heng.feng@canonical.com>
 <CALCETrV6HTiJ6E9dPKBZB2dykouqM0J5At_gQ3WC_itySnsiiA@mail.gmail.com>
Message-ID: <CAAd53p7xyEOU35S7QshC4eqg9FeJW+GmncQS=zGfzYC98DshZQ@mail.gmail.com>

On Sat, Jun 24, 2017@1:17 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Jun 22, 2017 at 11:19 PM, Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> A user reports APST is enabled, even when the NVMe is quirked or with
>> option "default_ps_max_latency_us=0".
>>
>> The current logic will not set APST if the device is quirked. But the
>> NVMe in question will enable APST automatically.
>>
>> Separate the logic "apst is supported" and "to enable apst", so we can
>> use the latter one to explicitly disable APST at initialiaztion.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1699004
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng at canonical.com>
>> ---
>>  drivers/nvme/host/core.c | 25 +++++++++++++++++--------
>>  drivers/nvme/host/nvme.h |  1 +
>>  2 files changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0ddd6b9af7fc..c459d15d18f5 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1477,6 +1477,14 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
>>         if (!ctrl->apsta)
>>                 return;
>>
>> +       if (!ctrl->apst_enabled) {
>> +               if (ctrl->state == NVME_CTRL_NEW ||
>> +                   ctrl->state == NVME_CTRL_RESETTING)
>> +                       dev_info(ctrl->device, "Disable APST at initialization\n");
>> +               else
>> +                       return;
>> +       }
>> +
>
> Is this change really necessary?  ISTM that, if we want to optimize
> the case where we're not changing anything, we should do it more
> generally.

Do you mean combining the check on ctrl->apsta and ctrl->apst_enabled
if we do nothing and just want to return?

>
>>         if (ctrl->npss > 31) {
>>                 dev_warn(ctrl->device, "NPSS is invalid; not using APST\n");
>>                 return;
>> @@ -1486,7 +1494,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
>>         if (!table)
>>                 return;
>>
>> -       if (ctrl->ps_max_latency_us == 0) {
>> +       if (ctrl->ps_max_latency_us == 0 || !ctrl->apst_enabled) {
>>                 /* Turn off APST. */
>>                 apste = 0;
>>                 dev_dbg(ctrl->device, "APST disabled\n");
>> @@ -1653,7 +1661,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>>         u64 cap;
>>         int ret, page_shift;
>>         u32 max_hw_sectors;
>> -       u8 prev_apsta;
>> +       bool prev_apst_enabled;
>>
>>         ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
>>         if (ret) {
>> @@ -1721,16 +1729,17 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>>         ctrl->kas = le16_to_cpu(id->kas);
>>
>>         ctrl->npss = id->npss;
>> -       prev_apsta = ctrl->apsta;
>> +       ctrl->apsta = id->apsta;
>
> So ctrl->apsta now means, literally, is APSTA set in the features.
> This seems good.
>
>> +       prev_apst_enabled = ctrl->apst_enabled;
>>         if (ctrl->quirks & NVME_QUIRK_NO_APST) {
>>                 if (force_apst && id->apsta) {
>>                         dev_warn(ctrl->device, "forcibly allowing APST due to nvme_core.force_apst -- use at your own risk\n");
>> -                       ctrl->apsta = 1;
>> +                       ctrl->apst_enabled = true;
>>                 } else {
>> -                       ctrl->apsta = 0;
>> +                       ctrl->apst_enabled = false;
>>                 }
>>         } else {
>> -               ctrl->apsta = id->apsta;
>> +               ctrl->apst_enabled = true;
>
> Shouldn't this be ctrl->apst_enabled = id->apsta?
>
> The way you have it could cause us to do the wrong thing if id->apsta
> somehow changes between identifications.

You are right. It should be initialized with id->apsta.

I am curious though, when does NVMe do multiple identifications?

>
>
>>         memcpy(ctrl->psd, id->psd, sizeof(ctrl->psd));
>>
>> @@ -1760,9 +1769,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>>
>>         kfree(id);
>>
>> -       if (ctrl->apsta && !prev_apsta)
>> +       if (ctrl->apst_enabled && !prev_apst_enabled)
>>                 dev_pm_qos_expose_latency_tolerance(ctrl->device);
>> -       else if (!ctrl->apsta && prev_apsta)
>> +       else if (!ctrl->apst_enabled && prev_apst_enabled)
>>                 dev_pm_qos_hide_latency_tolerance(ctrl->device);
>
> This is also wrong unless you make the change above, I think.

Thanks, I'll address these issues on later version.

>
> --Andy
