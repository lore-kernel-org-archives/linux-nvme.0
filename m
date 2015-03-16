From: yigal@plexistor.com (Yigal Korman)
Date: Mon, 16 Mar 2015 14:07:20 +0200
Subject: [BUG] cpu hot-remove fails with nvme device
Message-ID: <CACTTzNa9SHC1F+WbFpu7NVax1nrV9_9cgspq=9KXEtkwb0iqNA@mail.gmail.com>

Hi,

Using cpu hotplug to disable (offline) a cpu:
echo 0 > /sys/devices/system/cpu/cpu10/online
does not return.

Machine is usable, and cpu10 is marked as offline, but any test
scripts hangs because the "echo 0" never returned.

Doing bisect pointed to this commit id: a4aea5623d "NVMe: Convert to blk-mq"
Indeed, the test machine in question has an NVMe card.
Doing "rmmod nvme" and then disabling cpus works.

Thanks,
Yigal
