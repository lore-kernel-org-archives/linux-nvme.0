From: paulmck@linux.ibm.com (Paul E. McKenney)
Date: Tue, 25 Sep 2018 20:14:17 -0700
Subject: Kernel v4.19-rc4 KASAN complaint
In-Reply-To: <20180925233211.GB28388@infradead.org>
References: <6892a170-0dcf-9498-19c2-50e1ae89f4ef@acm.org>
 <20180920071040.GA8685@infradead.org>
 <1537464241.224533.8.camel@acm.org>
 <20180925233211.GB28388@infradead.org>
Message-ID: <20180926031417.GS4222@linux.ibm.com>

On Tue, Sep 25, 2018@04:32:11PM -0700, Christoph Hellwig wrote:
> [Adding Paul]
> 
> Hi Paul,
> 
> Bart reported a use after free in the SRCU code when testing the
> nvme multipath code here:
> 
> http://lists.infradead.org/pipermail/linux-nvme/2018-September/020009.html
> 
> Based on his analsys it appears to me the use after free is on the
> srcu_data structure, which is internal to the SRCU implementation.
> 
> While I don't want to exclude an actual cause in the nvme code I wonder
> if you have any additional insights from the RCU perspective.
> 
> On Thu, Sep 20, 2018@10:24:01AM -0700, Bart Van Assche wrote:
> > On Thu, 2018-09-20@00:10 -0700, Christoph Hellwig wrote:
> > > On Tue, Sep 18, 2018@02:16:48PM -0700, Bart Van Assche wrote:
> > > > Hello,
> > > > 
> > > > If I run the nvmeof-mp tests from https://github.com/bvanassche/blktests
> > > > against kernel v4.19-rc4 then a KASAN complaint appears. This complaint does
> > > > not appear when I run these tests against kernel v4.18. Could this be a
> > > > regression?

I would be quite surprised if any of the SRCU commits since v4.18 caused
this sort of a problem, but there are not that many of them. so easy to
check (at least assuming that this is reproducible):

	gitk v4.18.. -- kernel/rcu/srcu* include/linux/*srcu*

But checking below...

> > > Sounds like it is.  4.19 has the new ANA code, so the multipath code
> > > has some churn.
> > > 
> > > > BUG: KASAN: use-after-free in srcu_invoke_callbacks+0x207/0x290
> > > 
> > > Can you resolve the address using gdb on vmlinux to a specific
> > > line of code?
> > 
> > Sure. The gdb output (which is probably not very useful) is as follows:
> > 
> > (gdb) list *(srcu_invoke_callbacks+0x207)
> > 0xffffffff811872e7 is in srcu_invoke_callbacks (./include/linux/compiler.h:188).
> > 183     })
> > 184
> > 185     static __always_inline
> > 186     void __read_once_size(const volatile void *p, void *res, int size)
> > 187     {
> > 188             __READ_ONCE_SIZE;
> > 189     }
> > 190
> > 191     #ifdef CONFIG_KASAN
> > 192     /*
> > 
> > This may be more useful:
> > 
> > (gdb) list *(srcu_invoke_callbacks+0x1fa)
> > 0xffffffff811872da is in srcu_invoke_callbacks (kernel/rcu/srcutree.c:1206).
> > 1201            /*
> > 1202             * Update counts, accelerate new callbacks, and if needed,
> > 1203             * schedule another round of callback invocation.
> > 1204             */
> > 1205            spin_lock_irq_rcu_node(sdp);
> > 1206            rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
> > 1207            (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > 1208                                           rcu_seq_snap(&sp->srcu_gp_seq));
> > 1209            sdp->srcu_cblist_invoking = false;
> > 1210            more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);

I would expect something like this if someone did a double call_srcu()
or passed something to call_srcu() but then kept using it (for an example
of the latter, failed to make it inaccessible to readers before invoking
call_srcu() on it).  Yet another way to get here is to have unioned the
rcu_head structure with something used by the SRCU readers.

The double call_srcu() can be located by building your kernel with
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and rerunning your tests.  The other
two usually require inspection or bisection.

So, the eternal question:  Is bisection feasible?

							Thanx, Paul
