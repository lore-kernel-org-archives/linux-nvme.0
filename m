From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 28 Jun 2016 09:15:22 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <20160628091433.GA14149@lst.de>
References: <5763044A.9090206@grimberg.me>
 <01b501d1c809$92cb1a60$b8614f20$@opengridcomputing.com>
 <576306EE.4020306@grimberg.me>
 <01b901d1c80b$72f83680$58e8a380$@opengridcomputing.com>
 <CAF1ivSYUG4c7Ej-gNqA=aPFR2zkNq8KhBoodhp64wdY=eQLx6g@mail.gmail.com>
 <01c101d1c80d$96d13c80$c473b580$@opengridcomputing.com>
 <20160616203437.GA19079@lst.de>
 <01e701d1c810$91d851c0$b588f540$@opengridcomputing.com>
 <020201d1c812$ec94b430$c5be1c90$@opengridcomputing.com>
 <1467066582.7205.7.camel@ssi> <20160628091433.GA14149@lst.de>
Message-ID: <005001d1d147$81cd8cb0$8568a610$@opengridcomputing.com>

> > diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> > index 425b55c..627942c 100644
> > --- a/drivers/nvme/target/rdma.c
> > +++ b/drivers/nvme/target/rdma.c
> > @@ -425,7 +425,15 @@ static void nvmet_rdma_free_rsps(struct
> nvmet_rdma_queue *queue)
> >  	for (i = 0; i < nr_rsps; i++) {
> >  		struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
> >
> > -		list_del(&rsp->free_list);
> > +		/*
> > +		 * Don't call "list_del(&rsp->free_list)", because:
> > +		 * It could be already removed from the free list by
> > +		 * nvmet_rdma_get_rsp(), or it's on the queue::rsp_wait_list
> > +		 *
> > +		 * It's safe we just free it because at this point the queue
> > +		 * was already disconnected so nvmet_rdma_get_rsp() won't be
> > +		 * called any more.
> > +		 */
> >  		nvmet_rdma_free_rsp(ndev, rsp);
> >  	}
> >  	kfree(queue->rsps);
> 
> That seems like another symptom of not flushing unsignalled requests.

I'm not so sure.  I don't see where nvmet leaves unsignaled wrs on the SQ.  It
either posts chains via RDMA-RW and the last in the chain is always signaled (I
think), or it posts signaled IO responses.

> At the time we call nvmet_rdma_free_rsps none of the rsp structures
> should be in use.
