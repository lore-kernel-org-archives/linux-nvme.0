From: hare@suse.de (Hannes Reinecke)
Date: Fri, 15 Mar 2019 13:40:16 +0100
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <5c64286b-3fbf-9dfe-ef8a-3f72e630f11d@broadcom.com>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>
 <e7423c76-6425-4020-2074-b977fc87866f@grimberg.me>
 <d1742744-1109-e7e8-3586-fca6556c803b@broadcom.com>
 <d7bbfc2a-92ea-315d-bbd6-cd3847449f7b@grimberg.me>
 <3b524b54-8f13-24f5-4367-34a4d02c59b3@broadcom.com>
 <5c64286b-3fbf-9dfe-ef8a-3f72e630f11d@broadcom.com>
Message-ID: <a4f8ca74-7777-9e80-3209-ef9ce27ad2d8@suse.de>

On 3/14/19 9:50 PM, James Smart wrote:
> 
> 
> On 3/14/2019 1:43 PM, James Smart wrote:
>>
>>
>> On 3/13/2019 5:00 PM, Sagi Grimberg wrote:
>>>
>>>>>> Hmm.
>>>>>>
>>>>>> Last time I've posted the autoconnect scripts you said you'd 
>>>>>> rather have them updated to be useful for generic discovery events.
>>>>>> So what happened to that?
>>>>>
>>>>> I would like to have a single event, but the one difference is that
>>>>> the discovery log page events come on a discovery controller and in
>>>>> the fc case we don't have such a controller (the NVME_INSTANCE env).
>>>>>
>>>>> If we can resolve this difference we can unite and have a single udev
>>>>> handler for both...
>>>>
>>>> We shouldn't unite them. They are very different things.? One is an 
>>>> event that says I found a discovery controller go probe it, while 
>>>> the other is a discovery controller saying I have a discovery log 
>>>> entry go connect to it.?? My position is we should have both.
>>>
>>> Well I agree with you, but these the question is would userspace do
>>> something different for each? As of now it doesn't.
>>
>> I would think it would do something different. What we don't do well 
>> currently is specify per-connection parameters - when automated. 
>> That's where I see the difference.
>>
>> I would think parameters for the discovery controller should be 
>> separate from parameters for? storage controllers. So the scripts 
>> could use two different config files to look up defaults or 
>> per-connect values.
>>
>> For example, the discovery controller probe request can look at a 
>> discovery_connect.cfg, obtain defaults or a tr-addr-based match for 
>> say ctrl-loss-timeout, whether to be long-lived, and if long-lived 
>> what the keep-alive-tmo should be.
>>
>> While the connect request can look at storage_connect.cfg, use the 
>> tr-addr-values and nqn to determine if it should not be connected to 
>> (default is yes), and if connecting, defaults or any tuning based on 
>> nqn or tr-addr-values to use for the connect.
>>
> 
> These are still very similar - but I guess what separated things for me 
> was the defaults for discovery vs storage would be different.
> 

I do have some quite fundamental problem with discovery log change events:
- The initial discovery is still unsolved, ie we have to know the 
transport address before we can even get to those events
- More crucially, we don't get these events when we to the first 
connection, requiring us to have the initial call to 'connect-all' on a 
separate way.
- We don't have any indication if a new subsystem has been created; once 
a subsystem a new subsystem on another port is created it's anyones 
guess if that'll show up on the particular discovery controller

Especially the second point is most vexing; we could get around this by 
requiring the discovery controller to send AENs on the initial connect
(well, actually as soon as the AENs are enabled), but I guess that'll 
require a change to the spec ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
