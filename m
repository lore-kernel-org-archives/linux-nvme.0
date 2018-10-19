From: james.smart@broadcom.com (James Smart)
Date: Fri, 19 Oct 2018 09:09:57 -0700
Subject: [PATCH rfc 0/3] add support to discovery async event notifications
In-Reply-To: <16d6de92-2f42-d78e-b3dd-60f8c4f18613@suse.de>
References: <20181004212328.30205-1-sagi@grimberg.me>
 <cbf24fc6-a6dd-dcc4-35ce-97bec248dd32@suse.de>
 <6874c24e-28ec-97da-5d31-6a9215f995e1@grimberg.me>
 <1e8b8eae-d52b-b8d0-9d86-9e5898b0efc2@suse.de>
 <068e3b84-b43e-0202-ace6-612e4466938b@grimberg.me>
 <3e7e99bc-deff-795f-0f0b-de3f50c3a50a@grimberg.me>
 <8c3dc9a9-f222-87e9-383f-d319fb0a86df@suse.de>
 <193097d1-b39b-f152-d60b-8bddbc3ee4b1@broadcom.com>
 <16d6de92-2f42-d78e-b3dd-60f8c4f18613@suse.de>
Message-ID: <35bca510-c2ac-1464-8d76-3c8e88c137eb@broadcom.com>



On 10/17/2018 8:29 AM, Hannes Reinecke wrote:
> On 10/16/18 7:59 PM, James Smart wrote:
>>
>> fyi - the udev script fc uses passes arguments (HOST_TRADDR and 
>> TRADDR) from the event into the systemd service. Actually, it creates 
>> an instance of the service based on the names built from those 
>> arguments.
>>
>> Passing different arguments beyond that seemed rather difficult. For 
>> that I was assuming the instance arguments would have to be parsed, 
>> and a system file extracted, to obtain any variable values (such as 
>> device-specific connect timeouts, or queue count limits, etc).
>>
> That is precisely where I'm scratching my head now.
> Essentially the systemd '@' thingie allows you to pass exactly _one_ 
> argument. Sadly we have several options to pass, not just one.

I know.? see below.

> We could reduce the number of options by having per-transport services,
> but then we require at least two arguments to be passed (host traddr 
> and traddr for FC, traddr, trsvcid, and adrfam for RDMA).
> From what I can see we can try to:
> 1) escape the arguments so that they appear as one string to systemd, 
> and then de-escaping them in the service file. Works without 
> modification to the code, but then you always have to invoke the shell 
> to handle escaping/de-escaping.
> 2) preformat the nvme option string, and pass that as argument for the 
> systemd service. Which actually would get rid of the need for using 
> nvme-cli, too, as we could just write the string into the device node.

this is what FC did as FC had 2 args (for now): host_traddr and traddr
A single string was created for systemd, and that single string is 
passed as an argument to connect-all.? As the argument to connect-all 
was really 2 separate arguments (--host_traddr=<value>? and 
--traddr=<value), when we built the string for systemd which wants only 
1 arg, we embedded the spaces - used \\x20 rather than a space 
character.? There should be no reason this couldn't be extended to more 
arguments.??? We had tried several different ways to pass the arguments 
and this was the only way that seemed to hold together.? So it 
effectively does both of the things above.

And as I hinted before - I still think that this process needs to be 
augmented by something that sets per-connection overrides, so that 
different connect requests could have different connect timeouts. In 
general, these differences wouldn't be known by the transport. Although 
it would be possible to define a mechanism to go in the 
kernel/transport, I think it would be far better for nvme-cli to have a 
admin-defined override that could be used to match the connect args to 
custom parameters, which would support explicit matches as well as 
wildcards, then issue the connect request.??? For example, it could 
state anything that is of transport type X to use arguments Z, or 
anything that maps to address M to use arguments N.

-- james


> Will be looking into it.
>
> Cheers,
>
> Hannes
