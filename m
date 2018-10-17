From: hare@suse.de (Hannes Reinecke)
Date: Wed, 17 Oct 2018 17:29:10 +0200
Subject: [PATCH rfc 0/3] add support to discovery async event notifications
In-Reply-To: <193097d1-b39b-f152-d60b-8bddbc3ee4b1@broadcom.com>
References: <20181004212328.30205-1-sagi@grimberg.me>
 <cbf24fc6-a6dd-dcc4-35ce-97bec248dd32@suse.de>
 <6874c24e-28ec-97da-5d31-6a9215f995e1@grimberg.me>
 <1e8b8eae-d52b-b8d0-9d86-9e5898b0efc2@suse.de>
 <068e3b84-b43e-0202-ace6-612e4466938b@grimberg.me>
 <3e7e99bc-deff-795f-0f0b-de3f50c3a50a@grimberg.me>
 <8c3dc9a9-f222-87e9-383f-d319fb0a86df@suse.de>
 <193097d1-b39b-f152-d60b-8bddbc3ee4b1@broadcom.com>
Message-ID: <16d6de92-2f42-d78e-b3dd-60f8c4f18613@suse.de>

On 10/16/18 7:59 PM, James Smart wrote:
> 
> 
> On 10/15/2018 10:59 PM, Hannes Reinecke wrote:
>> On 10/16/18 3:11 AM, Sagi Grimberg wrote:
>>>
>>>>> Oh, I don't doubt that it'll work in the sense that 'nvme 
>>>>> connect-all' is executed.
>>>>> I _do_ doubt that the 'disown' is doing anything at all; both '&' 
>>>>> and 'disown' will be used as arguments to '/usr/sbin/nvme', and 
>>>>> _not_ interpreted by any shell (as no shell is invoked in the first 
>>>>> place).
>>>>> Internally udev will call 'execve' to call the new program, which 
>>>>> will invoke a shell only for shell scripts; binary programs will be 
>>>>> executed directly with not shell whatsoever.
>>>>
>>>> I see, we can run it with /bin/sh and it should do the trick?
>>>
>>> Hannes,
>>>
>>> Do you agree that it would suffice? Or, Do you think we should take
>>> a different approach?
>>>
>>> Would like to get some feedback from others given that this is not
>>> a trivial decision about which way we go here..
>>
>> Actually, I have looked at the original solution from James Smart for 
>> FC-NVMe autoconnect.
>>
>> Essentially he starts a system service from a udev rule, which in 
>> itself is triggered by the event.
>> With that we're out of the udev program timeout (as systemd services 
>> can run for arbitrarily long) _and_ we also have resolved the problem 
>> of a uevent storm, as systemd will manage that for us.
>>
>> The only problem here is that we need to pass arguments to the systemd 
>> service, but if we can use the standard udev trick of placing the 
>> arguments into the program environment and having the program looking 
>> for that we should be able to solve that, too.
> 
> fyi - the udev script fc uses passes arguments (HOST_TRADDR and TRADDR) 
> from the event into the systemd service. Actually, it creates an 
> instance of the service based on the names built from those arguments.
> 
> Passing different arguments beyond that seemed rather difficult. For 
> that I was assuming the instance arguments would have to be parsed, and 
> a system file extracted, to obtain any variable values (such as 
> device-specific connect timeouts, or queue count limits, etc).
> 
That is precisely where I'm scratching my head now.
Essentially the systemd '@' thingie allows you to pass exactly _one_ 
argument. Sadly we have several options to pass, not just one.
We could reduce the number of options by having per-transport services,
but then we require at least two arguments to be passed (host traddr and 
traddr for FC, traddr, trsvcid, and adrfam for RDMA).
 From what I can see we can try to:
1) escape the arguments so that they appear as one string to systemd, 
and then de-escaping them in the service file. Works without 
modification to the code, but then you always have to invoke the shell 
to handle escaping/de-escaping.
2) preformat the nvme option string, and pass that as argument for the 
systemd service. Which actually would get rid of the need for using 
nvme-cli, too, as we could just write the string into the device node.
Will be looking into it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
