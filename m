From: paulmck@linux.ibm.com (Paul E. McKenney)
Date: Wed, 13 Feb 2019 11:13:26 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <20190213152413.GA4468@linux.ibm.com>
References: <20190211210808.GS4240@linux.ibm.com>
 <1549924039.19311.26.camel@acm.org>
 <20190212012422.GX4240@linux.ibm.com>
 <1549990020.19311.40.camel@acm.org>
 <20190212174715.GP4240@linux.ibm.com>
 <20190212191522.GA27391@linux.ibm.com>
 <1550018699.19311.45.camel@acm.org>
 <20190213011023.GX4240@linux.ibm.com>
 <20190213151917.GA3311@linux.ibm.com>
 <20190213152413.GA4468@linux.ibm.com>
Message-ID: <20190213191326.GA30106@linux.ibm.com>

On Wed, Feb 13, 2019@07:24:13AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 13, 2019@07:19:17AM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 12, 2019@05:10:23PM -0800, Paul E. McKenney wrote:
> > > On Tue, Feb 12, 2019@04:44:59PM -0800, Bart Van Assche wrote:
> > > > On Tue, 2019-02-12@11:15 -0800, Paul E. McKenney wrote:
> > > > > [ ... ]
> > > > > And please see below for a patch that should allow SRCU to provide
> > > > > greatly improved diagnostics for my hypothesized scenario.
> > > > > 
> > > > > ------------------------------------------------------------------------
> > > > > 
> > > > > commit 266c20cf63cdcecb3856dbc7886529082f0acaf5
> > > > > Author: Paul E. McKenney <paulmck at linux.ibm.com>
> > > > > Date:   Tue Feb 12 10:44:33 2019 -0800
> > > > > 
> > > > >     srcu: Check for in-flight callbacks in _cleanup_srcu_struct()
> > > > >     
> > > > >     If someone fails to drain the corresponding SRCU callbacks (for
> > > > >     example, by failing to invoke srcu_barrier()) before invoking either
> > > > >     cleanup_srcu_struct() or cleanup_srcu_struct_quiesced(), the resulting
> > > > >     diagnostic is an ambiguous use-after-free diagnostic, and even then
> > > > >     only if you are running something like KASAN.  This commit therefore
> > > > >     improves SRCU diagnostics by adding checks for in-flight callbacks at
> > > > >     _cleanup_srcu_struct() time.
> > > > >     
> > > > >     Note that these diagnostics can still be defeated, for example, by
> > > > >     invoking call_srcu() concurrently with cleanup_srcu_struct().  Which is
> > > > >     a really bad idea, but sometimes all too easy to do.  But even then,
> > > > >     these diagnostics have at least some probability of catching the problem.
> > > > >     
> > > > >     Reported-by: Sagi Grimberg <sagi at grimberg.me>
> > > > >     Reported-by: Bart Van Assche <bvanassche at acm.org>
> > > > >     Signed-off-by: Paul E. McKenney <paulmck at linux.ibm.com>
> > > > > 
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > index a60b8ba9e1ac..4f30f3ecabc1 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -387,6 +387,8 @@ void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
> > > > >  			del_timer_sync(&sdp->delay_work);
> > > > >  			flush_work(&sdp->work);
> > > > >  		}
> > > > > +		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
> > > > > +			return; /* Forgot srcu_barrier(), so just leak it! */
> > > > >  	}
> > > > >  	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
> > > > >  	    WARN_ON(srcu_readers_active(ssp))) {
> > > > 
> > > > Hi Paul,
> > > > 
> > > > With this patch applied I still see the KASAN use-after-free complaint but no prior
> > > > warning from inside the RCU code.
> > > 
> > > Hmmm...
> > > 
> > > I don't see how the KASAN warning could happen without srcu_struct_cleanup()
> > > or srcu_struct_cleanup_quiesced() being called.  Perhaps a failure of
> > > imagination on my part.
> > > 
> > > So does it seem plausible to you that one of those two has been called
> > > at the time the KASAN complaint is emitted?
> > 
> > After sleeping on this...
> > 
> > You are getting the KASAN warning at the same place each time?
> > 
> > This would force me to hypothesize that you are invoking
> > srcu_struct_cleanup_quiesced() from a workqueue spawned from
> > an SRCU callback.  Is that the case?
> 
> You could get the same effect by doing an synchronize_srcu() within
> a workqueue handler, come to think of it.

Which is what appears to be happening, again assuming that KASAN is
emitting its complaint at the same place each time.  Here is the
sequence of events that could explain the failure, albeit with an
unusual compilation and a surprisingly exact point of preemption:

o	nvme_ns_remove() invokes synchronize_srcu().  This causes the
	current context to sleep, and to be awakened from within an SRCU
	callback, which runs in a workqueue handler.  When this callback
	returns, srcu_invoke_callbacks() will update callback-remaining
	counts in the per-CPU data associated with the srcu_struct.
	Let's assume that SRCU's workqueue handler is delayed just as
	the callback returns.

o	nvme_ns_remove() invokes nvme_mpath_check_last_path() and then
	nvme_put_ns().

o	nvme_put_ns() does a kref_put(), and if the count is zero, kref_put()
	invokes nvme_free_ns().

o	nvme_free_ns() invokes nvme_put_ns_head(), which also does a
	kref_put(), and if the count is zero, kref_put() invokes
	nvme_free_ns_head().

o	nvme_free_ns_head() invokes cleanup_srcu_struct_quiesced(), which
	frees the per-CPU data associated with the srcu_struct.  And
	somehow avoids the WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)).

o	SRCU's workqueue handler resumes, and executes this code, which
	references the just-freed per-CPU data:

		spin_lock_irq_rcu_node(sdp);
		rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
		(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
					       rcu_seq_snap(&ssp->srcu_gp_seq));
		sdp->srcu_cblist_invoking = false;
		more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
		spin_unlock_irq_rcu_node(sdp);

	But this is surprising, as it requires rcu_segcblist_insert_count()
	to be compiled just so:

		void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
						struct rcu_cblist *rclp)
		{
			rsclp->len_lazy += rclp->len_lazy;
			/* ->len sampled locklessly. */
			WRITE_ONCE(rsclp->len, rsclp->len + rclp->len);
			rclp->len_lazy = 0;
			rclp->len = 0;
		}

	To avoid the warning patch I gave you yesterday, the compiler
	would need to reverse the first two statements, like this:

		void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
						struct rcu_cblist *rclp)
		{
			/* ->len sampled locklessly. */
			WRITE_ONCE(rsclp->len, rsclp->len + rclp->len);
			rsclp->len_lazy += rclp->len_lazy;
			rclp->len_lazy = 0;
			rclp->len = 0;
		}

	Is that happening in your build?

Regardless, this can happen.  My usual advice would be for you to invoke
cleanup_srcu_struct() instead of cleanup_srcu_struct_quiesced(), which will
wait for ongoing work associated with this srcu_struct to complete.  Is it
possible to make this change?

							Thanx, Paul
