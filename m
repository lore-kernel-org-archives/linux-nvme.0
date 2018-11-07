From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 6 Nov 2018 20:38:59 -0800
Subject: [RFC PATCH] nvme of: don't flush scan work inside reset context
In-Reply-To: <20181107035107.GA6920@ming.t460p>
References: <20181105115734.15515-1-ming.lei@redhat.com>
 <97aae455-fa74-b1aa-21f6-80c03732a573@grimberg.me>
 <20181107035107.GA6920@ming.t460p>
Message-ID: <f1167108-0e3f-0b64-d9c3-399f4dec73d3@grimberg.me>


>> Did you encounter this deadlock? or is it theoretical?
> 
> There are several such reports in Red Hat Bugzilla.

Is there any way to see the reports? I'm looking for the
scenario because error recovery does not usually go through
the reset flow.

>> The point of nvme_stop_ctrl is to quiesce everything before
>> moving forward with tearing down the controller instead of
>> trying to handle concurrent incoming I/O.
>>
>> I'm not sure I understand why you say that I/O can only be
>> completed when the reset is done? if the transport entered
> 
> Please see nvme_rdma_teardown_io_queues(), in which each in-flight
> request is canceled via nvme_cancel_request(), which just calls
> nvme_complete_rq() to requeue request(normal IO) to blk-mq sw queue
> or scheduler queue.

I'm pretty familiar with what nvme_rdma_teardown_io_queues() is
doing.

> During reset, block request queues are quiesced, so the requeued
> requests can't be dispatched to nvme driver until reset is done.

That's fine, they have no reason to be dispatched until the reset
is done, it has no chance to complete.

> That is why all normal I/O can only be completed after reset is done.

I'm still not getting your point, resets should be able to complete 
without pending I/Os to complete with a failed status.
That is why I want to see the tickets details, I want to understand
what is the issue that this solves.

>> a failed state either the inflight I/O is drain or one of
>> the scan work I/O operations times out.
> 
> Timeout only works for in-flight request, as mentioned above,
> all these requests are canceled and put back into blk-mq sw queue
> or scheduler queue during reset, so timeout handler can't cover
> them at all.

Its not supposed to. This patch says it specifically addresses the scan
work.

I think you need to explain your patch better to get across exactly
what it is fixing.
