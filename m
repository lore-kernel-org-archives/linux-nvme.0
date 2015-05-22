From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 May 2015 15:11:44 +0000 (UTC)
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
In-Reply-To: <CAGgvQNRi+60uNYqaeKHMRci_9zuDngi07mkUsNSdiOyZz9QG-w@mail.gmail.com>
References: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>
 <alpine.LNX.2.00.1505211931470.15930@localhost.lm.intel.com>
 <CAGgvQNQHaZBRzedkLmYxCBtDyxq7j2wr=e0vAYfw5r+KKeVbxg@mail.gmail.com>
 <alpine.LNX.2.00.1505221446410.15930@localhost.lm.intel.com>
 <CAGgvQNRi+60uNYqaeKHMRci_9zuDngi07mkUsNSdiOyZz9QG-w@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1505221453230.15930@localhost.lm.intel.com>

On Fri, 22 May 2015, Parav Pandit wrote:
> On Fri, May 22, 2015@8:18 PM, Keith Busch <keith.busch@intel.com> wrote:
>> The rcu protection on nvme queues was removed with the blk-mq conversion
>> as we rely on that layer for h/w access.
>
> o.k. But above is at level where data I/Os are not even active. Its
> between nvme_kthread and nvme_resume() from power management
> subsystem.
> I must be missing something.

On resume, everything is already reaped from the queues, so there should
be no harm letting the kthread poll an inactive queue. The proposal to
remove the q_lock during queue init makes it possible for the thread to
see the wrong cq phase bit and mess up the completion queue's head from
reaping non-existent entries.

But beyond nvme_resume, it appears a race condition is possible on any
scenario when a device is reinitialized if it cannot create the same
number of IO queues as it had in originally. Part of the problem is there
doesn't seem to be a way to change a tagset's nr_hw_queues after it was
created. The conditions that leads to this scenario should be uncommon,
so I haven't given it much thought; I need to untangle dynamic namespaces
first. :)
