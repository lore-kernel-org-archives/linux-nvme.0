From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 24 Jun 2013 23:07:21 -0400
Subject: RFC: Allow block drivers to poll for I/O instead of sleeping
In-Reply-To: <20130625001102.GA6623@home.goodmis.org>
References: <20130620201713.GV8211@linux.intel.com>
 <20130623100920.GA19021@gmail.com>
 <CA+55aFy+COdk5+ucwxtc1At=PAYTJxeUaUV6rP9XstHdNV0hbQ@mail.gmail.com>
 <20130624071718.GS9422@kernel.dk>
 <20130625001102.GA6623@home.goodmis.org>
Message-ID: <20130625030721.GA8211@linux.intel.com>

On Mon, Jun 24, 2013@08:11:02PM -0400, Steven Rostedt wrote:
> What about hooking into the idle_balance code? That happens if we are
> about to go to idle but before the full schedule switch to the idle
> task.
> 
> 
> In __schedule(void):
> 
> 	if (unlikely(!rq->nr_running))
> 		idle_balance(cpu, rq);

That may be a great place to try it from the PoV of the scheduler, but are
you OK with me threading a struct backing_dev_info * all the way through
the scheduler to idle_balance()?  :-)
