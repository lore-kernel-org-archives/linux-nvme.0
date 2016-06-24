From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 24 Jun 2016 09:05:05 -0500
Subject: [PATCH] nvme-rdma: Always signal fabrics private commands
In-Reply-To: <20160624070740.GB4252@infradead.org>
References: <1466698104-32521-1-git-send-email-sagi@grimberg.me>
 <20160624070740.GB4252@infradead.org>
Message-ID: <003401d1ce21$6880f720$3982e560$@opengridcomputing.com>

> On Thu, Jun 23, 2016@07:08:24PM +0300, Sagi Grimberg wrote:
> > Some RDMA adapters were observed to have some issues
> > with selective completion signaling which might cause
> > a use-after-free condition when the device accidentally
> > reports a completion when the caller context (wr_cqe)
> > was already freed.
> 
> I'd really love to fully root cause this issue and find a way
> to fix it in the driver or core.  This isn't really something
> a ULP should have to care about, and I'm trying to understand how
> the existing ULPs get away without this.
>

Haven't we root caused it?  iw_cxgb4 cannot free up SQ slots containing
unsignaled WRs until a subsequent signaled WR is completed and polled by the
ULP.  If the QP is moved out of RTS before that happens thyen the unsignaled WRs
are completed as FLUSHED.  And NVMF is not ensuring that for all unsignaled WRs,
the wr_cqe remains around until the qp is flushed. 

>From a quick browse of the ULPS that support iw_cxgb4, it looks like NFSRDMA
server always signals, and NFSRDMA client always posts chains that end in a
signaled WR (not 100% sure on this).  iser does control its signaling, and it
perhaps suffers from the same problem.  But the target side has only now become
enabled for iwarp/cxgb4, so we'll see if we hit the same problems.  It appears
isert always signals.  

> I think we should apply this anyway for now unless we can come up
> woth something better, but I'm not exactly happy about it.
> 
> > The first time this was detected was for flush requests
> > that were not allocated from the tagset, now we see that
> > in the error path of fabrics connect (admin). The normal
> > I/O selective signaling is safe because we free the tagset
> > only when all the queue-pairs were drained.
> 
> So for flush we needed this because the flush request is allocated
> as part of the hctx, but pass through requests aren't really
> special in terms of allocation.  What's the reason we need to
> treat these special?

Perhaps it is just avoiding the problem by nature of being a signaled WR causing
iw_cxgb4 to now know the unsignaled WRs are complete...

I'm happy to help with guidance.  I'm not very familiar with the NVMF code above
its use of RDMA though.  And my solutions to try and fix this have all been
considered incorrect. :)
