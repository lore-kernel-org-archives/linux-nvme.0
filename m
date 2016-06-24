From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 Jun 2016 00:07:40 -0700
Subject: [PATCH] nvme-rdma: Always signal fabrics private commands
In-Reply-To: <1466698104-32521-1-git-send-email-sagi@grimberg.me>
References: <1466698104-32521-1-git-send-email-sagi@grimberg.me>
Message-ID: <20160624070740.GB4252@infradead.org>

On Thu, Jun 23, 2016@07:08:24PM +0300, Sagi Grimberg wrote:
> Some RDMA adapters were observed to have some issues
> with selective completion signaling which might cause
> a use-after-free condition when the device accidentally
> reports a completion when the caller context (wr_cqe)
> was already freed.

I'd really love to fully root cause this issue and find a way
to fix it in the driver or core.  This isn't really something
a ULP should have to care about, and I'm trying to understand how
the existing ULPs get away without this.

I think we should apply this anyway for now unless we can come up
woth something better, but I'm not exactly happy about it.

> The first time this was detected was for flush requests
> that were not allocated from the tagset, now we see that
> in the error path of fabrics connect (admin). The normal
> I/O selective signaling is safe because we free the tagset
> only when all the queue-pairs were drained.

So for flush we needed this because the flush request is allocated
as part of the hctx, but pass through requests aren't really
special in terms of allocation.  What's the reason we need to
treat these special?
