From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Nov 2015 16:57:03 +0000
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <20151125164257.GB4321@infradead.org>
References: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
 <20151125085537.GA19066@infradead.org>
 <20151125160544.GA2587@localhost.localdomain>
 <20151125164257.GB4321@infradead.org>
Message-ID: <20151125165703.GC2587@localhost.localdomain>

On Wed, Nov 25, 2015@08:42:57AM -0800, Christoph Hellwig wrote:
> >         CPU 0                           CPU 1
> > 
> >   blk_mq_check_expired                nvme_irq
> >     set_bit(REQ_ATOM_COMPLETE)          nvme_process_cq
> >     nvme_timeout                          blk_mq_complete_request
> >                                             if (!test_and_set_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags) ||
> > 	                                         test_and_clear_bit(REQ_ATOM_QUIESCED, &rq->atomic_flags))
> >       return BLK_EH_QUIESCED
> >     set_bit REQ_ATOM_QUIESCED
> >
> > Both checks on blk_mq_complete_request will fail since the timeout
> > handler hasn't returned "quiesce" yet, and the request will be orphaned.
> 
> BLK_EH_QUIESCED is never returned with your patch applied..

I'm just showing why it was broken before. My patch fixes it since we
reap the command and return BLK_EH_HANDLED.
 
> > Instead we can let nvme_dev_shudtown reap the request and set req->errors
> > directly through one of the two paths described above, then return
> > BLK_EH_HANDLED.
> 
> nvme_dev_shutdown will not complete the command that we timed out,
> blk_mq_complete_request will skip it because REQ_ATOM_COMPLETE is set,
> and blk_mq_rq_timed_out will complete after we returned from the timeout
> handler.

I'm not saying nvme_dev_shutdown "completes" the command. I'm just
saying it reaps it and sets an appropriate req->errors. The actual blk-mq
completion happens as you described through nvme_timeout's return code
of BLK_EH_HANDLED.

> > This is implied through dev->bar != NULL, and the nvmeq's cq_vector value.
> 
> Well, we're not doing anything in the low-level functions at the moment
> (at the checks in nvme_dev_unmap, and all requests with
> REQ_ATOM_COMPLETE to the list), but it still seems rather fragile to
> rely on these low level functions deep down the stack to get everything
> right.

Agreed.
 
> > To set an appropriate non-zero result, we'd need to add pci_is_enabled()
> > checks in nvme_setup_io_queues to distinguish a non-fatal command error
> > vs timeout. Is that preferable to the check where I have it?
> 
> No, that's not my preference.  My preference is to figure out why you
> get a zero req->errors on timed request.  That really shouldn't happen
> to start with.

req->errors wouldn't be 0, but nvme_set_queue_count returns "0" queues
if req->errors is non-zero. It's not a fatal error to have 0 queues so
we don't want to propogate that error to the initialization unless it's
a timeout.

We also don't return error codes on create sq/cq commands because an error
here isn't fatal either unless, of course, it's a timeout.
