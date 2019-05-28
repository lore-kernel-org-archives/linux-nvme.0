From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 28 May 2019 14:50:32 +0300
Subject: [PATCH 1/1] nvme-rdma: Add association between ctrl and transport
 dev
In-Reply-To: <724732d9-2ea2-e349-435b-ae664692b565@grimberg.me>
References: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
 <da6603ee-4a71-e057-5c88-656455956eba@grimberg.me>
 <ceb1744a-cc68-9588-bd07-d3060630e857@mellanox.com>
 <724732d9-2ea2-e349-435b-ae664692b565@grimberg.me>
Message-ID: <77b99fb1-8996-52bf-1e6f-f2fee9216a2e@mellanox.com>


On 5/25/2019 2:05 AM, Sagi Grimberg wrote:
>
>>> Do you actually need the extra reference on the device? why doesn't 
>>> just
>>> the set/clear of ctrl->device sufficient? these routines should be
>>> serialized..
>>
>> Yes we need this reference since the queues are freed during 
>> reconnection. And without ctrl reference, also the device will be freed.
>
> The device should be freed shouldn't it? I thought that this was the
> purpose of the ref removal from the tagset (which is identical to what
> you are trying to replace). I'm not clear on what this is solving that
> the prior reference didn't have?

Prior reference was per tagset and not per controller.


>
>> And when you disconnect during reconnection, the block layer will 
>> call exit_request for each request (but the device is freed) and we 
>> will do the need unmapping from the device..
>>
>> Not so plesent..
>
> Which again is why we had the tagset reference in the first place. I
> thought you wanted to remove the device reference altogether because
> of your bonding use-case..

we remove it in de-configutration state.


>
> I'm getting the feeling that we need to map the qe's in queue_rq
> and unmap in complete_rq. I don't see any other way around it because
> on the bonding use-case we need to wipe out all of the device related
> resources because we need to have it teardown and be prepared to get
> a different device on the next (re)connect.

Yes, thought using block layer iter but in case it won't hurt 
performance I'll do it in queue_rq/complete_rq.

Let me check that...

-Max.
