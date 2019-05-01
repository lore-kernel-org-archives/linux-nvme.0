From: james.smart@broadcom.com (James Smart)
Date: Wed, 1 May 2019 14:49:48 -0700
Subject: [PATCH nvme-cli rfc] fabrics: support default connect/discover
 args
In-Reply-To: <e060385b-7695-d5b1-d4ca-2357e016219d@grimberg.me>
References: <20190429225338.6866-1-sagi@grimberg.me>
 <493df3a7-6d25-9fd1-57ff-addbf37fcf22@suse.de>
 <785558d1-519d-78c1-0a1b-7517f771c1e2@grimberg.me>
 <b4f9b6e4-f0b4-312f-1eeb-4c292a8f9af1@suse.de>
 <e060385b-7695-d5b1-d4ca-2357e016219d@grimberg.me>
Message-ID: <9614e100-3919-581c-0919-8e263e5633a5@broadcom.com>



On 4/30/2019 12:34 AM, Sagi Grimberg wrote:
>
>>> Effectively yes, but defargs does not allow 
>>> transport,traddr,trsvcid,nqn
>>> parameters (which don't make sense), and discovery.conf is designed to
>>> hold exactly those. So in practice they should not overlap.
>>>
>> Uh-oh. I _do_ know of cases where discovery.conf is used for 
>> precisely this purpose, ie holding _all_ arguments.
>
> That's fine.. it was never designed for this purpose though...
>
>> And in the absense of any other way existing implementations will be 
>> using a very similar thing.
>
> Again, this would work.
>
>>> Also, we only go to discovery.conf if we did not get a transport+traddr
>>> (which are mandatory). So its not exactly the order you mentioned, more
>>> like:
>>>
>>> defargs.conf
>>> <cmdline>
>>> if transport+traddr not given
>>> discovery.conf
>>>
>> How very curious ...
>> I would have expected that any command-line args would overwrite any 
>> arguments given in the configuration files.
>> But given that discovery.conf can contain several lines I can see the 
>> problem.
>
> Exactly. discovery.conf was simply added such that you can run nvme
> connect-all without explicitly passing parameters so you can build
> auto-connect scripts on top of.

with my suggestion it would be:
 ?? <parse cmdline for connect addressing args>
 ?? if transport+traddr not given:? pull them from discovery.conf note: 
if non-addressing args present, remember them
 ?? parse addressing args vs connectargs.conf? (aka defargs.conf)
 ? <apply non-addressing args from discovery.conf>
 ? <apply cmdline non-addressing args>

-- james
