From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 28 Jun 2016 11:31:27 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <20160628155159.GA3084@lst.de>
References: <576306EE.4020306@grimberg.me>
 <01b901d1c80b$72f83680$58e8a380$@opengridcomputing.com>
 <CAF1ivSYUG4c7Ej-gNqA=aPFR2zkNq8KhBoodhp64wdY=eQLx6g@mail.gmail.com>
 <01c101d1c80d$96d13c80$c473b580$@opengridcomputing.com>
 <20160616203437.GA19079@lst.de>
 <01e701d1c810$91d851c0$b588f540$@opengridcomputing.com>
 <020201d1c812$ec94b430$c5be1c90$@opengridcomputing.com>
 <1467066582.7205.7.camel@ssi> <20160628091433.GA14149@lst.de>
 <005001d1d147$81cd8cb0$8568a610$@opengridcomputing.com>
 <20160628155159.GA3084@lst.de>
Message-ID: <01dc01d1d15a$84f42670$8edc7350$@opengridcomputing.com>

> On Tue, Jun 28, 2016@09:15:22AM -0500, Steve Wise wrote:
> > I'm not so sure.  I don't see where nvmet leaves unsignaled wrs on the SQ.
> > It either posts chains via RDMA-RW and the last in the chain is always
> > signaled (I think), or it posts signaled IO responses.
> 
> Indeed.  So we need to figure out where we don't release a rsp.
> 

Hey Ming, 

For what its worth, the change you proposed in this thread isn't working for me.
I see maybe one or two recoveries successful, then the target gets stuck.  I see
several workq threads stuck destroying various qps, one thread stuck draining a
qp.  If this change is not the proper fix, then I'm not going to debug this
further.
