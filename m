From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Mar 2019 19:13:31 -0700
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190318073826.GA29746@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p>
Message-ID: <7429e912-5978-91b9-bbba-75b0264596d4@grimberg.me>


>>> In NVMe's error handler, follows the typical steps for tearing down
>>> hardware:
>>>
>>> 1) stop blk_mq hw queues
>>> 2) stop the real hw queues
>>> 3) cancel in-flight requests via
>>> 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
>>> cancel_request():
>>> 	mark the request as abort
>>> 	blk_mq_complete_request(req);
>>> 4) destroy real hw queues
>>>
>>> However, there may be race between #3 and #4, because blk_mq_complete_request()
>>> actually completes the request asynchronously.
>>>
>>> This patch introduces blk_mq_complete_request_sync() for fixing the
>>> above race.
>>
>> Other block drivers wait until outstanding requests have completed by
>> calling blk_cleanup_queue() before hardware queues are destroyed. Why can't
>> the NVMe driver follow that approach?
> 
> The tearing down of controller can be done in error handler, in which
> the request queues may not be cleaned up, almost all kinds of NVMe
> controller's error handling follows the above steps, such as:
> 
> nvme_rdma_error_recovery_work()
> 	->nvme_rdma_teardown_io_queues()

Clarification, this happens in its dedicated context, not the timeout or
error handler.

But I still don't understand the issue here, what is the exact race you
are referring to? that we abort/cancel a request and then we complete
it again when we destroy the HW queue?

If so, that is not the case (at least for rdma/tcp) because
nvme_rdma_teardown_io_queues() first flushes the hw queue and then
aborts inflight I/O.
