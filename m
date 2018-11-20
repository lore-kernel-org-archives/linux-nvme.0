From: hare@suse.de (Hannes Reinecke)
Date: Tue, 20 Nov 2018 07:12:47 +0100
Subject: [PATCHv3 0/3] nvme: NUMA locality for fabrics
In-Reply-To: <58a66fee-0185-6ab4-3fe1-797d15d9badb@grimberg.me>
References: <20181102095641.28504-1-hare@suse.de>
 <20181116081241.GA14072@lst.de>
 <c6b0e0f8-f22c-65b6-3657-1f078b0803e2@suse.de>
 <20181116082359.GB14269@lst.de>
 <58a66fee-0185-6ab4-3fe1-797d15d9badb@grimberg.me>
Message-ID: <cc741191-12f3-91b0-df93-b6239f482aeb@suse.de>

On 11/19/18 11:31 PM, Sagi Grimberg wrote:
> 
>>> If we can agree that we'll go for the round-robin scheduler I guess this
>>> patchset can be retracted (for now).
>>> There still might be some gain to be had, but it can be implemented 
>>> as an
>>> additional I/O policy.
>>
>> I don't think we can.? round-robin is fundamentally the wrong thing
>> to do as you keep touching different cache lines.? If a customer really
>> insists on round robin they are probably better off in a SCSI world..
> 
> While we often think that link aggregation is a thing of the past as
> adapters keep getting faster, I guess that in some cases it can buy us
> some benefits. Personally, as long as the round-robin policy stays ANA
> aware I don't see the harm in offering it.
> 
Fully agreed here.
It all comes down to the link latency.
If the link latency is the main bottleneck multipathing will benefit 
from round-robin (or any I/O scheduler, for that matter).
And this it not just relevant for 'legacy' hardware; I've seen a 
performance benefit on a 32G FC setup, which is pretty much state of the 
art currently.

> And I agree that its often the wrong thing to do, which is why we
> should never let it be the default policy.
> 
... Which is why I made it optional ...

> What I'm a bit struggling with is the implementation that is a bit
> cumbersome IMO with constant clearing of the current_path. In this
> policy there is no current_path really...

The 'current_path' setting serves neatly as a marker where to start the 
search for the next round.
When not setting it I would have had to introduce yet another variable; 
with this approach I can model it without having to add additional stuff.

Cheers,

Hannes
