From: hare@suse.de (Hannes Reinecke)
Date: Wed, 31 Jul 2019 22:02:46 +0200
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <ef157a14-748b-08a1-b5e5-f5f9676988f7@grimberg.me>
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
Message-ID: <82c624fc-257d-66a9-90e6-792900f58b29@suse.de>

On 7/31/19 8:11 PM, Sagi Grimberg wrote:
> 
>>> You are correct, this was why I had the ctrl->state check after
>>> revalidate_disk so if it failed because we are in a reset we should
>>> not remove the namespace.
>>>
>>> We need a reliable way to NOT remove the namespace if revalidate_disk
>>> failed because the controller is resetting and we don't have a channel
>>> to the controller at this very moment...
>>>
>> A similar thing is true for the 'ns_head' structure; I could easily
>> envision a scenario where all paths are dropped (due to revalidate
>> failures or whatnot) with all controllers in reset.
> 
> Hannes, paths should not be dropped in controller resets, only when
> the controller is going away. Its simple as that.
> 
Fully agree. But so far we don't seem to be there yet.

>> But as all paths are dropped struct ns_head doesn't have any reference
>> to any namespaces (and consequently, to any controller), and will be
>> failing all I/O before itself being removed.
>> It will be re-created after resetting completes and all namespaces are
>> re-attached, for sure, but it still means that we're getting I/O errors
>> where we really shouldn't.
> 
> Paths should only be removed when the controller is going away, not when
> it is temporarily disconnected.

I'm fully in line with that.
However, it looks as if this isn't the case currently :-)
And whenever I try to come up with a solution here I always come back to 
the thought: It would've been easier if we just could flush scan_work ...

And my main worry here is: surely we'll manage to hash out the situation 
eventually, and fixup all code paths to avoid dropping paths during reset.
But the solution will be very fragile, as any innocent change there 
might break things again. So I'm not convinced that asynchronous reset 
and rescan is a feature which should be kept.
(And honestly, we're working towards a solution where scanning during 
reset will become a no-op ...)

But anyway, prime objective is to get this mess fixed :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
