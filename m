From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Jun 2017 11:53:58 +0300
Subject: NVMeoF: multipath stuck after bringing one ethernet port down
In-Reply-To: <20170605084037.GB22677@lst.de>
References: <CAK0KL7DPLw+0AB8cGop7jowfE1HV9wyXBmJhE90trpor-PcSYw@mail.gmail.com>
 <ebb7ffb8-4dec-5540-5cef-ffd36bef3e25@grimberg.me>
 <fa6277fa-948f-103e-1322-f8b2362467c3@gmail.com>
 <656fd267-1e01-b561-fc74-e36c1892d1f9@gmail.com>
 <5b5b0a61-41cc-8018-19db-f683a604d7e4@grimberg.me>
 <48b14a96-e419-f6d1-090e-cbe774139e11@mellanox.com>
 <459af627-3918-768e-c35f-3f99768b82cb@grimberg.me>
 <20170605084037.GB22677@lst.de>
Message-ID: <d249a6d7-ae57-f9a1-e423-659cfa47c764@grimberg.me>


>> [PATCH] nvme-rdma: fast fail incoming requests while we reconnect
>>
>> When we encounter an transport/controller errors, error recovery
>> kicks in which performs:
>> 1. stops io/admin queues
>> 2. moves transport queues out of LIVE state
>> 3. fast fail pending io
>> 4. schedule periodic reconnects.
>>
>> But we also need to fast fail incoming IO taht enters after we
>> already scheduled. Given that our queue is not LIVE anymore, simply
>> restart the request queues to fail in .queue_rq
> 
> But we shouldn't _fail_ I/O just because we're reconnecting, we
> need to be able to retry it once reconnected.

I'm not sure, the point is to fail fast so that dm or user can
failover traffic. Besides, we iterate and cancel all inflight IO, this
attempts to give the same treatment to IO that arrives later...

In several scsi transports, we have the concept of fast_io_fail_tmo
which we could add to nvme, but from my experience, people usually set
it to a minimum to achieve fast failover (usually smaller than the very
first reconnect attempt).

We have nvme_max_retries modparam, so we could simply fail it fast until
we hit this modparam, but I suspect it'll expire very fast.

> 
>> +                   cmd->fabrics.fctype != nvme_fabrics_type_connect) {
>> +                       if (queue->ctrl->ctrl->state ==
>> NVME_CTRL_RECONNECTING)
>> +                               return -EIO;
>> +                       else
>> +                               return -EAGAIN;
>> +               }
> 
> So this looks somewhat bogus to me, while the rest looks ok.

The point here is that RECONNECTING is a ctrl state that has a
potential to linger for a long time (unlike RESETTING or DELETING),
so we don't want to trigger requeue right away.

I'm open to other ideas. I just want to prevent triggering a redundant
loop of queue_rq -> fail with BUSY -> queue_rq -> fail with BUSY ...

Thoughts?
