From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 25 Nov 2015 09:08:42 -0800
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <20151125165703.GC2587@localhost.localdomain>
References: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
 <20151125085537.GA19066@infradead.org>
 <20151125160544.GA2587@localhost.localdomain>
 <20151125164257.GB4321@infradead.org>
 <20151125165703.GC2587@localhost.localdomain>
Message-ID: <20151125170842.GA29291@infradead.org>

On Wed, Nov 25, 2015@04:57:03PM +0000, Keith Busch wrote:
> > nvme_dev_shutdown will not complete the command that we timed out,
> > blk_mq_complete_request will skip it because REQ_ATOM_COMPLETE is set,
> > and blk_mq_rq_timed_out will complete after we returned from the timeout
> > handler.
> 
> I'm not saying nvme_dev_shutdown "completes" the command. I'm just
> saying it reaps it and sets an appropriate req->errors. The actual blk-mq
> completion happens as you described through nvme_timeout's return code
> of BLK_EH_HANDLED.

So let's get rid of the nvme_end_req thing and return the real errors.

> > > To set an appropriate non-zero result, we'd need to add pci_is_enabled()
> > > checks in nvme_setup_io_queues to distinguish a non-fatal command error
> > > vs timeout. Is that preferable to the check where I have it?
> > 
> > No, that's not my preference.  My preference is to figure out why you
> > get a zero req->errors on timed request.  That really shouldn't happen
> > to start with.
> 
> req->errors wouldn't be 0, but nvme_set_queue_count returns "0" queues
> if req->errors is non-zero. It's not a fatal error to have 0 queues so
> we don't want to propogate that error to the initialization unless it's
> a timeout.

Ok, step back here, I think that set_queue_count beast is getting too
confusing.  What do you 'failing' devices return in the NVMe CQE status
and result fields?  Do we get a failure in status, or do we get a zero
status and a zero result?

> We also don't return error codes on create sq/cq commands because an error
> here isn't fatal either unless, of course, it's a timeout.

So make sure that we a) don't mix up the status and result return values
by making the count parameter of set_queue_count a pointer and thus
keeping it separate from the status.

And then explicitly check for a timeout on create sq/cq.  And for
set_queue_count I disagree that it shouldn't be non-fatal, it's the way
how the hardware tells you how many queues are supported.  If some
hardware gets that wrong we'll have to handle it for better or worse,
but we should document that it's buggy and probably even log a message.

And a failing create sq/cq actually is fatal for us except for the
initial probe as well as blk-mq will keep using it once we set up the
queue count.
