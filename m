From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 25 Nov 2015 09:55:12 -0800
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <20151125172845.GD2587@localhost.localdomain>
References: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
 <20151125085537.GA19066@infradead.org>
 <20151125160544.GA2587@localhost.localdomain>
 <20151125164257.GB4321@infradead.org>
 <20151125165703.GC2587@localhost.localdomain>
 <20151125170842.GA29291@infradead.org>
 <20151125172845.GD2587@localhost.localdomain>
Message-ID: <20151125175512.GA23638@infradead.org>

On Wed, Nov 25, 2015@05:28:45PM +0000, Keith Busch wrote:
> > So let's get rid of the nvme_end_req thing and return the real errors.
> 
> nvme_end_req _does_ set the real error.
> 
> We can't set it in the timeout handler. How would you even know to
> set an error?

Because the command timed out, which means we're done with it.  That's
the whole point of the timeout - after that the command is fenced off
and we are done with it.

> Maybe the controller posted success status, so we should
> let nvme_dev_shutdown reap the command and set req->errors.

If the controller had posted success status in time we would not have
timed out the command.

What you basically seem to care about is handling the race where the
controller still completes the command after the timeout handler is
running, and you want the controller to win over the timeout handler.

But as I said above the race also works the other way around: the
controller completed the command just before we shut down the
controller, and now we overwrite req->errors with the wrong value
in nvme_cancel_queue_ios.

The controller had plenty of time to complete the command properly,
one we are in the timeout handler we decided to cut it off and now we're
going to retry after a reset.

> > Ok, step back here, I think that set_queue_count beast is getting too
> > confusing.  What do you 'failing' devices return in the NVMe CQE status
> > and result fields?  Do we get a failure in status, or do we get a zero
> > status and a zero result?
> 
> Such devices return status 6, internal device error, and the senario
> requires user management to rectify.

Eww, ok.  So what do we want to do with the devices?  Just ensure the
admin quue is up to be able to send vendor specific admin commands to
fix it?

> How do you explicitly check for a timeout? We used to have negative
> error codes for these, but you changed that to fake NVMe status codes.

The aborted one is pretty obvious for NVMe.  Anyway, I'm finally
understanding what the magic negative values are for.  Without the long
back story that you actually want to support broken devices that need
to come up without I/O queues and thus we have to ignore the Set
Features field there was absolutely no way to figure them out.

I'm perfectly happy to add back a:

+       /* Linux driver specific value: */
+       NVME_SC_TIMEOUT                 = -1;

and use it specificly for this case.  But only as a trade in for
documenting in detail why we even bother with all this special casing.

> > set_queue_count I disagree that it shouldn't be non-fatal, it's the way
> > how the hardware tells you how many queues are supported.  If some
> > hardware gets that wrong we'll have to handle it for better or worse,
> > but we should document that it's buggy and probably even log a message.
> 
> It's not "wrong" to return an appropriate error code to a command if the
> device is in a state that can't support it. The h/w may be in a non-optimal
> condition, but we handle that correctly today.

I assume correctly means the admin queu is up, and no I/O queus are
working.  That soudns reasonable to me, but it's absolutely not obvious
from the code that such a case matters.  Comment, comments, comments!
