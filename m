From: bdeyal@gmail.com (Eyal BenDavid)
Date: Mon, 25 Mar 2019 19:09:11 +0200
Subject: The state of Compare and Write testing using linux-nvme
Message-ID: <CAPrnrPDCNUhXDMaqUTMoMsAsNe7FgvjwHS4+eqpSkOtJVFkkMg@mail.gmail.com>

Hi all,

We are developing storage solutions with support for NVMe protocol
over fabrics. On Linux, we use linux-nvme for testing our storage.
>From user space we use nvme-cli (and direct ioctl in some cases)
There are some problems testing the Compare and Write command from linux:

* nvme_core : module rejects nonzero flag arguments in admin-passthru
and io-passthru

* nvme-cli : no command for compare and write. Flags is hard coded 0
in admin-passthru and io-passthru functions (nvme-ioctl.c)

* The Fused commands (compare, write) must be sent from the same
controller and submission queue. I am not aware of any way to assign
a submission queue from user space.

* Since ioctl interface is blocking, we must send the two commands
from different threads / processes

However, we succeeded in running Fused Compare and Write tests with the
following workarounds:

- Rebuilt kernel module not to reject Fused commands in flags

- nvme-cli was not used but direct ioctl calls from a different
program allowing fused flags

- Submission Queue : Reconnected the controller with nr_io_queues=1
so that all IOs are sent from the same queue. No multipath.

- The program we used sent the two fused commands from two different
threads.

Questions:
Why the check for flags in the kernel module? The fix is trivial
(I would suggest a module parameter that can be set from sysfs)

I have a side branch for nvme-cli with the compare and write implemented
(from two threads), but it?s useless if nvme-core rejects fused flags.
If it?s desirable I can provide a pull request.

How can a user space program select a specific submission queue?

Thanks,
Eyal
