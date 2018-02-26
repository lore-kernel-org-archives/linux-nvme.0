From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 26 Feb 2018 14:46:24 +0200
Subject: v4.16-rc2 nvme_rdma ib_destroy_qp() warns about MRs
In-Reply-To: <d3e62a90-4a0b-fee0-7c78-5bd6e4dbab52@mellanox.com>
References: <1519431811.2904.52.camel@wdc.com>
 <7b1527ec-8c2f-6bc6-37f8-56053882b328@grimberg.me>
 <ca148f27-1b59-02a2-fc76-ee3e9a7edeb3@grimberg.me>
 <d3e62a90-4a0b-fee0-7c78-5bd6e4dbab52@mellanox.com>
Message-ID: <fe539ebe-68df-0f4a-11c3-7ef7990b2345@grimberg.me>

> hi Sagi,

Hi Max,

> I tried this patch but it still doesn't fix the issue.
> this is the same issue I reported and discussed with Ming:
> https://www.mail-archive.com/linux-block at vger.kernel.org/msg18559.html

Didn't follow the thread, wasn't CC'd on it.

> we must somehow drain the commands that were pushed between 
> blk_mq_quiesce_queue to blk_mq_unquiesce_queue. The timeout expires 
> after we destroy the QP and there are MR missing in the pool.

Its a bug if .queue_rq is being invoked when the queue is quiesced. Have
you actually seen this happen? IFF this is really happening, we can stop
the rdma queues before we iterate on started requests (see a patch I
suggested to Alon). With this, even requests that sneak in when the
queues are quiesced will fail on nvme_rdma_is_ready(). but as said,
I'm surprised this is even happening.
