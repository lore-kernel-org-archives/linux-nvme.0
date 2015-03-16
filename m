From: keith.busch@intel.com (Keith Busch)
Date: Mon, 16 Mar 2015 17:51:58 +0000 (UTC)
Subject: [BUG] cpu hot-remove fails with nvme device
In-Reply-To: <CACTTzNa9SHC1F+WbFpu7NVax1nrV9_9cgspq=9KXEtkwb0iqNA@mail.gmail.com>
References: <CACTTzNa9SHC1F+WbFpu7NVax1nrV9_9cgspq=9KXEtkwb0iqNA@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1503161749290.32385@localhost.lm.intel.com>

On Mon, 16 Mar 2015, Yigal Korman wrote:
> Hi,
>
> Using cpu hotplug to disable (offline) a cpu:
> echo 0 > /sys/devices/system/cpu/cpu10/online
> does not return.
>
> Machine is usable, and cpu10 is marked as offline, but any test
> scripts hangs because the "echo 0" never returned.
>
> Doing bisect pointed to this commit id: a4aea5623d "NVMe: Convert to blk-mq"
> Indeed, the test machine in question has an NVMe card.
> Doing "rmmod nvme" and then disabling cpus works.

Thanks for the head's up. Do you know if nvme is the only driver
subscribing to blk-mq in your system? The nvme driver doesn't register
with cpu notification anymore, so I'm just trying to see if this is
a generic blk-mq issue or if there is some other interaction specific
to nvme.
