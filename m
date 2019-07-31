From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 31 Jul 2019 13:16:56 -0700
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <82c624fc-257d-66a9-90e6-792900f58b29@suse.de>
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
 <0e103ae2-b0b5-28e5-bfea-35d8f683809a@suse.de>
 <ef157a14-748b-08a1-b5e5-f5f9676988f7@grimberg.me>
 <82c624fc-257d-66a9-90e6-792900f58b29@suse.de>
Message-ID: <f9458a91-b3e6-55ce-e9dc-29f5bf6601d2@grimberg.me>


> Fully agree. But so far we don't seem to be there yet.

Right.

>>> But as all paths are dropped struct ns_head doesn't have any reference
>>> to any namespaces (and consequently, to any controller), and will be
>>> failing all I/O before itself being removed.
>>> It will be re-created after resetting completes and all namespaces are
>>> re-attached, for sure, but it still means that we're getting I/O errors
>>> where we really shouldn't.
>>
>> Paths should only be removed when the controller is going away, not when
>> it is temporarily disconnected.
> 
> I'm fully in line with that.
> However, it looks as if this isn't the case currently :-)
> And whenever I try to come up with a solution here I always come back to 
> the thought: It would've been easier if we just could flush scan_work ...
> 
> And my main worry here is: surely we'll manage to hash out the situation 
> eventually, and fixup all code paths to avoid dropping paths during reset.
> But the solution will be very fragile, as any innocent change there 
> might break things again. So I'm not convinced that asynchronous reset 
> and rescan is a feature which should be kept.
> (And honestly, we're working towards a solution where scanning during 
> reset will become a no-op ...)

But flushing the scan_work is even more fragile.. the scan_work is a
non-trivial work that may have dependencies with other processes.

For example, passthru commands with effects take the scan lock during
its lifetime, which means that it may be blocked even before it checks
the ctrl state (which is again, unreliable with respect to resets).
So do resets flush all outstanding passthru commands now?

So I think that flushing the scan_work might bring us new issues because
of this dependency. That is why I think we should address the root cause
which is we're wrongly removing the namespace, not the fact that we
failed to scan it.
