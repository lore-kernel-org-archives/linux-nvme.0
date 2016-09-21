From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Sep 2016 07:36:10 -0700
Subject: [PATCH] nvme-rdma: Fix early queue flags settings
In-Reply-To: <20160921140132.GA19942@lst.de>
References: <1474397848-19013-1-git-send-email-sagi@grimberg.me>
 <20160920200803.GA839@lst.de>
 <013901d2137b$8f329e10$ad97da30$@opengridcomputing.com>
 <a46d0da7-0695-3745-1bc9-8faf4383fa19@grimberg.me>
 <20160921140132.GA19942@lst.de>
Message-ID: <5895eaad-a0e3-20be-f3e2-d4a02d4b8bfa@grimberg.me>

>>> Maybe this changelog?
>>>
>>>     nvme-rdma: only clear queue flags after successful connect
>>>
>>>     Otherwise, nvme_rdma_stop_and_clear_queue() will incorrectly
>>>     try to stop/free rdma qps/cm_ids that are already freed.
>>
>> I can modify the change log, Christoph do you still want a
>> comment in the code?
>
> Honestly there more I look into this the less I'm happy with the patch.

I agree that we should really do a proper queue state machine.

> queue->flags is an atomic, and as the patch shows we can get
> nvme_rdma_init_queue caled on a queue that still has visibility in
> other threads  So I think we really should not even do that simple
> queue->flags = 0 assignment at all.  We'll need to use clear_bit to
> atomically clear anything that might be set, and we need to be careful
> where we do that.  I think this whole situation that we can get an
> *_init_* function called on something that already is live and visible
> to other threads need to be well documented at least because it's just
> waiting for sucker like me that don't expect that.

I don't think its a multithreading issue. We aren't expected to get
here concurrently from different contexts (I think we're screwed if we
do). The issue was that we are not clearing the DELETING flag on 
reconnects causing possible leaks, then I "fixed" it by resetting the
queue flags at init_queue start, the problem was that if we failed to
init the queue we lost the DELETING flag and got to a use-after-free
condition (nothing prevented stop_and_free_queue to make forward
progress...

I can move it to clear_bit if you want...
