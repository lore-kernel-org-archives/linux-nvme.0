From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jul 2019 18:04:59 -0700
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <CAOSXXT6kG36vCf7wj8aJG+9fARYP9y+SB8TogfKuc+g20S_TYg@mail.gmail.com>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-2-sagi@grimberg.me>
 <CAOSXXT6kG36vCf7wj8aJG+9fARYP9y+SB8TogfKuc+g20S_TYg@mail.gmail.com>
Message-ID: <03c489af-1ac7-047f-b4ca-f3b8749b72ea@grimberg.me>


>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index fa31da0762b9..5f6970e7ba73 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3428,7 +3428,8 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>
>>          ns = nvme_find_get_ns(ctrl, nsid);
>>          if (ns) {
>> -               if (ns->disk && revalidate_disk(ns->disk))
>> +               if (ns->disk && revalidate_disk(ns->disk) &&
>> +                   ctrl->state != NVME_CTRL_LIVE)
>>                          nvme_ns_remove(ns);
> 
> That should be '== NVME_CTRL_LIVE', right? You don't want to remove it
> for the resetting state, and the removing states take care of removal
> directly.

rrr... you're right...

> On the RESETTING state, shouldn't we avoid calling revalidate_disk()
> in the first place? An intermittent failure during reset could cause
> the disk to temporarily go to a zero-capacity, which may cause some
> filesystem issues that we could avoid if we know we're about to rescan
> this namespace.

Yea, this should do the trick I guess:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa31da0762b9..d01976c93160 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3428,7 +3428,8 @@ static void nvme_validate_ns(struct nvme_ctrl 
*ctrl, unsigned nsid)

         ns = nvme_find_get_ns(ctrl, nsid);
         if (ns) {
-               if (ns->disk && revalidate_disk(ns->disk))
+               if (ns->disk && ctrl->state == NVME_CTRL_LIVE &&
+                   revalidate_disk(ns->disk)
                         nvme_ns_remove(ns);
                 nvme_put_ns(ns);
         } else
--
