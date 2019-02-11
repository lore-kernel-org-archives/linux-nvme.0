From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 11 Feb 2019 14:27:19 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <20190211210808.GS4240@linux.ibm.com>
References: <1547579226.83374.114.camel@acm.org>
 <6c18d8f8-949f-9502-566a-643d384e9113@grimberg.me>
 <1549905891.19311.5.camel@acm.org> <20190211210808.GS4240@linux.ibm.com>
Message-ID: <1549924039.19311.26.camel@acm.org>

On Mon, 2019-02-11@13:08 -0800, Paul E. McKenney wrote:
> On Mon, Feb 11, 2019@09:24:51AM -0800, Bart Van Assche wrote:
> > BUG: KASAN: use-after-free in srcu_invoke_callbacks+0x209/0x290
> > Read of size 8 at addr ffff8881126b6df0 by task kworker/2:94/26747
> > CPU: 2 PID: 26747 Comm: kworker/2:94 Not tainted 5.0.0-rc5-dbg+ #5
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > Workqueue: rcu_gp srcu_invoke_callbacks
> > Call Trace:
> >  dump_stack+0x86/0xca
> >  print_address_description+0x71/0x239
> >  kasan_report.cold.3+0x1b/0x3e
> >  __asan_load8+0x54/0x90
> >  srcu_invoke_callbacks+0x209/0x290
> >  process_one_work+0x4f1/0xa40
> >  worker_thread+0x67/0x5b0
> >  kthread+0x1cf/0x1f0
> >  ret_from_fork+0x24/0x30
> 
> The usual way that something like this happens is by invoking call_srcu()
> twice in a row on the same object, similar to double-kfree() but with
> call_srcu() instead of kfree().  One way to check for this sort of thing
> is to reproduce in a kernel built with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y.

Thanks Paul for the feedback. You may want to know that this test was run
against kernel v5.0-rc5 and that that debugging option was enabled in the
kernel config before I ran this test:

$ grep RCU_HEAD .config     
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y

Bart.
