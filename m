From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Jul 2019 10:12:42 -0700
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <CACVXFVNT5sjk4MC6qJoBFug8K9YgEFQEy6LSknJT6=O-2ispMg@mail.gmail.com>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-2-sagi@grimberg.me>
 <CACVXFVM+WGwQeqiK-poVKoQR4hVxCMWu0n0-HdVGb8EDDCySSA@mail.gmail.com>
 <464bb489-552f-b67e-545d-48616a1e76dd@grimberg.me>
 <CACVXFVO+e5De4+o8cqzvaVbMU22geicCbpmfk6zZStykEiDVmw@mail.gmail.com>
 <82a91815-f7ed-5931-58ac-5893e68cc940@grimberg.me>
 <CACVXFVN6o+dOFwDV=FPSHjVnhYSLBUWNHsXc4B=fwE5PAny_dQ@mail.gmail.com>
 <8bd6d219-f4fd-de58-a341-257c6274eddd@grimberg.me>
 <CACVXFVNT5sjk4MC6qJoBFug8K9YgEFQEy6LSknJT6=O-2ispMg@mail.gmail.com>
Message-ID: <2825eb74-1df5-5dd2-3e90-c696bc7fa3d1@grimberg.me>


>> Yes, and again, addresses the case that the namespace is going away.
>>
>> So I think we are in agreement? I only need to change the commit
>> message from: "the revalidation I/O" to "the admin I/O" ?
> 
> That words of 'admin I/O' isn't related with the patch or issue.

But it is, the original issue was due to the fact that
nvme_revalidate_disk() I/Os such as nvme_identify_ns() or
nvme_identify_ns_descs(). This was the original issue.

>> Yea, this should do the trick I guess:
>> --
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index fa31da0762b9..d01976c93160 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3428,7 +3428,8 @@ static void nvme_validate_ns(struct nvme_ctrl
>> *ctrl, unsigned nsid)
>>
>>           ns = nvme_find_get_ns(ctrl, nsid);
>>           if (ns) {
>> -               if (ns->disk && revalidate_disk(ns->disk))
>> +               if (ns->disk && ctrl->state == NVME_CTRL_LIVE &&
>> +                   revalidate_disk(ns->disk)
>>                           nvme_ns_remove(ns);
>>                   nvme_put_ns(ns);
>>           } else
> 
> If RESET is triggered just inside revalidate_disk(), and not done after
> revalidate_disk() returns,  there is still race between reset and scan work.
> 

You are correct, this was why I had the ctrl->state check after
revalidate_disk so if it failed because we are in a reset we should
not remove the namespace.

We need a reliable way to NOT remove the namespace if revalidate_disk
failed because the controller is resetting and we don't have a channel
to the controller at this very moment...

Keith,

As for the failure during reset scenario, this is happening only when
the namespace is about to go away or something is seriously wrong right
(looking from where nvme_kill_queues is called).

Do you still think we should avoid calling the revalidate_disk if the
controller is resetting?
