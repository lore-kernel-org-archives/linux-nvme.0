From: hch@lst.de (Christoph Hellwig)
Date: Thu, 5 Apr 2018 21:55:12 +0200
Subject: [PATCH] nvme: fix flush dependency in delete controller flow
In-Reply-To: <20180405160852.GA11416@linux.vnet.ibm.com>
References: <20180402123727.3961-1-nitzanc@mellanox.com>
 <20180405085438.GC2286@lst.de> <20180405131426.GL3948@linux.vnet.ibm.com>
 <20180405160852.GA11416@linux.vnet.ibm.com>
Message-ID: <20180405195512.GA12678@lst.de>

On Thu, Apr 05, 2018@09:08:52AM -0700, Paul E. McKenney wrote:
> > But if this SRCU use case doesn't ever invoke call_srcu(), I
> > -think- that shouldn't need to do the flush_delayed_work() calls in
> > cleanup_srcu_struct().  I think.  It is a bit early out here, so I don't
> > trust myself on this one just now, and need to take another look when
> > fully awake.
> > 
> > But in the meantime, is it really the case that this SRCU use case never
> > ever invokes call_srcu()?

We never use call_srcu().

> And I can do a bit better than this.  I could provide something like a
> cleanup_srcu_struct_quiesced() that would avoid blocking if the caller had
> quiesced it.  Here, to quiesce is to make sure that any synchronize_srcu()
> or synchronize_srcu_expedited() calls have returned before the call to
> cleanup_srcu_struct_quiesced(), and that any callbacks from call_srcu()
> have completed.  Of course, srcu_barrier() could be used to wait for
> the callbacks from earlier call_srcu().
> 
> Would something like this help?

Yes.  Note that blocking isn't even the problem, just the flush_work.
But not blocking at all would be fine of course.

The pattern in nvme is that we have a struct nvme_ns_head, which has a
list of struct nvme_ns structures hanging off it.  We use SRCU to protect
lookups in said list.  We call synchronize_srcu after removing a nvme_ns
from the list in struct nvme_ns_head and nowhere else.  A struct
nvme_ns_head is freed (and we thus call cleanup_srcu_struct) once the
reference count on it hits zero, which can only happen after the last
nvme_ns has been removed from the list.

I suspect this might be a common patter in other parts of the kernel as
well.
