From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 31 Jul 2019 11:08:53 -0700
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <0d1ab1b6-220e-aa25-465a-5d9d0a01b920@suse.de>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-2-sagi@grimberg.me>
 <CACVXFVM+WGwQeqiK-poVKoQR4hVxCMWu0n0-HdVGb8EDDCySSA@mail.gmail.com>
 <464bb489-552f-b67e-545d-48616a1e76dd@grimberg.me>
 <CACVXFVO+e5De4+o8cqzvaVbMU22geicCbpmfk6zZStykEiDVmw@mail.gmail.com>
 <82a91815-f7ed-5931-58ac-5893e68cc940@grimberg.me>
 <CACVXFVN6o+dOFwDV=FPSHjVnhYSLBUWNHsXc4B=fwE5PAny_dQ@mail.gmail.com>
 <8bd6d219-f4fd-de58-a341-257c6274eddd@grimberg.me>
 <CACVXFVNT5sjk4MC6qJoBFug8K9YgEFQEy6LSknJT6=O-2ispMg@mail.gmail.com>
 <2825eb74-1df5-5dd2-3e90-c696bc7fa3d1@grimberg.me>
 <20190730173048.GC13948@localhost.localdomain>
 <f6ef7bfc-0d7c-95e6-21d3-b69545a1715b@grimberg.me>
 <0d1ab1b6-220e-aa25-465a-5d9d0a01b920@suse.de>
Message-ID: <68a718a4-0cb5-6d3d-ec48-cc6350b0264f@grimberg.me>


>>>> Keith,
>>>>
>>>> As for the failure during reset scenario, this is happening only when
>>>> the namespace is about to go away or something is seriously wrong right
>>>> (looking from where nvme_kill_queues is called).
>>>>
>>>> Do you still think we should avoid calling the revalidate_disk if the
>>>> controller is resetting?
>>>
>>> I was considering if a reset happens to trigger when nvme's
>>> revalidate_disk tries to read identify namespace. It's possible that
>>> command gets aborted, and we don't retry admin commands, so we'd return
>>> -ENODEV and nvme_validate_ns() removes an otherwise healthy namespace.
>>
>> But if the ctrl->state condition is after the revalidate_disk call it
>> won't remove the namespace.
>> -- 
>>  ??????????????? if (ns->disk && revalidate_disk(ns->disk &&
>>  ??????????????????? ctrl->state == NVME_CTRL_LIVE)
>>  ??????????????????????? nvme_ns_remove(ns);
>> -- 
>>
>>>
>>> I'm not too concerned about this corner case actually occuring in
>>> practice, though.
>>
>> Say, why are we removing the namepsace if the revalidate failed?
>> Don't see an equivalent behavior in scsi or others in drivers/block..
> 
> That probably due to the convoluted logic in nvme_scan_ns_list().
> That scans all namespaces in the list, and removes those which fails.
> Which seems sensible, but really shouldn't be called during reset
> as we cannot get any sensible results for any of those calls.
> 
> This was the reason for my original patch to flush the scanning thread
> before entering reset. Maybe we should revive it...

I stand firm that controller resets should not attempt to flush
the scan_work with some hooks to try to make it bail out early. I just
don't think its the correct solution. Note that the scan flush existed
in the reset flow before (nvme_stop_ctrl) but moved away because it
caused issues before and probably will again if its restored.

When the controller resets, I/Os fail (fast-fail or block), the model is 
fine in my mind, but needs some hashing out to be more aware of that.
