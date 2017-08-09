From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 9 Aug 2017 11:21:38 -0500
Subject: Flush warning
In-Reply-To: <003401d30f91$c7e2a3f0$57a7ebd0$@opengridcomputing.com>
References: <016301d30c86$e7034ae0$b509e0a0$@opengridcomputing.com>
 <9bc142de-b8ba-acb6-5ea1-2ccdbb578655@grimberg.me>
 <003401d30f91$c7e2a3f0$57a7ebd0$@opengridcomputing.com>
Message-ID: <00ff01d3112b$94142350$bc3c69f0$@opengridcomputing.com>

> 
> > > The WARNING seems to be due to nvmet_rdma_queue_connect() calling
> > > flush_scheduled_work() while in the upcall from the RDMA_CM.  It I running
> on
> > > the iw_cm event workqueue, which is created with WQ_MEM_RECLAIM set.
> I'm
> > not
> > > sure what this WARNING is telling me.  Does the iw_cm workqueue NOT need
> > > WQ_MEM_RECLAIM set?  Or is there some other issue with the nvmet/rdma
> > code doing
> > > work flushing in the iw_cm workq context?
> >
> > This flush is designed to prevent nvmet-rdma from having too much
> > inflight resources in case of a high pace of controller teardown and
> > establishment (like you trigger in your test).
> >
> > queue teardowns are run on system_wq, does iw_cm needs memory
> > reclamation protection?
> 
> I don't know.  I read the workqueue doc on WQ_MEM_RECLAIM, but I don't know
> how
> to tell if iw_cm needs this or not.  Can you give me an example of a workqueue
> that _does_ need WQ_MEM_RECLAIM?  I _think_ it means your workqueue is
> required
> to run something that would get triggered by the oom OS code, but I don't know
> if that would include rdma CMs or not...

Many of the workqueues in infiniband/core use WQ_MEM_RECLAIM: cma, iwcm, mad,
multicast, sa_query, and ucma. 

Hey Sean, do you have any insight into whether the CMA modules really need
WQ_MEM_RECLAIM for their workqueues?

Does anyone else know?

Thanks!

Steve.
