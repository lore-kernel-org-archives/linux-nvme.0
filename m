From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 26 Jul 2019 16:37:22 -0600
Subject: [PATCH v6 00/16] nvmet: add target passthru commands support
In-Reply-To: <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
 <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
 <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
Message-ID: <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>



On 2019-07-26 4:21 p.m., Sagi Grimberg wrote:
>> I don't think it necessarily makes sense for the target subsynqn and the
>> target's device nqn to be the same. It would be weird for a user to want
>> to use the same device and a passed through device (through a loop) as
>> part of the same subsystem. That being said, it's possible for the user
>> to use the subsysnqn from the passed through device for the name of the
>> subsys of the target. I tried this and it works except for the fact that
>> the device I'm passing through doesn't set id->cmic.
> 
> I don't see why should the subsystem nqn should be the same name. Its
> just like any other nvmet subsystem, just happens to have a nvme
> controller in the backend (which it knows about). No reason to have
> the same name IMO.

Agreed.

>>> Similarly: how do you propose to handle multipath devices?
>>> Any NVMe with several paths will be enabling NVMe multipathing
>>> automatically, presenting you with a single multipathed namespace.
>>> How will these devices be treated?
>>
>> Well passthru works on the controller level not on the namespace level.
>> So it can't make use of the multipath handling on the target system.
> 
> Why? if nvmet is capable, why shouldn't we support it?

I'm saying that passthru is exporting a specific controller and submits
commands (both admin and IO) straight to the nvme_ctrl's queues. It's
not exporting an nvme_subsys and I think it would be troublesome to do
so; for example, if the target receives an admin command which ctrl of
the subsystem should it send it to? There's also no userspace handle for
a given subsystem we'd maybe have to use the subsysnqn.

>> The one case that I think makes sense to me, but I don't know how if we
>> can handle, is if the user had a couple multipath enabled controllers
>> with the same subsynqn
> 
> That is usually the case, there is no multipathing defined across NVM
> subsystems (at least for now).
> 
>> and wanted to passthru all of them to another
>> system and use multipath on the host with both controllers. This would
>> require having multiple target subsystems with the same name which I
>> don't think will work too well.
> 
> Don't understand why this is the case?
> 
> AFAICT, all nvmet needs to do is:
> 1. override cimc
> 2. allow allocating multiple controllers to the pt ctrl as long as the
> hostnqn match.
> 3. answer all the ana stuff.

But with this scheme the host will only see one controller and then the
target would have to make decisions on which ctrl to send any commands
to. Maybe it could be done for I/O but I don't see how it could be done
correctly for admin commands.

And from the hosts perspective, having cimc set doesn't help anything
because we've limited the passthru code to only accept one connection
from one host so the host can only actually have one route to this
controller.

Logan
