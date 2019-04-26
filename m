From: hare@suse.de (Hannes Reinecke)
Date: Fri, 26 Apr 2019 16:19:04 +0200
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <f0e112f7-0db5-4928-0859-8b3b6b797432@grimberg.me>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>
 <e7423c76-6425-4020-2074-b977fc87866f@grimberg.me>
 <d1742744-1109-e7e8-3586-fca6556c803b@broadcom.com>
 <d7bbfc2a-92ea-315d-bbd6-cd3847449f7b@grimberg.me>
 <3b524b54-8f13-24f5-4367-34a4d02c59b3@broadcom.com>
 <5c64286b-3fbf-9dfe-ef8a-3f72e630f11d@broadcom.com>
 <a4f8ca74-7777-9e80-3209-ef9ce27ad2d8@suse.de>
 <44f637f2-0c0d-cef4-05b3-c5e67ec907bb@grimberg.me>
 <f0e112f7-0db5-4928-0859-8b3b6b797432@grimberg.me>
Message-ID: <9d0e3080-baa7-6f55-2548-097523bb3a83@suse.de>

On 4/25/19 9:10 PM, Sagi Grimberg wrote:
> 
>>> I do have some quite fundamental problem with discovery log change 
>>> events:
>>> - The initial discovery is still unsolved, ie we have to know the 
>>> transport address before we can even get to those events
>>
>> I understand your concern, but its completely irrelevant to this.
>> This is a building block to automate the entire sequence, but
>> the fact that we don't have it all automated doesn't mean we should
>> not support discovery log change AENs.
>>
>> For root discovery automation, we can talk about bringing a tpar
>> with a prototype.
>>
>>> - More crucially, we don't get these events when we to the first 
>>> connection, requiring us to have the initial call to 'connect-all' on 
>>> a separate way.
>>
>> Again, this is initial root discovery, which is irrelevant to discovery
>> log change events.
>>
>>> - We don't have any indication if a new subsystem has been created; 
>>> once a subsystem a new subsystem on another port is created it's 
>>> anyones guess if that'll show up on the particular discovery controller
>>
>> What? the event is on the port level, every port/subsystem softlink will
>> trigger a discovery log change event. Its not anyones guess, its pretty
>> deterministic given that you have discovery controller connected to the
>> port.
>>
>>> Especially the second point is most vexing; we could get around this 
>>> by requiring the discovery controller to send AENs on the initial 
>>> connect
>>> (well, actually as soon as the AENs are enabled), but I guess that'll 
>>> require a change to the spec ...
>>
>> Why? with a script to auto-connect or root discovery automation this 
>> is no longer an issue (not sure how much this is an issue right now).
> 
> Reviving this (again).
> 
> Hannes, did you have a chance to look at this? Unless there are other
> alternatives I suggest we go with this approach.
> 
> We should be able to support discovery log change events automatically
> at some point...

Yes, I did.
And had several discussions with the involved parties (Hello, James :-).
Consensus was that for FC we don't really need discovery AENs, as the 
transport has knowledge about the fabric and the attached ports, and 
will generate events on any topology change already.
For RDMA and TCP, OTOH, we don't know the topology, and to be able to 
discovery we will know the fabric ports in advance.
So there automatic discovery is a real win, and arguably necessary if a 
connection needs to be re-established after a fabric outage.

Implementation-wise I'm not thoroughly happy with the MDNS approach, as 
this requires quite a bit of additional infrastructure which needs to be 
present on both sides.
And my worry is that during failover scenarios we might not be able to 
run these services at all (seeing that the root-fs is blocked).
But if that is acceptable (read: if booting from those NVMe devices is 
not required) then I guess we could go that way.

At least it's worth a shot, to get things started here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
