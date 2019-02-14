From: paulmck@linux.ibm.com (Paul E. McKenney)
Date: Wed, 13 Feb 2019 17:02:10 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <1550103713.31902.57.camel@acm.org>
References: <20190213151917.GA3311@linux.ibm.com>
 <20190213152413.GA4468@linux.ibm.com>
 <1550082964.19311.66.camel@acm.org>
 <20190213184839.GD4240@linux.ibm.com>
 <1550085136.19311.78.camel@acm.org>
 <20190213193013.GG4240@linux.ibm.com>
 <20190213195205.GA13650@linux.ibm.com>
 <1550091612.31902.48.camel@acm.org>
 <20190213220923.GK4240@linux.ibm.com>
 <1550103713.31902.57.camel@acm.org>
Message-ID: <20190214010210.GM4240@linux.ibm.com>

On Wed, Feb 13, 2019@04:21:53PM -0800, Bart Van Assche wrote:
> On Wed, 2019-02-13@14:09 -0800, Paul E. McKenney wrote:
> > commit 65f1b53aeb25a9bddabd08e37bb4c7246320f993
> > Author: Paul E. McKenney <paulmck at linux.ibm.com>
> > Date:   Wed Feb 13 13:54:37 2019 -0800
> > 
> >     srcu: Remove cleanup_srcu_struct_quiesced()
> >     
> >     The cleanup_srcu_struct_quiesced() function was added because NVME
> >     used WQ_MEM_RECLAIM workqueues and SRCU did not, which meant that
> >     NVME workqueues waiting on SRCU workqueues could result in deadlocks
> >     during low-memory conditions.  However, SRCU now also has WQ_MEM_RECLAIM
> >     workqueues, so there is no longer a potential for deadlock.  Furthermore,
> >     it turns out to be extremely hard to use cleanup_srcu_struct_quiesced()
> >     correctly due to the fact that SRCU callback invocation accesses the
> >     srcu_struct structure's per-CPU data area just after callbacks are
> >     invoked.  Therefore, the usual practice of using srcu_barrier() to wait
> >     for callbacks to be invoked before invoking cleanup_srcu_struct_quiesced()
> >     fails because SRCU's callback-invocation workqueue handler might be
> >     delayed, which can result in cleanup_srcu_struct_quiesced() being invoked
> >     (and thus freeing the per-CPU data) before the SRCU's callback-invocation
> >     workqueue handler is finished using that per-CPU data.  Nor is this a
> >     theoretical problem: KASAN emitted use-after-free warnings because of
> >     this problem on actual runs.
> >     
> >     In short, NVME can now safely invoke cleanup_srcu_struct(), which
> >     avoids the use-after-free scenario.  And cleanup_srcu_struct_quiesced()
> >     is quite difficult to use safely.  This commit therefore removes
> >     cleanup_srcu_struct_quiesced(), switching its sole user back to
> >     cleanup_srcu_struct().  This effectively reverts the following pair
> >     of commits:
> >     
> >     f7194ac32ca2 ("srcu: Add cleanup_srcu_struct_quiesced()")
> >     4317228ad9b8 ("nvme: Avoid flush dependency in delete controller flow")
> >     
> >     Reported-by: Bart Van Assche <bvanassche at acm.org>
> >     Signed-off-by: Paul E. McKenney <paulmck at linux.ibm.com>
> > 
> > [ ... ]
> 
> Reviewed-by: Bart Van Assche <bvanassche at acm.org>

Applied thank you!

Looking forward to hearing the results of testing as well!

							Thanx, Paul
