From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 7 Nov 2018 11:51:08 +0800
Subject: [RFC PATCH] nvme of: don't flush scan work inside reset context
In-Reply-To: <97aae455-fa74-b1aa-21f6-80c03732a573@grimberg.me>
References: <20181105115734.15515-1-ming.lei@redhat.com>
 <97aae455-fa74-b1aa-21f6-80c03732a573@grimberg.me>
Message-ID: <20181107035107.GA6920@ming.t460p>

On Tue, Nov 06, 2018@07:26:28PM -0800, Sagi Grimberg wrote:
> Ming,
> 
> > When scan work is in-progress, any controller error may trigger
> > reset, now fc, rdma and loop host tries to flush scan work
> > inside reset context.
> > 
> > This way can cause deadlock easily because any IO during controler
> > recovery(reset) can't be completed until the recovery is done.
> 
> Did you encounter this deadlock? or is it theoretical?

There are several such reports in Red Hat Bugzilla.

> 
> The point of nvme_stop_ctrl is to quiesce everything before
> moving forward with tearing down the controller instead of
> trying to handle concurrent incoming I/O.
> 
> I'm not sure I understand why you say that I/O can only be
> completed when the reset is done? if the transport entered

Please see nvme_rdma_teardown_io_queues(), in which each in-flight
request is canceled via nvme_cancel_request(), which just calls
nvme_complete_rq() to requeue request(normal IO) to blk-mq sw queue
or scheduler queue.

During reset, block request queues are quiesced, so the requeued
requests can't be dispatched to nvme driver until reset is done.

That is why all normal I/O can only be completed after reset is done.

> a failed state either the inflight I/O is drain or one of
> the scan work I/O operations times out.

Timeout only works for in-flight request, as mentioned above,
all these requests are canceled and put back into blk-mq sw queue
or scheduler queue during reset, so timeout handler can't cover
them at all.

Thanks,
Ming
