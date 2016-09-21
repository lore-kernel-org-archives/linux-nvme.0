From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 21 Sep 2016 10:10:14 -0500
Subject: [PATCH] nvme-rdma: Fix early queue flags settings
In-Reply-To: <005e01d21417$cb514530$61f3cf90$@opengridcomputing.com>
References: <1474397848-19013-1-git-send-email-sagi@grimberg.me>
 <20160920200803.GA839@lst.de>
 <013901d2137b$8f329e10$ad97da30$@opengridcomputing.com>
 <a46d0da7-0695-3745-1bc9-8faf4383fa19@grimberg.me>
 <20160921140132.GA19942@lst.de>
 <003101d21412$f9c59c90$ed50d5b0$@opengridcomputing.com>
 <005e01d21417$cb514530$61f3cf90$@opengridcomputing.com>
Message-ID: <007101d2141a$4179eb20$c46dc160$@opengridcomputing.com>

> > Sagi, you originally proposed this in a patch for debugging the crash
> where
> > a request is accessing a queue with rdma resources freed:
> >
> > @@ -542,11 +542,12 @@ static int nvme_rdma_create_queue_ib(struct
> > nvme_rdma_queue *queue,
> >                  goto out_destroy_qp;
> >          }
> >          set_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags);
> > +       clear_bit(NVME_RDMA_Q_DELETING, &queue->flags);
> >
> >          return 0;
> >
> >
> > Perhaps this is how we should proceed?
> 
> Just tested this, and it doesn't fix the problem.  This makes sense,
because
> we really only want to clear it if we successfully setup the connection...
> So never mind. :)

What I'm trying to say is that if you use clear_bit(), it needs to be
exactly where the flags = 0 was.

Thanks,

Steve.
