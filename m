From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 19 Sep 2016 10:38:46 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <8fc2cefe-76b6-b0a3-12af-701833c286f7@grimberg.me>
References: <021401d20a16$ed60d470$c8227d50$@opengridcomputing.com>
 <021501d20a19$327ba5b0$9772f110$@opengridcomputing.com>
 <00ab01d20ab1$ed212ff0$c7638fd0$@opengridcomputing.com>
 <022701d20d31$a9645850$fc2d08f0$@opengridcomputing.com>
 <da2e918b-0f18-e032-272d-368c6ec49c62@grimberg.me>
 <011501d20f5f$b94e6c80$2beb4580$@opengridcomputing.com>
 <012001d20f63$5c8f7490$15ae5db0$@opengridcomputing.com>
 <01d201d20f69$449abce0$cdd036a0$@opengridcomputing.com>
 <020001d20f70$9998fde0$cccaf9a0$@opengridcomputing.com>
 <02c001d20f93$e6a88a60$b3f99f20$@opengridcomputing.com>
 <20160916110412.GC5476@lst.de>
 <8fc2cefe-76b6-b0a3-12af-701833c286f7@grimberg.me>
Message-ID: <02db01d2128b$e9244c70$bb6ce550$@opengridcomputing.com>

> >> This stack is creating hctx queues for the namespace created for this
target
> >> device.
> >>
> >> Sagi,
> >>
> >> Should nvme_rdma_error_recovery_work() be stopping the hctx queues for
> >> ctrl->ctrl.connect_q too?
> >
> > Oh.  Actually we'll probably need to take care of the connect_q just
> > about anywhere we do anything to the other queues..
> 
> Why should we?
> 
> We control the IOs on the connect_q (we only submit connect to it) and
> we only submit to it if our queue is established.
> 
> I still don't see how this explains why Steves is seeing bogus
> queue/hctx mappings...

I don't think I'm seeing bogus mappings necessarily.  I think my debug code
uncovered (to me at least) that connect_q hctx's use the same nvme_rdma_queues
as the ioq hctxs.   And I thought that was not a valid configuration, but
apparently its normal.  So I still don't know how/why a pending request gets run
on an nvme_rdma_queue that has blown away its rdma qp and cm_id.  It _could_ be
due to queue/hctx bogus mappings, but I haven't proven it.  I'm not sure how to
prove it (or how to further debug this issue)...
