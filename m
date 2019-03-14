From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 13 Mar 2019 17:00:21 -0700
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <d1742744-1109-e7e8-3586-fca6556c803b@broadcom.com>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>
 <e7423c76-6425-4020-2074-b977fc87866f@grimberg.me>
 <d1742744-1109-e7e8-3586-fca6556c803b@broadcom.com>
Message-ID: <d7bbfc2a-92ea-315d-bbd6-cd3847449f7b@grimberg.me>


>>> Hmm.
>>>
>>> Last time I've posted the autoconnect scripts you said you'd rather 
>>> have them updated to be useful for generic discovery events.
>>> So what happened to that?
>>
>> I would like to have a single event, but the one difference is that
>> the discovery log page events come on a discovery controller and in
>> the fc case we don't have such a controller (the NVME_INSTANCE env).
>>
>> If we can resolve this difference we can unite and have a single udev
>> handler for both...
> 
> We shouldn't unite them. They are very different things.? One is an 
> event that says I found a discovery controller go probe it, while the 
> other is a discovery controller saying I have a discovery log entry go 
> connect to it.?? My position is we should have both.

Well I agree with you, but these the question is would userspace do
something different for each? As of now it doesn't.

>>> I do have some patches, but still need to polish them off (and 
>>> possibly test them :-) before sending.
>>
>> Not sure if that is any better, but lets see patches...
> 
> any updates on these ?

Good question...
