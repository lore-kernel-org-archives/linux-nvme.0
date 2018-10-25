From: johannes@sipsolutions.net (Johannes Berg)
Date: Thu, 25 Oct 2018 23:05:52 +0200
Subject: [PATCH 1/2] nvmet-rdma: Avoid that
 nvmet_rdma_release_queue_work() triggers a lockdep complaint
In-Reply-To: <20181025151940.388-2-bvanassche@acm.org>
References: <20181025151940.388-1-bvanassche@acm.org>
 <20181025151940.388-2-bvanassche@acm.org>
Message-ID: <93a3139c6f66cc8a9fa38a1b52309f501c98233e.camel@sipsolutions.net>

Hi,

Yes, you said to ignore this, but I'm looking at the lockdep report
again anyway ...

So ... if I understand this correctly, we have:

cma's id_priv->handler_mutex    - a listen_id's mutex
cma's id_priv->handler_mutex/1  - a conn_id's mutex
queue                           - an RDMA queue, belonging to ...?
nvmet-rdma-delete-wq            - the global deletion workqueue

In cma_ib_req_handler(), we create a dependency from
	handler_mutex -> handler_mutex/1
since we lock both of them (here's the "real _nested()" part).

While holding those, we call the event handler, which is
nvmet_rdma_cm_handler. This, via nvmet_rdma_queue_connect, flushes the
workqueue, creating that dependency.

Obviously, queue->release_work has a dependency to the workqueue since
it runs on there.

Finally, the queue->release_work calls rdma_destroy_id() which locks the
destroyed id_priv's mutex.

Does that about seem right?

I'm not sure I see a solution right now. If you were to replace the
workqueue by a list of objects to be destroyed and then iterate it where
you have the flush_workqueue() now (*), you'd end up with a very similar
lockdep report I think, so it's not inherent in the lockdep workqueue
annotations, it's inherent in locking some object(s) while holding the
same class of lock for another object. This would be a pretty typical
case of mutex_lock_nested(), but it's hard to do across the layers here,
and pretty much impossible to do across the workqueue.

I'd usually solve that sort of problem by flushing/iterating before
taking all the locks, since it's a different object anyway, but given
the two layers here that doesn't seem feasible either.

(*) of course in addition to iterating it in some thread, or work
struct, or something else asynchronous

I think again you could suppress this by using flush_workqueue_nested()
here, basically saying that while it's the same workqueue, it cannot
actually connect back to itself locking-wise due to being guaranteed to
have different objects on it... I think, but it's getting late here.

johannes
