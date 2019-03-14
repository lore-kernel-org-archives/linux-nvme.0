From: james.smart@broadcom.com (James Smart)
Date: Thu, 14 Mar 2019 13:43:29 -0700
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <d7bbfc2a-92ea-315d-bbd6-cd3847449f7b@grimberg.me>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>
 <e7423c76-6425-4020-2074-b977fc87866f@grimberg.me>
 <d1742744-1109-e7e8-3586-fca6556c803b@broadcom.com>
 <d7bbfc2a-92ea-315d-bbd6-cd3847449f7b@grimberg.me>
Message-ID: <3b524b54-8f13-24f5-4367-34a4d02c59b3@broadcom.com>



On 3/13/2019 5:00 PM, Sagi Grimberg wrote:
>
>>>> Hmm.
>>>>
>>>> Last time I've posted the autoconnect scripts you said you'd rather 
>>>> have them updated to be useful for generic discovery events.
>>>> So what happened to that?
>>>
>>> I would like to have a single event, but the one difference is that
>>> the discovery log page events come on a discovery controller and in
>>> the fc case we don't have such a controller (the NVME_INSTANCE env).
>>>
>>> If we can resolve this difference we can unite and have a single udev
>>> handler for both...
>>
>> We shouldn't unite them. They are very different things.? One is an 
>> event that says I found a discovery controller go probe it, while the 
>> other is a discovery controller saying I have a discovery log entry 
>> go connect to it.?? My position is we should have both.
>
> Well I agree with you, but these the question is would userspace do
> something different for each? As of now it doesn't.

I would think it would do something different. What we don't do well 
currently is specify per-connection parameters - when automated. That's 
where I see the difference.

I would think parameters for the discovery controller should be separate 
from parameters for? storage controllers. So the scripts could use two 
different config files to look up defaults or per-connect values.

For example, the discovery controller probe request can look at a 
discovery_connect.cfg, obtain defaults or a tr-addr-based match for say 
ctrl-loss-timeout, whether to be long-lived, and if long-lived what the 
keep-alive-tmo should be.

While the connect request can look at storage_connect.cfg, use the 
tr-addr-values and nqn to determine if it should not be connected to 
(default is yes), and if connecting, defaults or any tuning based on nqn 
or tr-addr-values to use for the connect.


>
>>>> I do have some patches, but still need to polish them off (and 
>>>> possibly test them :-) before sending.
>>>
>>> Not sure if that is any better, but lets see patches...
>>
>> any updates on these ?
>
> Good question...

-- james
