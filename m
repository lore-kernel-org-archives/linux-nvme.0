From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 31 Jul 2019 11:03:41 -0700
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <61445d6f-f4ca-f8d4-cef2-5bfe40aa1e7f@suse.de>
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
 <61445d6f-f4ca-f8d4-cef2-5bfe40aa1e7f@suse.de>
Message-ID: <2f7535ab-3d45-b24d-1512-a937e16e620f@grimberg.me>


>> I was considering if a reset happens to trigger when nvme's
>> revalidate_disk tries to read identify namespace. It's possible that
>> command gets aborted, and we don't retry admin commands, so we'd return
>> -ENODEV and nvme_validate_ns() removes an otherwise healthy namespace.
>>
>> I'm not too concerned about this corner case actually occuring in
>> practice, though.
>>
> ... discarding those poor folks having to hunt down this very same issue
> for several months now ...
> 
> Yes, it _does_ occur.
> Not on PCI, mind, but definitely for FC. RDMA might have a slightly
> better chance of not hitting it, but even there we have seen it.

And this patch prevents from the namespaces being removed, which _is_
the wrong behavior we need to prevent. As I said, we should not
remove that namespace instead of trying to synchronize the remove
with everything else...

I think I asked this but was not answered, why are we removing
the namespace at all? do others do the same thing (remove the
disk if revalidation fails)?
