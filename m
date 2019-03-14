From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 14 Mar 2019 14:41:35 -0700
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <3b524b54-8f13-24f5-4367-34a4d02c59b3@broadcom.com>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>
 <e7423c76-6425-4020-2074-b977fc87866f@grimberg.me>
 <d1742744-1109-e7e8-3586-fca6556c803b@broadcom.com>
 <d7bbfc2a-92ea-315d-bbd6-cd3847449f7b@grimberg.me>
 <3b524b54-8f13-24f5-4367-34a4d02c59b3@broadcom.com>
Message-ID: <acf63882-59b5-614d-bbf9-00ae9a9a454f@grimberg.me>


>>> We shouldn't unite them. They are very different things.? One is an 
>>> event that says I found a discovery controller go probe it, while the 
>>> other is a discovery controller saying I have a discovery log entry 
>>> go connect to it.?? My position is we should have both.
>>
>> Well I agree with you, but these the question is would userspace do
>> something different for each? As of now it doesn't.
> 
> I would think it would do something different. What we don't do well 
> currently is specify per-connection parameters - when automated. That's 
> where I see the difference.
> 
> I would think parameters for the discovery controller should be separate 
> from parameters for? storage controllers. So the scripts could use two 
> different config files to look up defaults or per-connect values.
> 
> For example, the discovery controller probe request can look at a 
> discovery_connect.cfg, obtain defaults or a tr-addr-based match for say 
> ctrl-loss-timeout, whether to be long-lived, and if long-lived what the 
> keep-alive-tmo should be.
> 
> While the connect request can look at storage_connect.cfg, use the 
> tr-addr-values and nqn to determine if it should not be connected to 
> (default is yes), and if connecting, defaults or any tuning based on nqn 
> or tr-addr-values to use for the connect.

I do have a plan to add something like params.cfg that nvme connect
would assemble for the connect string, but isn't that orthogonal
to the the action taken for both events?
