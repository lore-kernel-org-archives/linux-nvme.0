From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 May 2015 16:23:30 +0000 (UTC)
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
In-Reply-To: <CAGgvQNRhUVujKiniazC6ha3nQm789EeM6XdwFDe42HdOESS0+g@mail.gmail.com>
References: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>
 <alpine.LNX.2.00.1505211931470.15930@localhost.lm.intel.com>
 <CAGgvQNQHaZBRzedkLmYxCBtDyxq7j2wr=e0vAYfw5r+KKeVbxg@mail.gmail.com>
 <alpine.LNX.2.00.1505221446410.15930@localhost.lm.intel.com>
 <CAGgvQNRi+60uNYqaeKHMRci_9zuDngi07mkUsNSdiOyZz9QG-w@mail.gmail.com>
 <alpine.LNX.2.00.1505221453230.15930@localhost.lm.intel.com>
 <CAGgvQNRhUVujKiniazC6ha3nQm789EeM6XdwFDe42HdOESS0+g@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1505221608560.15930@localhost.lm.intel.com>

On Fri, 22 May 2015, Parav Pandit wrote:
> During normal positive path probe,
> (a) device is added to dev_list in nvme_dev_start()
> (b) nvme_kthread got created, which will eventually refers to
> dev->queues[qid] to check for NULL.
> (c) dev_start() worker thread has started probing device and creating
> the queue using nvme_alloc_queue
> This is is assigning the dev->queue[qid] new pointer.
> If this is done out of order, nvme_kthread will pickup uninitialized
> q_lock, cq_phase, q_db.

A memory barrier before incrementing the dev->queue_count (and assigning
the pointer in the array before that) should address this concern.

> Other thoughts to not create nvme_kthread until all the queues are active.

No good, we want to poll during queue creation to detect controller
errors and broken interrupts.
