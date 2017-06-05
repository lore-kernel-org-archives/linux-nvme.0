From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Jun 2017 10:40:37 +0200
Subject: NVMeoF: multipath stuck after bringing one ethernet port down
In-Reply-To: <459af627-3918-768e-c35f-3f99768b82cb@grimberg.me>
References: <CAK0KL7DPLw+0AB8cGop7jowfE1HV9wyXBmJhE90trpor-PcSYw@mail.gmail.com>
 <ebb7ffb8-4dec-5540-5cef-ffd36bef3e25@grimberg.me>
 <fa6277fa-948f-103e-1322-f8b2362467c3@gmail.com>
 <656fd267-1e01-b561-fc74-e36c1892d1f9@gmail.com>
 <5b5b0a61-41cc-8018-19db-f683a604d7e4@grimberg.me>
 <48b14a96-e419-f6d1-090e-cbe774139e11@mellanox.com>
 <459af627-3918-768e-c35f-3f99768b82cb@grimberg.me>
Message-ID: <20170605084037.GB22677@lst.de>

On Tue, May 30, 2017@05:17:40PM +0300, Sagi Grimberg wrote:
> [PATCH] nvme-rdma: fast fail incoming requests while we reconnect
>
> When we encounter an transport/controller errors, error recovery
> kicks in which performs:
> 1. stops io/admin queues
> 2. moves transport queues out of LIVE state
> 3. fast fail pending io
> 4. schedule periodic reconnects.
>
> But we also need to fast fail incoming IO taht enters after we
> already scheduled. Given that our queue is not LIVE anymore, simply
> restart the request queues to fail in .queue_rq

But we shouldn't _fail_ I/O just because we're reconnecting, we
need to be able to retry it once reconnected.

> +                   cmd->fabrics.fctype != nvme_fabrics_type_connect) {
> +                       if (queue->ctrl->ctrl->state == 
> NVME_CTRL_RECONNECTING)
> +                               return -EIO;
> +                       else
> +                               return -EAGAIN;
> +               }

So this looks somewhat bogus to me, while the rest looks ok.
