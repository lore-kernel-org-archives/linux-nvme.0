From: hare@suse.de (Hannes Reinecke)
Date: Wed, 6 Dec 2017 08:11:25 +0100
Subject: [PATCH] nvme-fc: Implement async-connect option
In-Reply-To: <363cfdca-be70-ab28-e241-c835d18c588f@broadcom.com>
References: <1512461082-41520-1-git-send-email-hare@suse.de>
 <363cfdca-be70-ab28-e241-c835d18c588f@broadcom.com>
Message-ID: <ca87766f-b9b0-3894-aa37-a2a93cd4ec74@suse.de>

On 12/05/2017 08:41 PM, James Smart wrote:
> On 12/5/2017 12:04 AM, Hannes Reinecke wrote:
>> By opening the control fd with O_NONBLOCK the fabrics module will
>> attempt an async connect if implemented.
>> This is especially useful when calling 'nvme connect' from an udev
>> rule, as there each program should return as fast as possible to
>> avoid an udev event processing stall.
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>>
> 
> This seems odd.?? I would have thought any async connect option would
> have been isolated in the fabrics.c file and applicable to any transport.
> 
Possibly.

> I can understand why this works as fc is well suited for this division
> (allocates ctrl 1st, then makes 1st connection in same style as
> reconnects). But the other transports aren't structure the same way so
> they're going to be a bit more trouble.
> 
That was actually my plan; I actually looking into making the
connect/reconnect workqueue function the default, and drop the
distinction between 1st connect and reconnect.
With that the only difference between 'async' and normal connect would
be the delay when scheduling the workqueue item.

But RDMA turned out to be a bit more complex, so I did this patch first
to gauge response.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
