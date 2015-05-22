From: parav.pandit@avagotech.com (Parav Pandit)
Date: Fri, 22 May 2015 21:33:27 +0530
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
In-Reply-To: <alpine.LNX.2.00.1505221453230.15930@localhost.lm.intel.com>
References: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>
 <alpine.LNX.2.00.1505211931470.15930@localhost.lm.intel.com>
 <CAGgvQNQHaZBRzedkLmYxCBtDyxq7j2wr=e0vAYfw5r+KKeVbxg@mail.gmail.com>
 <alpine.LNX.2.00.1505221446410.15930@localhost.lm.intel.com>
 <CAGgvQNRi+60uNYqaeKHMRci_9zuDngi07mkUsNSdiOyZz9QG-w@mail.gmail.com>
 <alpine.LNX.2.00.1505221453230.15930@localhost.lm.intel.com>
Message-ID: <CAGgvQNRhUVujKiniazC6ha3nQm789EeM6XdwFDe42HdOESS0+g@mail.gmail.com>

On Fri, May 22, 2015@8:41 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Fri, 22 May 2015, Parav Pandit wrote:
>>
>> On Fri, May 22, 2015 at 8:18 PM, Keith Busch <keith.busch at intel.com>
>> wrote:
>>>
>>> The rcu protection on nvme queues was removed with the blk-mq conversion
>>> as we rely on that layer for h/w access.
>>
>>
>> o.k. But above is at level where data I/Os are not even active. Its
>> between nvme_kthread and nvme_resume() from power management
>> subsystem.
>> I must be missing something.
>
>
> On resume, everything is already reaped from the queues, so there should
> be no harm letting the kthread poll an inactive queue. The proposal to
> remove the q_lock during queue init makes it possible for the thread to
> see the wrong cq phase bit and mess up the completion queue's head from
> reaping non-existent entries.
>
I agree. q_lock is necessary.

> But beyond nvme_resume, it appears a race condition is possible on any
> scenario when a device is reinitialized if it cannot create the same
> number of IO queues as it had in originally. Part of the problem is there
> doesn't seem to be a way to change a tagset's nr_hw_queues after it was
> created. The conditions that leads to this scenario should be uncommon,
> so I haven't given it much thought; I need to untangle dynamic namespaces
> first. :)

It probably doesn't matter with number of nr_hw_queues.
o.k. so we agree on the existence of race condition.

Let me point to another more generic race condition, which I believe
my rcu changes can fix it.

During normal positive path probe,
(a) device is added to dev_list in nvme_dev_start()
(b) nvme_kthread got created, which will eventually refers to
dev->queues[qid] to check for NULL.
(c) dev_start() worker thread has started probing device and creating
the queue using nvme_alloc_queue
This is is assigning the dev->queue[qid] new pointer.
If this is done out of order, nvme_kthread will pickup uninitialized
q_lock, cq_phase, q_db.

So to protect this also I need rcu().
This rc fix I am proposing addresses both the problem, one I described
previously, and one now. (Both are same race conditions occurring in
normal probe process and resume path as well).
More long term fix would be to have device flag for the state to
maintain. I haven't thought fully for this one yet.
Other thoughts to not create nvme_kthread until all the queues are active.
I will differ this design change discussion for now and keep focus on
fixing this primary race condition using RCU in next patch.
