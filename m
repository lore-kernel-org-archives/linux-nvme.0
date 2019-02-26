From: paulmck@linux.ibm.com (Paul E. McKenney)
Date: Tue, 26 Feb 2019 10:12:11 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <1551203224.31902.173.camel@acm.org>
References: <20190213184839.GD4240@linux.ibm.com>
 <1550085136.19311.78.camel@acm.org>
 <20190213193013.GG4240@linux.ibm.com>
 <20190213195205.GA13650@linux.ibm.com>
 <1550091612.31902.48.camel@acm.org>
 <20190213220923.GK4240@linux.ibm.com>
 <1550103713.31902.57.camel@acm.org>
 <20190214010210.GM4240@linux.ibm.com>
 <20190226173520.GA21832@linux.ibm.com>
 <1551203224.31902.173.camel@acm.org>
Message-ID: <20190226181211.GU4072@linux.ibm.com>

On Tue, Feb 26, 2019@09:47:04AM -0800, Bart Van Assche wrote:
> On Tue, 2019-02-26@09:35 -0800, Paul E. McKenney wrote:
> > On Wed, Feb 13, 2019@05:02:10PM -0800, Paul E. McKenney wrote:
> > > On Wed, Feb 13, 2019@04:21:53PM -0800, Bart Van Assche wrote:
> > > > On Wed, 2019-02-13@14:09 -0800, Paul E. McKenney wrote:
> > > > > commit 65f1b53aeb25a9bddabd08e37bb4c7246320f993
> > > > > Author: Paul E. McKenney <paulmck at linux.ibm.com>
> > > > > Date:   Wed Feb 13 13:54:37 2019 -0800
> > > > > 
> > > > >     srcu: Remove cleanup_srcu_struct_quiesced()
> > > > >     
> > > > >     The cleanup_srcu_struct_quiesced() function was added because NVME
> > > > >     used WQ_MEM_RECLAIM workqueues and SRCU did not, which meant that
> > > > >     NVME workqueues waiting on SRCU workqueues could result in deadlocks
> > > > >     during low-memory conditions.  However, SRCU now also has WQ_MEM_RECLAIM
> > > > >     workqueues, so there is no longer a potential for deadlock.  Furthermore,
> > > > >     it turns out to be extremely hard to use cleanup_srcu_struct_quiesced()
> > > > >     correctly due to the fact that SRCU callback invocation accesses the
> > > > >     srcu_struct structure's per-CPU data area just after callbacks are
> > > > >     invoked.  Therefore, the usual practice of using srcu_barrier() to wait
> > > > >     for callbacks to be invoked before invoking cleanup_srcu_struct_quiesced()
> > > > >     fails because SRCU's callback-invocation workqueue handler might be
> > > > >     delayed, which can result in cleanup_srcu_struct_quiesced() being invoked
> > > > >     (and thus freeing the per-CPU data) before the SRCU's callback-invocation
> > > > >     workqueue handler is finished using that per-CPU data.  Nor is this a
> > > > >     theoretical problem: KASAN emitted use-after-free warnings because of
> > > > >     this problem on actual runs.
> > > > >     
> > > > >     In short, NVME can now safely invoke cleanup_srcu_struct(), which
> > > > >     avoids the use-after-free scenario.  And cleanup_srcu_struct_quiesced()
> > > > >     is quite difficult to use safely.  This commit therefore removes
> > > > >     cleanup_srcu_struct_quiesced(), switching its sole user back to
> > > > >     cleanup_srcu_struct().  This effectively reverts the following pair
> > > > >     of commits:
> > > > >     
> > > > >     f7194ac32ca2 ("srcu: Add cleanup_srcu_struct_quiesced()")
> > > > >     4317228ad9b8 ("nvme: Avoid flush dependency in delete controller flow")
> > > > >     
> > > > >     Reported-by: Bart Van Assche <bvanassche at acm.org>
> > > > >     Signed-off-by: Paul E. McKenney <paulmck at linux.ibm.com>
> > > > > 
> > > > > [ ... ]
> > > > 
> > > > Reviewed-by: Bart Van Assche <bvanassche at acm.org>
> > > 
> > > Applied thank you!
> > > 
> > > Looking forward to hearing the results of testing as well!
> > 
> > The time during which I might reasonably push this into the upcoming
> > (v5.1) merge window is quickly drawing to a close.  If you need this
> > before the v5.2 merge window, could you please let me know?  If so,
> > a Tested-by would make things work much more smoothly.
> 
> Hi Paul,
> 
> Sorry that I had not yet reported that my tests pass with this patch applied.
> Feel free to add the following:
> 
> Tested-by: Bart Van Assche <bvanassche at acm.org>

Applied, thank you!

But if you want me to try to push this into v5.1, I need you to very
explicitly tell me that you want me to do this.  Sorry to be picky, but
my normal process cut off contributions to v5.0 more than a month ago,
and my usual position is that a backport to -stable covers almost all
use cases and reduces risk to those using mainline.  Yes, RCU patches
do start off under a considerable cloud of suspicion.  Which is one of
the reasons that RCU works at all.  ;-)

So again, if you need me to try to push this into v5.1, I do need an
explicit request from you.

							Thanx, Paul
