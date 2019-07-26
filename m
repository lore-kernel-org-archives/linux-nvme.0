From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 26 Jul 2019 11:07:44 -0600
Subject: [PATCH v6 00/16] nvmet: add target passthru commands support
In-Reply-To: <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
Message-ID: <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>



On 2019-07-26 12:23 a.m., Hannes Reinecke wrote:
> How do you handle subsystem naming?
> If you enable the 'passthru' device, the (nvmet) subsystem (and its
> name) is already created. Yet the passthru device will have its own
> internal subsystem naming, so if you're not extra careful you'll end up
> with a nvmet subsystem which doesn't have any relationship with the
> passthru subsystem, making addressing etc ... tricky.
> Any thoughts about that?

Well I can't say I have a great understanding of how multipath works, but...

I don't think it necessarily makes sense for the target subsynqn and the
target's device nqn to be the same. It would be weird for a user to want
to use the same device and a passed through device (through a loop) as
part of the same subsystem. That being said, it's possible for the user
to use the subsysnqn from the passed through device for the name of the
subsys of the target. I tried this and it works except for the fact that
the device I'm passing through doesn't set id->cmic.

> Similarly: how do you propose to handle multipath devices?
> Any NVMe with several paths will be enabling NVMe multipathing
> automatically, presenting you with a single multipathed namespace.
> How will these devices be treated?

Well passthru works on the controller level not on the namespace level.
So it can't make use of the multipath handling on the target system.

The one case that I think makes sense to me, but I don't know how if we
can handle, is if the user had a couple multipath enabled controllers
with the same subsynqn and wanted to passthru all of them to another
system and use multipath on the host with both controllers. This would
require having multiple target subsystems with the same name which I
don't think will work too well.

> Will the multipathed namespace be used for passthru?

Nope.

Honestly, I think the answer is if someone wants to use multipathed
controllers they should use regular NVMe-of as it doesn't really mesh
well with the passthru approach.

Logan
