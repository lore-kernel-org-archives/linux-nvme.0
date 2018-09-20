From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 20 Sep 2018 10:24:01 -0700
Subject: Kernel v4.19-rc4 KASAN complaint
In-Reply-To: <20180920071040.GA8685@infradead.org>
References: <6892a170-0dcf-9498-19c2-50e1ae89f4ef@acm.org>
 <20180920071040.GA8685@infradead.org>
Message-ID: <1537464241.224533.8.camel@acm.org>

On Thu, 2018-09-20@00:10 -0700, Christoph Hellwig wrote:
> On Tue, Sep 18, 2018@02:16:48PM -0700, Bart Van Assche wrote:
> > Hello,
> > 
> > If I run the nvmeof-mp tests from https://github.com/bvanassche/blktests
> > against kernel v4.19-rc4 then a KASAN complaint appears. This complaint does
> > not appear when I run these tests against kernel v4.18. Could this be a
> > regression?
> 
> Sounds like it is.  4.19 has the new ANA code, so the multipath code
> has some churn.
> 
> > BUG: KASAN: use-after-free in srcu_invoke_callbacks+0x207/0x290
> 
> Can you resolve the address using gdb on vmlinux to a specific
> line of code?

Sure. The gdb output (which is probably not very useful) is as follows:

(gdb) list *(srcu_invoke_callbacks+0x207)
0xffffffff811872e7 is in srcu_invoke_callbacks (./include/linux/compiler.h:188).
183     })
184
185     static __always_inline
186     void __read_once_size(const volatile void *p, void *res, int size)
187     {
188             __READ_ONCE_SIZE;
189     }
190
191     #ifdef CONFIG_KASAN
192     /*

This may be more useful:

(gdb) list *(srcu_invoke_callbacks+0x1fa)
0xffffffff811872da is in srcu_invoke_callbacks (kernel/rcu/srcutree.c:1206).
1201            /*
1202             * Update counts, accelerate new callbacks, and if needed,
1203             * schedule another round of callback invocation.
1204             */
1205            spin_lock_irq_rcu_node(sdp);
1206            rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
1207            (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
1208                                           rcu_seq_snap(&sp->srcu_gp_seq));
1209            sdp->srcu_cblist_invoking = false;
1210            more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);

Bart.
