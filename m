From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 8 Oct 2018 16:31:45 -0700
Subject: [PATCH 1/2] nvme: NUMA locality information for fabrics
In-Reply-To: <ecb5fa75-d0d6-5a35-b4cd-455505d50588@grimberg.me>
References: <20181005092915.126636-1-hare@suse.de>
 <20181005092915.126636-2-hare@suse.de> <20181008100423.GA6686@lst.de>
 <cffba6f0-3d8a-8596-ced1-ef6eea7195f5@bjorling.me>
 <162f2606-f5a5-cbe1-e4ff-4e409f430ff3@suse.com>
 <dc3821f1-6b2d-8723-d95d-269d332cb60f@bjorling.me>
 <ecb5fa75-d0d6-5a35-b4cd-455505d50588@grimberg.me>
Message-ID: <492526f3-38ef-f5d7-4f5a-52d4ffe9ae7e@grimberg.me>



On 10/08/2018 04:29 PM, Sagi Grimberg wrote:
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

Not to mention that the data buffers (which will dominate the
dma activity) will often be allocated with application locality.
