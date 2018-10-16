From: james.smart@broadcom.com (James Smart)
Date: Tue, 16 Oct 2018 10:59:58 -0700
Subject: [PATCH rfc 0/3] add support to discovery async event notifications
In-Reply-To: <8c3dc9a9-f222-87e9-383f-d319fb0a86df@suse.de>
References: <20181004212328.30205-1-sagi@grimberg.me>
 <cbf24fc6-a6dd-dcc4-35ce-97bec248dd32@suse.de>
 <6874c24e-28ec-97da-5d31-6a9215f995e1@grimberg.me>
 <1e8b8eae-d52b-b8d0-9d86-9e5898b0efc2@suse.de>
 <068e3b84-b43e-0202-ace6-612e4466938b@grimberg.me>
 <3e7e99bc-deff-795f-0f0b-de3f50c3a50a@grimberg.me>
 <8c3dc9a9-f222-87e9-383f-d319fb0a86df@suse.de>
Message-ID: <193097d1-b39b-f152-d60b-8bddbc3ee4b1@broadcom.com>



On 10/15/2018 10:59 PM, Hannes Reinecke wrote:
> On 10/16/18 3:11 AM, Sagi Grimberg wrote:
>>
>>>> Oh, I don't doubt that it'll work in the sense that 'nvme 
>>>> connect-all' is executed.
>>>> I _do_ doubt that the 'disown' is doing anything at all; both '&' 
>>>> and 'disown' will be used as arguments to '/usr/sbin/nvme', and 
>>>> _not_ interpreted by any shell (as no shell is invoked in the first 
>>>> place).
>>>> Internally udev will call 'execve' to call the new program, which 
>>>> will invoke a shell only for shell scripts; binary programs will be 
>>>> executed directly with not shell whatsoever.
>>>
>>> I see, we can run it with /bin/sh and it should do the trick?
>>
>> Hannes,
>>
>> Do you agree that it would suffice? Or, Do you think we should take
>> a different approach?
>>
>> Would like to get some feedback from others given that this is not
>> a trivial decision about which way we go here..
>
> Actually, I have looked at the original solution from James Smart for 
> FC-NVMe autoconnect.
>
> Essentially he starts a system service from a udev rule, which in 
> itself is triggered by the event.
> With that we're out of the udev program timeout (as systemd services 
> can run for arbitrarily long) _and_ we also have resolved the problem 
> of a uevent storm, as systemd will manage that for us.
>
> The only problem here is that we need to pass arguments to the systemd 
> service, but if we can use the standard udev trick of placing the 
> arguments into the program environment and having the program looking 
> for that we should be able to solve that, too.

fyi - the udev script fc uses passes arguments (HOST_TRADDR and TRADDR) 
from the event into the systemd service. Actually, it creates an 
instance of the service based on the names built from those arguments.

Passing different arguments beyond that seemed rather difficult. For 
that I was assuming the instance arguments would have to be parsed, and 
a system file extracted, to obtain any variable values (such as 
device-specific connect timeouts, or queue count limits, etc).


-- jmes
