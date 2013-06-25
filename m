From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 25 Jun 2013 16:57:54 +0200
Subject: RFC: Allow block drivers to poll for I/O instead of sleeping
In-Reply-To: <20130625001102.GA6623@home.goodmis.org>
References: <20130620201713.GV8211@linux.intel.com>
 <20130623100920.GA19021@gmail.com>
 <CA+55aFy+COdk5+ucwxtc1At=PAYTJxeUaUV6rP9XstHdNV0hbQ@mail.gmail.com>
 <20130624071718.GS9422@kernel.dk>
 <20130625001102.GA6623@home.goodmis.org>
Message-ID: <20130625145754.GL5594@kernel.dk>

On Mon, Jun 24 2013, Steven Rostedt wrote:
> On Mon, Jun 24, 2013@09:17:18AM +0200, Jens Axboe wrote:
> > On Sun, Jun 23 2013, Linus Torvalds wrote:
> > > 
> > > You could try to do that either *in* the idle thread (which would take
> > > the context switch overhead - maybe negating some of the advantages),
> > > or alternatively hook into the scheduler idle logic before actually
> > > doing the switch.
> > 
> > It can't happen in the idle thread. If you need to take the context
> > switch, then you've negated pretty much all of the gain of the polled
> > approach.
> 
> What about hooking into the idle_balance code? That happens if we are
> about to go to idle but before the full schedule switch to the idle
> task.
> 
> 
> In __schedule(void):
> 
> 	if (unlikely(!rq->nr_running))
> 		idle_balance(cpu, rq);

If you can avoid the switch (sleep/wakeup), then that's what matters. If
you end up sleeping, you've lost that latency game and polling is mostly
useful in the blk_iopoll designed fashion for high iops scenarios.
Besides, you need the task + page context to be able to find out what to
poll for (and when to stop).

-- 
Jens Axboe
