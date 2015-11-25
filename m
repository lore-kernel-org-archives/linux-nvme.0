From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Nov 2015 18:24:40 +0000
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <20151125175512.GA23638@infradead.org>
References: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
 <20151125085537.GA19066@infradead.org>
 <20151125160544.GA2587@localhost.localdomain>
 <20151125164257.GB4321@infradead.org>
 <20151125165703.GC2587@localhost.localdomain>
 <20151125170842.GA29291@infradead.org>
 <20151125172845.GD2587@localhost.localdomain>
 <20151125175512.GA23638@infradead.org>
Message-ID: <20151125182439.GE2587@localhost.localdomain>

On Wed, Nov 25, 2015@09:55:12AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 25, 2015@05:28:45PM +0000, Keith Busch wrote:
> > > So let's get rid of the nvme_end_req thing and return the real errors.
> > 
> > nvme_end_req _does_ set the real error.
> > 
> > We can't set it in the timeout handler. How would you even know to
> > set an error?
> 
> Because the command timed out, which means we're done with it.  That's
> the whole point of the timeout - after that the command is fenced off
> and we are done with it.

I suppose some users with their erasure codes prefer to see failure
status quicker than wait for a slower success.

> > Maybe the controller posted success status, so we should
> > let nvme_dev_shutdown reap the command and set req->errors.
> 
> If the controller had posted success status in time we would not have
> timed out the command.

Right, I'm just concerned with the race. There's no reason the controller
couldn't post completion at the same time as our completely arbitrary
timeout kicks in.

> What you basically seem to care about is handling the race where the
> controller still completes the command after the timeout handler is
> running, and you want the controller to win over the timeout handler.

Yes, preferring not to fake a status if a real one is available.
 
> But as I said above the race also works the other way around: the
> controller completed the command just before we shut down the
> controller, and now we overwrite req->errors with the wrong value
> in nvme_cancel_queue_ios.

Oh I see. I thought the tag wouldn't be seen by nvme_clear_queue's busy
iterator if the request's CQ entry was seen through process_cq, but I
see now that I was wrong about that if it's the timed out request.

Okay, so the status is overridden to "abort" in my patch. I think that's
the status you wanted to see, but it's far removed from where we're returning
"BLK_EH_HANDLED".

> > Such devices return status 6, internal device error, and the senario
> > requires user management to rectify.
> 
> Eww, ok.  So what do we want to do with the devices?  Just ensure the
> admin quue is up to be able to send vendor specific admin commands to
> fix it?

Yep.

> > How do you explicitly check for a timeout? We used to have negative
> > error codes for these, but you changed that to fake NVMe status codes.
> 
> The aborted one is pretty obvious for NVMe.  Anyway, I'm finally
> understanding what the magic negative values are for.  Without the long
> back story that you actually want to support broken devices that need
> to come up without I/O queues and thus we have to ignore the Set
> Features field there was absolutely no way to figure them out.
> 
> I'm perfectly happy to add back a:
> 
> +       /* Linux driver specific value: */
> +       NVME_SC_TIMEOUT                 = -1;
> 
> and use it specificly for this case.  But only as a trade in for
> documenting in detail why we even bother with all this special casing.

Cool, sounds good.
