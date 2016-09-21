From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 21 Sep 2016 09:18:04 -0500
Subject: [PATCH] nvme-rdma: Fix early queue flags settings
In-Reply-To: <20160921140132.GA19942@lst.de>
References: <1474397848-19013-1-git-send-email-sagi@grimberg.me>
 <20160920200803.GA839@lst.de>
 <013901d2137b$8f329e10$ad97da30$@opengridcomputing.com>
 <a46d0da7-0695-3745-1bc9-8faf4383fa19@grimberg.me>
 <20160921140132.GA19942@lst.de>
Message-ID: <003101d21412$f9c59c90$ed50d5b0$@opengridcomputing.com>

> >
> > I can modify the change log, Christoph do you still want a
> > comment in the code?
> 
> Honestly there more I look into this the less I'm happy with the patch.
> queue->flags is an atomic, and as the patch shows we can get
> nvme_rdma_init_queue caled on a queue that still has visibility in
> other threads  So I think we really should not even do that simple
> queue->flags = 0 assignment at all.  We'll need to use clear_bit to
> atomically clear anything that might be set, and we need to be careful
> where we do that.  I think this whole situation that we can get an
> *_init_* function called on something that already is live and visible
> to other threads need to be well documented at least because it's just
> waiting for sucker like me that don't expect that.


Sagi, you originally proposed this in a patch for debugging the crash where
a request is accessing a queue with rdma resources freed:

@@ -542,11 +542,12 @@ static int nvme_rdma_create_queue_ib(struct 
nvme_rdma_queue *queue,
                 goto out_destroy_qp;
         }
         set_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags);
+       clear_bit(NVME_RDMA_Q_DELETING, &queue->flags);

         return 0;


Perhaps this is how we should proceed?
