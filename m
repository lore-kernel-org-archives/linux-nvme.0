From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 14 May 2018 06:31:05 -0700
Subject: [PATCH] nvme: fix lockdep warning in nvme_mpath_clear_current_path
In-Reply-To: <20180514124230.GA654@infradead.org>
References: <20180514121312.13624-1-jthumshirn@suse.de>
 <20180514124230.GA654@infradead.org>
Message-ID: <20180514133105.GU26088@linux.vnet.ibm.com>

On Mon, May 14, 2018@05:42:30AM -0700, Christoph Hellwig wrote:
> >  extern unsigned int nvme_io_timeout;
> >  #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
> > @@ -454,7 +455,9 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
> >  {
> >  	struct nvme_ns_head *head = ns->head;
> >  
> > -	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
> > +	if (head &&
> > +	    ns == rcu_dereference_protected(head->current_path,
> > +				lockdep_is_held(&ns->ctrl->subsys->lock)))
> >  		rcu_assign_pointer(head->current_path, NULL);
> >  }
> >  struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
> 
> We don't really dereference it at all in fact, but just check the
> pointers for equality.  I wonder if there is a better way to do this,
> as my ANA patches add a caller without the lock (and withou SRU
> protection either now that I think of it) - for a pure pointer compare
> we really should not need any sort of protection.

If you are just looking at the value of an RCU-protected pointer, then
using rcu_access_pointer() will cause RCU to just read out the value
and otherwise keeps its mouth shut.

If you use rcu_access_pointer() and later dereference the value without
protection, you will of course get what you deserve, good and hard.  ;-)

							Thanx, Paul
