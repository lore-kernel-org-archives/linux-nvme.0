From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 25 Nov 2015 08:42:57 -0800
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <20151125160544.GA2587@localhost.localdomain>
References: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
 <20151125085537.GA19066@infradead.org>
 <20151125160544.GA2587@localhost.localdomain>
Message-ID: <20151125164257.GB4321@infradead.org>

On Wed, Nov 25, 2015@04:05:45PM +0000, Keith Busch wrote:
> > >  	if (test_bit(NVME_CTRL_RESETTING, &dev->flags)) {
> > > -		req->errors = NVME_SC_ABORT_REQ | NVME_SC_DNR;
> > > +		dev_warn(dev->dev,
> > > +				"I/O %d QID %d timeout, disable controller\n",
> > > +				 req->tag, nvmeq->qid);
> > > +		nvme_dev_shutdown(dev);
> > >  		return BLK_EH_HANDLED;
> > 
> > So here you return BLK_EH_HANDLED without setting req->errors, which
> > sounds like it might be related to the above issue.
> 
> Right, we don't want to set req->errors here. nvme_dev_shutdown
> unconditionally reaps every request known to the driver,

No, it's doesn't.  nvme_dev_shutdown through nvme_clear_queue and
nvme_cancel_queue_ios calls blk_mq_complete_request on every started
request.  But blk_mq_complete_request is a no-op if REQ_ATOM_COMPLETE
is already set, which it is for a request in the timeout handler

> so it's safe
> assume the timed out request is completed and return EH_HANDLED.

Returning EH_HANDLED after you did the shutdown does indeed look
safe to me, but only because a EH_HANDLED makes blk_mq_rq_timed_out
call __blk_mq_complete_request after we returned.  And for that
we want to set req->errors.  Now your nvme_end_req ends up setting
a return value for it as well, but I'd much prefer not to do that
unconditional assignment and set a proper here when we have ownership of
the request.

> In either case, req->errors is set through the new nvme_end_req, as you
> surmised. We don't want to set req->errors here directly in case the
> request completes through process_cq. We should prefer the controller's
> status rather than make one up.

If the controller returns the command after we already started the
shutdown it's too late, and we have to retry it or fence of the
controller.  Note that the the unconditional assignment in
in nvme_cancel_queue_ios can also race the other way, a successully
completed command may get req->errors overwritten with NVME_SC_ABORT_REQ
before it's been returned to the caller (that window is very small,
though).

> Yep, same reasoning as above. This also fixes this race:
> 
>         CPU 0                           CPU 1
> 
>   blk_mq_check_expired                nvme_irq
>     set_bit(REQ_ATOM_COMPLETE)          nvme_process_cq
>     nvme_timeout                          blk_mq_complete_request
>                                             if (!test_and_set_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags) ||
> 	                                         test_and_clear_bit(REQ_ATOM_QUIESCED, &rq->atomic_flags))
>       return BLK_EH_QUIESCED
>     set_bit REQ_ATOM_QUIESCED
>
> Both checks on blk_mq_complete_request will fail since the timeout
> handler hasn't returned "quiesce" yet, and the request will be orphaned.

BLK_EH_QUIESCED is never returned with your patch applied..

> Instead we can let nvme_dev_shudtown reap the request and set req->errors
> directly through one of the two paths described above, then return
> BLK_EH_HANDLED.

nvme_dev_shutdown will not complete the command that we timed out,
blk_mq_complete_request will skip it because REQ_ATOM_COMPLETE is set,
and blk_mq_rq_timed_out will complete after we returned from the timeout
handler.

> > > @@ -2023,6 +2038,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
> > >  
> > >  	nvme_dev_list_remove(dev);
> > >  
> > > +	mutex_lock(&dev->shutdown_lock);
> > 
> > Shoudn't we also have a state check that skips all the work here if
> > the controller has already been shut down?
> 
> This is implied through dev->bar != NULL, and the nvmeq's cq_vector value.

Well, we're not doing anything in the low-level functions at the moment
(at the checks in nvme_dev_unmap, and all requests with
REQ_ATOM_COMPLETE to the list), but it still seems rather fragile to
rely on these low level functions deep down the stack to get everything
right.

> > > +	 * The pci device will be disabled if a timeout occurs while setting up
> > > +	 * IO queues, but return 0 for "result", so we have to check both.
> > > +	 */
> > > +	if (result || !pci_is_enabled(to_pci_dev(dev->dev)))
> > >  		goto free_tags;
> >
> > I don't think we should return zero here in that case - that seems to
> > be a bug in setting up req->errrors in the timeout handler.
> 
> To set an appropriate non-zero result, we'd need to add pci_is_enabled()
> checks in nvme_setup_io_queues to distinguish a non-fatal command error
> vs timeout. Is that preferable to the check where I have it?

No, that's not my preference.  My preference is to figure out why you
get a zero req->errors on timed request.  That really shouldn't happen
to start with.
