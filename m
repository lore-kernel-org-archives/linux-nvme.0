From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Sun, 25 Feb 2018 16:18:52 +0000
Subject: nvme-rdma corrupts memory upon timeout
In-Reply-To: <CAF9HSintgS0U2X=E=_uJnU4y95HDcCUnyCKBDF_tNaDcY9pucg@mail.gmail.com>
References: <CAF9HSintgS0U2X=E=_uJnU4y95HDcCUnyCKBDF_tNaDcY9pucg@mail.gmail.com>
Message-ID: <1519575531.3291.6.camel@wdc.com>

On Sun, 2018-02-25@17:10 +0200, Alon Horev wrote:
> We think we can spot the root cause: 'nvme_rdma_error_recovery'
> handles the timeout in an asynchronous manner. It queues a task for
> reconnecting the nvme device. Until that task is executed by the
> worker thread the qp is open and a rdma write can get through. Does
> this make sense?

I think it's fine that error recovery happens asynchronously. Other drivers
(e.g. ib_srp) also use this approach. However, it seems to me that
nvme_rdma_error_recovery_work() does not wait until ongoing RDMA transfers
have finished. I think that's something that needs to be addressed. Has it
been considered to insert an ib_drain_qp() call in that function?

Another concern is that I think that there is a TOCTOU race in
nvme_cancel_request(). Has it been considered to make that function call
blk_abort_request() instead of blk_mq_request_started() +
blk_mq_complete_request()?

Thanks,

Bart.
