From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 26 Jun 2016 19:41:39 +0300
Subject: [PATCH] nvme-rdma: Always signal fabrics private commands
In-Reply-To: <20160624070740.GB4252@infradead.org>
References: <1466698104-32521-1-git-send-email-sagi@grimberg.me>
 <20160624070740.GB4252@infradead.org>
Message-ID: <577005C3.4000802@grimberg.me>


>> Some RDMA adapters were observed to have some issues
>> with selective completion signaling which might cause
>> a use-after-free condition when the device accidentally
>> reports a completion when the caller context (wr_cqe)
>> was already freed.
>
> I'd really love to fully root cause this issue and find a way
> to fix it in the driver or core.
> This isn't really something a ULP should have to care about, and I'm trying to understand how
> the existing ULPs get away without this.

It's a cxgb4 specific work-around (the only device this was observed
by). Not sure how this can be addressed in the core. We could comment
that in the code.

> I think we should apply this anyway for now unless we can come up
> woth something better, but I'm not exactly happy about it.
>
>> The first time this was detected was for flush requests
>> that were not allocated from the tagset, now we see that
>> in the error path of fabrics connect (admin). The normal
>> I/O selective signaling is safe because we free the tagset
>> only when all the queue-pairs were drained.
>
> So for flush we needed this because the flush request is allocated
> as part of the hctx, but pass through requests aren't really
> special in terms of allocation.  What's the reason we need to
> treat these special?

OK heres what I think is going on. we allocate the rdma queue and
issue admin connect (unsignaled). connect fails, and we orderly
teardown the admin queue (free the tagset, put the device and free the
queue).

Due to the fact that the cxgb4 driver is responsible for flushing
pending work requests and has no way of telling what the HW processed
other than the head/tail indexes (which are probably updated at
completion time) it sees the admin connect in the send-queue, it
doesn't know if the HW did anything with it, so it flushes it anyway.

Our error path is freeing the tagset before we free the queue (draining
the qp) so we get to a use-after-free condition (->done() is a freed
tag memory).

Note that we must allocate the qp before we allocate the tagset because
we need the device when init_request callouts come. So we allocated
before, we free after. An alternative fix was to free the queue before
the tagset even though we allocated it before (as Steve suggested).
