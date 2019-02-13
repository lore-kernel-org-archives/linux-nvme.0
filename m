From: paulmck@linux.ibm.com (Paul E. McKenney)
Date: Tue, 12 Feb 2019 17:10:23 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <1550018699.19311.45.camel@acm.org>
References: <1547579226.83374.114.camel@acm.org>
 <6c18d8f8-949f-9502-566a-643d384e9113@grimberg.me>
 <1549905891.19311.5.camel@acm.org>
 <20190211210808.GS4240@linux.ibm.com>
 <1549924039.19311.26.camel@acm.org>
 <20190212012422.GX4240@linux.ibm.com>
 <1549990020.19311.40.camel@acm.org>
 <20190212174715.GP4240@linux.ibm.com>
 <20190212191522.GA27391@linux.ibm.com>
 <1550018699.19311.45.camel@acm.org>
Message-ID: <20190213011023.GX4240@linux.ibm.com>

On Tue, Feb 12, 2019@04:44:59PM -0800, Bart Van Assche wrote:
> On Tue, 2019-02-12@11:15 -0800, Paul E. McKenney wrote:
> > [ ... ]
> > And please see below for a patch that should allow SRCU to provide
> > greatly improved diagnostics for my hypothesized scenario.
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 266c20cf63cdcecb3856dbc7886529082f0acaf5
> > Author: Paul E. McKenney <paulmck at linux.ibm.com>
> > Date:   Tue Feb 12 10:44:33 2019 -0800
> > 
> >     srcu: Check for in-flight callbacks in _cleanup_srcu_struct()
> >     
> >     If someone fails to drain the corresponding SRCU callbacks (for
> >     example, by failing to invoke srcu_barrier()) before invoking either
> >     cleanup_srcu_struct() or cleanup_srcu_struct_quiesced(), the resulting
> >     diagnostic is an ambiguous use-after-free diagnostic, and even then
> >     only if you are running something like KASAN.  This commit therefore
> >     improves SRCU diagnostics by adding checks for in-flight callbacks at
> >     _cleanup_srcu_struct() time.
> >     
> >     Note that these diagnostics can still be defeated, for example, by
> >     invoking call_srcu() concurrently with cleanup_srcu_struct().  Which is
> >     a really bad idea, but sometimes all too easy to do.  But even then,
> >     these diagnostics have at least some probability of catching the problem.
> >     
> >     Reported-by: Sagi Grimberg <sagi at grimberg.me>
> >     Reported-by: Bart Van Assche <bvanassche at acm.org>
> >     Signed-off-by: Paul E. McKenney <paulmck at linux.ibm.com>
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index a60b8ba9e1ac..4f30f3ecabc1 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -387,6 +387,8 @@ void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
> >  			del_timer_sync(&sdp->delay_work);
> >  			flush_work(&sdp->work);
> >  		}
> > +		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
> > +			return; /* Forgot srcu_barrier(), so just leak it! */
> >  	}
> >  	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
> >  	    WARN_ON(srcu_readers_active(ssp))) {
> 
> Hi Paul,
> 
> With this patch applied I still see the KASAN use-after-free complaint but no prior
> warning from inside the RCU code.

Hmmm...

I don't see how the KASAN warning could happen without srcu_struct_cleanup()
or srcu_struct_cleanup_quiesced() being called.  Perhaps a failure of
imagination on my part.

So does it seem plausible to you that one of those two has been called
at the time the KASAN complaint is emitted?

								Thanx, Paul
