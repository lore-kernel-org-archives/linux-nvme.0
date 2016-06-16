From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 16 Jun 2016 11:41:59 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <012a01d1c7e3$31c08820$95419860$@opengridcomputing.com>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org>
 <012a01d1c7e3$31c08820$95419860$@opengridcomputing.com>
Message-ID: <017b01d1c7ee$008d7730$01a86590$@opengridcomputing.com>

> >
> > On Thu, Jun 16, 2016@09:53:45AM -0500, Steve Wise wrote:
> > > [11436.603807] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
> > > [11436.609866] BUG: unable to handle kernel NULL pointer dereference at
> > > 0000000000000050
> > > [11436.617764] IP: [<ffffffffa09c6dff>] nvmet_rdma_delete_ctrl+0x6f/0x100
> >
> > Can you check using gdb where in the code this is?
> >
> > This is the obvious crash we'll need to fix first.  Then we'll need to
> > figure out why the keep alive timer times out under this workload.
> >
> 
> While Yoichi is gathering this on his setup, I'm trying to reproduce it on
mine.
> I hit a similar crash by loading up a fio job, and then bringing down the
> interface of the port used on the host node, let the target timer expire, then
> bring the host interface back up.  The target freed the queues, and eventually
> the host reconnected, and the test continued.  But shortly after that I hit
this
> on the target.  It looks related:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> IP: [<ffffffffa0203b69>] nvmet_rdma_queue_disconnect+0x49/0x90 [nvmet_rdma]
> PGD 102f0d1067 PUD 102ccc5067 PMD 0
> Oops: 0002 [#1] SMP

Your patch you sent out seems to resolve my crash.  We'll see if Yoichi has the
same results.

Steve.
