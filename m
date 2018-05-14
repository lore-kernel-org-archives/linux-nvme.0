From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 14 May 2018 06:38:49 -0700
Subject: [PATCH] nvme: fix lockdep warning in nvme_mpath_clear_current_path
In-Reply-To: <20180514125725.uobtf2nf4corisea@linux-x5ow.site>
References: <20180514121312.13624-1-jthumshirn@suse.de>
 <20180514124230.GA654@infradead.org>
 <20180514125725.uobtf2nf4corisea@linux-x5ow.site>
Message-ID: <20180514133849.GV26088@linux.vnet.ibm.com>

On Mon, May 14, 2018@02:57:25PM +0200, Johannes Thumshirn wrote:
> On Mon, May 14, 2018@05:42:30AM -0700, Christoph Hellwig wrote:
> > >  extern unsigned int nvme_io_timeout;
> > >  #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
> > > @@ -454,7 +455,9 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
> > >  {
> > >  	struct nvme_ns_head *head = ns->head;
> > >  
> > > -	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
> > > +	if (head &&
> > > +	    ns == rcu_dereference_protected(head->current_path,
> > > +				lockdep_is_held(&ns->ctrl->subsys->lock)))
> > >  		rcu_assign_pointer(head->current_path, NULL);
> > >  }
> > >  struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
> > 
> > We don't really dereference it at all in fact, but just check the
> > pointers for equality.  I wonder if there is a better way to do this,
> > as my ANA patches add a caller without the lock (and withou SRU
> > protection either now that I think of it) - for a pure pointer compare
> > we really should not need any sort of protection.
> 
> Uff maybe, but are you sure a comparison of two pointer is always
> atomic (on all architectures)?
> 
> Paul, can you shed some light on us mere mortal, whether the above
> rcu_dereference_protected() is needed or if a simple ns ==
> head->current_path is sufficient.

One approach is the following:

static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
{
	struct nvme_ns_head *head = ns->head;
 
	if (head && ns == rcu_access_pointer(head->current_path))
		rcu_assign_pointer(head->current_path, NULL);
}

Without the rcu_access_pointer(), sparse (and thus the 0-day test robot)
will complain that you are accessing an RCU-protected pointer without
using RCU.  However, rcu_access_pointer() won't ever give any lockdep
splats about there being no RCU read-side critical section.

You might still want rcu_dereference_protected() because it will yell
at you if the lock is not held.  Yes, the comparison will still be valid
without the lock (at least at the exact moment when the load occurred),
but the rcu_assign_pointer() might be a bit problematic if that lock is
not held, right?

But it is your guys' code, so I must defer to you for the intent.

							Thanx, Paul
