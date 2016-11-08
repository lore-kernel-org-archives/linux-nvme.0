From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 8 Nov 2016 08:56:50 -0600
Subject: host/target keep alive timeout loop
In-Reply-To: <ff2610d1-164f-d85e-839e-b91344192041@grimberg.me>
References: <056f01d2394e$ea77ae70$bf670b50$@opengridcomputing.com>
 <057401d2394f$0b6195b0$2224c110$@opengridcomputing.com>
 <ff2610d1-164f-d85e-839e-b91344192041@grimberg.me>
Message-ID: <007901d239d0$561eb700$025c2500$@opengridcomputing.com>

 
> > Hey Sagi/Christoph,
> >
> > While running the same kato/recovery tests I've logged in a few other
threads,
> > occasionally I get some controllers on the host that will not reconnect.
Even
> > after I quiesce the test and have the interfaces up and everything is
pingable.
> > When it gets in this state, some of the 10 controllers are up and ok, and
others
> > are stuck in this reconnect/fail loop.
> >
> > The host is stuck continually logging this for one or more controllers:
> >
> > [ 7885.617176] nvme nvme10: failed nvme_keep_alive_end_io error=16385
> > [ 7886.837087] nvme nvme10: rdma_resolve_addr wait failed (-110).
> > [ 7890.183979] nvme nvme10: failed to initialize i/o queue: -110
> > [ 7890.247538] nvme nvme10: Failed reconnect attempt, requeueing...
> 
> This looks like an underlying problem causing the host rdma_connect
> to timeout. Did it happen before or is it a new thing?

I can't say for sure, since until Christoph's recent fix, it was crashing in
other ways.   I don't think the connection is failing at the driver level, but
I'll look into the stats for cxgb4 when it is in this state to see what is
happening at that level.   
