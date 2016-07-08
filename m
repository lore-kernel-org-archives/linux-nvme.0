From: keith.busch@intel.com (Keith Busch)
Date: Fri, 8 Jul 2016 19:22:20 -0400
Subject: gain NVMe SQ in-flight entries #
In-Reply-To: <CANr0WEfCecCG4FKYtpdHxavj5AJGu+D2e2QsLwKe_77fKd-_yg@mail.gmail.com>
References: <CANr0WEfCecCG4FKYtpdHxavj5AJGu+D2e2QsLwKe_77fKd-_yg@mail.gmail.com>
Message-ID: <20160708232219.GA28530@localhost.localdomain>

On Fri, Jul 08, 2016@06:03:33PM -0500, Huaicheng Li wrote:
> Hi all,
> 
> (1). When nvme_queue_rq() queues a new I/O to the SQ, why doesn't it
> check whether the SQ is full or not?

It can never be full. We don't preallocate enough tags to fill it.

> Similarly, when nvme_process_rq() handles a CQE, it seems not checking
> whether CQ is empty? Why is that?

Huh? We check the phase bits to know if there's a new entry.

> (2). Why does nvme_queue_rq() need to call __nvme_process_cq()?? That
> should be the job of interrupt handler or poll().
> Anything missing here?

It's a micro optimization. We already hold the queue lock, might as well
opprotunistically see if there's any work completed. Worst case scenario
is nothing happens.

> (3). Is there an easy way to figure out how many entries are in the
> SQ? 

You can see how many are active on any given queue by reading the "tags"
file under /sys/block/nvmeXnY/mq/<queue>/tags

The tags are shared among multiple namespaces, so you only need to
query one's mq tags file see how many are active.

> We can know where SQ_tail is in nvme_queue structure, how can the
> host know where the queue's head is **immediately**?

The host doesn't really know where the SQ head is. Only the controller
knows that, though it does provide a hint on each completion queue entry
where it was at the time the CQE was posted.

Assuming you mean the SQ tail, you can't view that without writing some
additional code to expose this to a user. But why do you even want to
know this?
