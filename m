From: james.smart@broadcom.com (James Smart)
Date: Tue, 4 Dec 2018 17:25:38 -0800
Subject: Whenever running nvme discover command, syslog shows warning
 messages
In-Reply-To: <BN6PR1301MB2001C46B2AA0738A52AEDD6885AF0@BN6PR1301MB2001.namprd13.prod.outlook.com>
References: <CY4PR1301MB2008564EA917C4FE4D63298585D20@CY4PR1301MB2008.namprd13.prod.outlook.com>
 <bdd5f3c7-8173-dd63-3a47-df87a9c2d14c@broadcom.com>
 <7a1a884d-5be0-064a-0865-51bca20ba919@grimberg.me>
 <CY4PR1301MB200823FB5DF08223456D9D1F85D30@CY4PR1301MB2008.namprd13.prod.outlook.com>
 <4fb9c4fc-e5ce-2238-fbcf-1fdd6da10e23@broadcom.com>
 <BN6PR1301MB2001C46B2AA0738A52AEDD6885AF0@BN6PR1301MB2001.namprd13.prod.outlook.com>
Message-ID: <965be77b-12d7-d637-66f9-79f94e3b12de@broadcom.com>



On 12/4/2018 2:27 PM, Ching-Chiao Chang wrote:
> Hi,
> It is not test case, we would like to run nvme discover in loop in an initiator, and whenever there is an NVMe volume can be attached, the the initiator can discover it and connect it automatically.
seems a little wasteful, but ok.? Sounds like we should make the logging 
be disabled, or maybe tunable.

>
> On the other hand, could I know why do the following logs shows when?running?nvme discover???what do the logs represent?
> sqsize 128 > ctrl maxcmd 1, clamping down
requested queue size (128) is bigger than what the device reports as max 
number of commands it can actually process at one time on the queue - so 
the transport is scaling back the size of the queue to be based on 
maxcmd (why have bigger queues if the slots can't be used).? It's a 
generic message for a new controller when the transport deviates from 
its requested or default behavior.

> new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.10.0.4:4420
a new association with a subsystem, creating a new controller, was 
created. the SUBNQN of the subsystem is the value in quotes, transport 
target address follows...??? This too is spit out generically. By 
looking at NQN, you can tell it's the well-known discovery controller 
nqn.? And there's only one reason a connection was created with a 
discovery controller - to download its discovery log, which is usually 
part of a "nvme connect-all" or a dump of the discovery log. If it's a 
connect-all, it'll usually be followed by a bunch of connect requests 
made to regular storage controllers seen in the log.? So the fact that 
someone is doing a connect-all to anything seen via the controller at 
that address is interesting, and knowing what discovery controller at 
what address drives what connect requests is also interesting. And if 
there's new associations kicked off, there may be other messages, such 
as a including duplicates (which typically aren't allowed through) or 
may be busy's (as the controller is still in the process of connecting 
when a new connect request was received).? Some of these can be errors, 
but others aren't, but it give you and idea of what is being attempted 
by the hints.? I've found it worthwhile to correlate these events vs 
udev events, and you would likely see the same vs your loop interval.

> Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
indicates someone initiated a delete on the indicates SUBNQN.? And since 
it's the discovery controller, its likely a hint that nvme cli 
terminated the association after reading the logs, and the nvme? 
instance number that was assigned to the controller could be reassigned 
to a regular storage controller (assuming timing of teardown vs new 
connect requests works out).?? It will point out long vs short lived 
discovery controllers.

-- james


>
> Thank you?very much.
>
>
>
> From: James Smart <james.smart at broadcom.com>
> Sent: Saturday, December 1, 2018 2:48 AM
> To: Ching-Chiao Chang; Sagi Grimberg; linux-nvme at lists.infradead.org
> Subject: Re: Whenever running nvme discover command, syslog shows warning messages
>   
> but that's not normal, sounds like a test case.?? I wouldn't want to
> lose a debuggable situation in the field because your test case made it
> chatty.
>
> On 11/29/2018 6:40 PM, Ching-Chiao Chang wrote:
>> The reason I would like to avoid those messages is that when we put the nvme discover command in a loop, it generates a tons of those messages is syslog.
>>
>>
>>
>> Thanks.
>>
>>
>> From: Sagi Grimberg <sagi at grimberg.me>
>> Sent: Friday, November 30, 2018 9:34 AM
>> To: James Smart; Ching-Chiao Chang; linux-nvme at lists.infradead.org
>> Subject: Re: Whenever running nvme discover command, syslog shows warning messages
>>     
>>
>>> no there's not - currently.
>>>
>>> I find them worthwhile to see, as it hints at what the admin or
>>> scripting is doing, as well as giving hints on when nvme? names may be
>>> reallocated. I would not remove them for normal storage controllers.
>>> Perhaps a discovery controller could be filtered out, but I still find
>>> it useful.
>> We can filter it out for discovery controllers... I'm pretty indifferent
>> about it...
