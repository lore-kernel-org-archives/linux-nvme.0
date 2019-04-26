From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 26 Apr 2019 08:46:41 -0700
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <9d0e3080-baa7-6f55-2548-097523bb3a83@suse.de>
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
 <9d0e3080-baa7-6f55-2548-097523bb3a83@suse.de>
Message-ID: <03163041-9b14-3662-edb8-1d69f20f681f@grimberg.me>


>> Reviving this (again).
>>
>> Hannes, did you have a chance to look at this? Unless there are other
>> alternatives I suggest we go with this approach.
>>
>> We should be able to support discovery log change events automatically
>> at some point...
> 
> Yes, I did.
> And had several discussions with the involved parties (Hello, James :-).
> Consensus was that for FC we don't really need discovery AENs, as the 
> transport has knowledge about the fabric and the attached ports, and 
> will generate events on any topology change already.
> For RDMA and TCP, OTOH, we don't know the topology, and to be able to 
> discovery we will know the fabric ports in advance.
> So there automatic discovery is a real win, and arguably necessary if a 
> connection needs to be re-established after a fabric outage.

Again, this is a different thing Hannes, please stop mixing stuff.
I'm not arguing with you that we want automatically discover the fabric,
but discovery change log events and root discovery are different things
and only one of them is up for discussion here.

> Implementation-wise I'm not thoroughly happy with the MDNS approach, as 
> this requires quite a bit of additional infrastructure which needs to be 
> present on both sides.
> And my worry is that during failover scenarios we might not be able to 
> run these services at all (seeing that the root-fs is blocked).
> But if that is acceptable (read: if booting from those NVMe devices is 
> not required) then I guess we could go that way.
I'm going to ignore stuff about root discovery here (nothing personal,
its just not the subject here), we can talk about it in a separate
thread.

Now, I'm suggesting to support discovery change log events by allowing
the user to setup a persistent discovery controller and have the kernel
fire to userspace discovery change log events over that controller.

Any comments/feedback/alternatives on _this_?
