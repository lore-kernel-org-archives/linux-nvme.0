From: hare@suse.de (Hannes Reinecke)
Date: Tue, 9 Oct 2018 08:14:03 +0200
Subject: [PATCH 1/2] nvme: NUMA locality information for fabrics
In-Reply-To: <ecb5fa75-d0d6-5a35-b4cd-455505d50588@grimberg.me>
References: <20181005092915.126636-1-hare@suse.de>
 <20181005092915.126636-2-hare@suse.de> <20181008100423.GA6686@lst.de>
 <cffba6f0-3d8a-8596-ced1-ef6eea7195f5@bjorling.me>
 <162f2606-f5a5-cbe1-e4ff-4e409f430ff3@suse.com>
 <dc3821f1-6b2d-8723-d95d-269d332cb60f@bjorling.me>
 <ecb5fa75-d0d6-5a35-b4cd-455505d50588@grimberg.me>
Message-ID: <951b95d4-5de5-133e-2986-75b1237d9c6e@suse.de>

On 10/9/18 1:29 AM, Sagi Grimberg wrote:
> 
>>>> Back in the days it was carried over to make sure the structures was 
>>>> allocated from the same node as the pcie device.
>>>>
>>> Which really is what this patch is trying to do.
>>> Or am I wrong?
>>>
>>
>> Yep. It was missing for fabrics.
> 
> Its not a trivial trade-off what should the memory be local
> to. Device locality will not necessarily result in better
> performance than application locality.
> 
> For example if you run X threads all on the far node (from
> the device) it would be very costly if all memory
> accesses should cross the QPI bus...

Oh, yes. I fully concur.
But this patchset is trying to establish an _optimal_ path for I/O, ie 
ensure that I/O originating on that node where the HBA is local to will 
be handled optimally.
I/O _not_ originating on that node might suffer a performance penalty, yes.

And I'm somewhat at a loss how we can achieve application locality here; 
the only place where we _can_ influence locality is when creating the 
queue, and that typically is done via nvme-cli.
So any application would need to be tweaked to run on the same node 
where the nvme-cli program has been run; but as we need to tweak the 
application anyway we can as well look at the 'node' attribute for the 
queue and use that for tweaking.
So I somewhat fail to see your point ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
