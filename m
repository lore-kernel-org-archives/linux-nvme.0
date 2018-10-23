From: johannes@sipsolutions.net (Johannes Berg)
Date: Tue, 23 Oct 2018 21:22:57 +0200
Subject: [PATCH RFC] nvmet-rdma: use a private workqueue for delete
In-Reply-To: <0d62caa5-28ec-593b-7537-c27c8260366a@grimberg.me>
 (sfid-20181023_024040_093368_2E475D06)
References: <20180927180031.10706-1-sagi@grimberg.me>
 <CAO+b5-oBVw=-wvnWk1EF=RBaZtjX6bjUG+3WABXbvzX9UTu26w@mail.gmail.com>
 <9716592b-6175-600d-c1a1-593cd3145b39@grimberg.me>
 <1539966212.81977.53.camel@acm.org>
 <972d73ea2043fe755e9a5d9be649bb15a88378e7.camel@sipsolutions.net>
 <0d62caa5-28ec-593b-7537-c27c8260366a@grimberg.me>
 (sfid-20181023_024040_093368_2E475D06)
Message-ID: <a0d857b4bd5c7da86c7496dfaddb69c7f85fefec.camel@sipsolutions.net>

On Mon, 2018-10-22@17:40 -0700, Sagi Grimberg wrote:
> > > > 
> I'm not sure how I can divide them into classes. The priv is really
> an internal structure that surrounds a connection connection
> representation. The priv->handler_mutex wraps every event handling
> dispatched to the upper layer consumer.
> 
> The connection destruction barriers by acquiring and releasing this
> event_handler mutex such that no events are handled by the
> 
> See drivers/infiniband/core/cma.c rdma_destroy_id()
> 
> In our case, one of the event handlers flushes a workqueue that
> is hosting work items that essentially call rdma_destroy_id() on
> connections that are guaranteed not to be the one currently handling
> the event. So the priv is guaranteed to be a different instance.

I think the key here would be "are guaranteed not to be the one
currently handling the event". How exactly is that guaranteed?

Is there some sort of static guarantee for this?

But I guess the easiest thing to do would be to use mutex_lock_nested()
in some places here, or add something like flush_workqueue_nested().
That would let you annotate this place in the code, basically saying -
yes, I know I'm doing

CPU0			CPU1
mutex_lock(A)		start_work(B)
flush_work(B)		  mutex_lock(A)

but it's fine because I know, in this specific instance, that it's
really A' not A for the mutex. So if you were to do
	mutex_lock_nested(A, SINGLE_DEPTH_NESTING)
around the flush_work() - since your code knows that the flush_work() is
actually a different item and guaranteed to not build a graph connecting
back to itself, that should work to tell lockdep enough to not complain
here.

If this could actually recurse, but not to itself, you'd have to bump
the level up each time - which does get difficult since you're executing
asynchronously with the work queue. Not sure off the top of my head how
I'd solve that.

johannes
