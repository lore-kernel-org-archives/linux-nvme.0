From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Nov 2015 17:28:45 +0000
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <20151125170842.GA29291@infradead.org>
References: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
 <20151125085537.GA19066@infradead.org>
 <20151125160544.GA2587@localhost.localdomain>
 <20151125164257.GB4321@infradead.org>
 <20151125165703.GC2587@localhost.localdomain>
 <20151125170842.GA29291@infradead.org>
Message-ID: <20151125172845.GD2587@localhost.localdomain>

On Wed, Nov 25, 2015@09:08:42AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 25, 2015@04:57:03PM +0000, Keith Busch wrote:
> > I'm not saying nvme_dev_shutdown "completes" the command. I'm just
> > saying it reaps it and sets an appropriate req->errors. The actual blk-mq
> > completion happens as you described through nvme_timeout's return code
> > of BLK_EH_HANDLED.
> 
> So let's get rid of the nvme_end_req thing and return the real errors.

nvme_end_req _does_ set the real error.

We can't set it in the timeout handler. How would you even know to
set an error? Maybe the controller posted success status, so we should
let nvme_dev_shutdown reap the command and set req->errors. It sets
the real status observed through process_cq, or a fake status through
cancel_queue_ios. Either way, req->errors is set and the req is safe to
complete after nvme_dev_shutdown.

> > req->errors wouldn't be 0, but nvme_set_queue_count returns "0" queues
> > if req->errors is non-zero. It's not a fatal error to have 0 queues so
> > we don't want to propogate that error to the initialization unless it's
> > a timeout.
> 
> Ok, step back here, I think that set_queue_count beast is getting too
> confusing.  What do you 'failing' devices return in the NVMe CQE status
> and result fields?  Do we get a failure in status, or do we get a zero
> status and a zero result?

Such devices return status 6, internal device error, and the senario
requires user management to rectify.
 
> > We also don't return error codes on create sq/cq commands because an error
> > here isn't fatal either unless, of course, it's a timeout.
> 
> So make sure that we a) don't mix up the status and result return values
> by making the count parameter of set_queue_count a pointer and thus
> keeping it separate from the status.

> And then explicitly check for a timeout on create sq/cq.

How do you explicitly check for a timeout? We used to have negative
error codes for these, but you changed that to fake NVMe status codes.

As far as I can tell, pci_is_enabled is the only way to see if a timeout
happened in this path, as it implies the device was shutdown by the
timeout handler.

> And for
> set_queue_count I disagree that it shouldn't be non-fatal, it's the way
> how the hardware tells you how many queues are supported.  If some
> hardware gets that wrong we'll have to handle it for better or worse,
> but we should document that it's buggy and probably even log a message.

It's not "wrong" to return an appropriate error code to a command if the
device is in a state that can't support it. The h/w may be in a non-optimal
condition, but we handle that correctly today.

> And a failing create sq/cq actually is fatal for us except for the
> initial probe as well as blk-mq will keep using it once we set up the
> queue count.

That's true, blk-mq does not let us change nr_hw_queues, but that's a
different issue we can fix.
