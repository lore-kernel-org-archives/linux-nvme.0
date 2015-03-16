From: keith.busch@intel.com (Keith Busch)
Date: Mon, 16 Mar 2015 19:38:40 +0000 (UTC)
Subject: [BUG] cpu hot-remove fails with nvme device
In-Reply-To: <alpine.LNX.2.00.1503161749290.32385@localhost.lm.intel.com>
References: <CACTTzNa9SHC1F+WbFpu7NVax1nrV9_9cgspq=9KXEtkwb0iqNA@mail.gmail.com>
 <alpine.LNX.2.00.1503161749290.32385@localhost.lm.intel.com>
Message-ID: <alpine.LNX.2.00.1503161926040.32385@localhost.lm.intel.com>

> On Mon, 16 Mar 2015, Yigal Korman wrote:
>> Using cpu hotplug to disable (offline) a cpu:
>> echo 0 > /sys/devices/system/cpu/cpu10/online
>> does not return.

I just got back to my lab and tried your test. It's failing because the
blk-mq hot cpu notifier callback freezes the queues and waits for all
who've entered to exit (i.e., no outstanding requests). The NVMe driver
submits async admin commands that don't have a timeout, so this queue
never has zero references until the driver shuts the controller down.

I don't have a good idea how to fix this right now. I'll look into it
unless Jens or someone else has a suggestion.
