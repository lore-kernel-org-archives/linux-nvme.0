From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 15 Oct 2018 18:11:09 -0700
Subject: [PATCH rfc 0/3] add support to discovery async event notifications
In-Reply-To: <068e3b84-b43e-0202-ace6-612e4466938b@grimberg.me>
References: <20181004212328.30205-1-sagi@grimberg.me>
 <cbf24fc6-a6dd-dcc4-35ce-97bec248dd32@suse.de>
 <6874c24e-28ec-97da-5d31-6a9215f995e1@grimberg.me>
 <1e8b8eae-d52b-b8d0-9d86-9e5898b0efc2@suse.de>
 <068e3b84-b43e-0202-ace6-612e4466938b@grimberg.me>
Message-ID: <3e7e99bc-deff-795f-0f0b-de3f50c3a50a@grimberg.me>


>> Oh, I don't doubt that it'll work in the sense that 'nvme connect-all' 
>> is executed.
>> I _do_ doubt that the 'disown' is doing anything at all; both '&' and 
>> 'disown' will be used as arguments to '/usr/sbin/nvme', and _not_ 
>> interpreted by any shell (as no shell is invoked in the first place).
>> Internally udev will call 'execve' to call the new program, which will 
>> invoke a shell only for shell scripts; binary programs will be 
>> executed directly with not shell whatsoever.
> 
> I see, we can run it with /bin/sh and it should do the trick?

Hannes,

Do you agree that it would suffice? Or, Do you think we should take
a different approach?

Would like to get some feedback from others given that this is not
a trivial decision about which way we go here..
