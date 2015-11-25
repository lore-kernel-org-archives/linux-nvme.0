From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Nov 2015 16:05:45 +0000
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <20151125085537.GA19066@infradead.org>
References: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
 <20151125085537.GA19066@infradead.org>
Message-ID: <20151125160544.GA2587@localhost.localdomain>

On Wed, Nov 25, 2015@12:55:37AM -0800, Christoph Hellwig wrote:
> > +static inline void nvme_end_req(struct request *req, int error)
> > +{
> > +	/*
> > +	 * The request may already be marked "complete" by blk-mq if
> > +	 * completion occurs during a timeout. We set req->errors
> > +	 * before telling blk-mq in case this is the target request
> > +	 * of a timeout handler. This is safe since this driver never
> > +	 * completes the same command twice.
> > +	 */
> > +	req->errors = error;
> > +	blk_mq_complete_request(req, req->errors);
> 
> I don't think overwriting req->errors on an already completed request
> is a good idea - it's what we used to earlier, but I specificly changed
> the blk_mq_complete_request so that we don't do that.  Can you explain
> when you want to overwrite the value exactly and why?

Explanation follows:

> >  	if (test_bit(NVME_CTRL_RESETTING, &dev->flags)) {
> > -		req->errors = NVME_SC_ABORT_REQ | NVME_SC_DNR;
> > +		dev_warn(dev->dev,
> > +				"I/O %d QID %d timeout, disable controller\n",
> > +				 req->tag, nvmeq->qid);
> > +		nvme_dev_shutdown(dev);
> >  		return BLK_EH_HANDLED;
> 
> So here you return BLK_EH_HANDLED without setting req->errors, which
> sounds like it might be related to the above issue.

Right, we don't want to set req->errors here. nvme_dev_shutdown
unconditionally reaps every request known to the driver, so it's safe
assume the timed out request is completed and return EH_HANDLED.

Executing the nvme_timeout code path more often than not means the
controller isn't going to return that command, but we can't count on that.
So there are two possibilities:

  1. request completes through nvme_process_cq
  2. request completes through nvme_cancel_queue_ios

In either case, req->errors is set through the new nvme_end_req, as you
surmised. We don't want to set req->errors here directly in case the
request completes through process_cq. We should prefer the controller's
status rather than make one up.

> > +		 * Mark the request as handled, since the inline shutdown
> > +		 * forces all outstanding requests to complete.
> >  		 */
> > -		return BLK_EH_QUIESCED;
> > +		return BLK_EH_HANDLED;
> 
> Again we're not setting req->errors here.

Yep, same reasoning as above. This also fixes this race:

        CPU 0                           CPU 1

  blk_mq_check_expired                nvme_irq
    set_bit(REQ_ATOM_COMPLETE)          nvme_process_cq
    nvme_timeout                          blk_mq_complete_request
                                            if (!test_and_set_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags) ||
	                                         test_and_clear_bit(REQ_ATOM_QUIESCED, &rq->atomic_flags))
      return BLK_EH_QUIESCED
    set_bit REQ_ATOM_QUIESCED

Both checks on blk_mq_complete_request will fail since the timeout
handler hasn't returned "quiesce" yet, and the request will be orphaned.

Instead we can let nvme_dev_shudtown reap the request and set req->errors
directly through one of the two paths described above, then return
BLK_EH_HANDLED.
 
> > @@ -2023,6 +2038,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
> >  
> >  	nvme_dev_list_remove(dev);
> >  
> > +	mutex_lock(&dev->shutdown_lock);
> 
> Shoudn't we also have a state check that skips all the work here if
> the controller has already been shut down?

This is implied through dev->bar != NULL, and the nvmeq's cq_vector value.

> > +	 * The pci device will be disabled if a timeout occurs while setting up
> > +	 * IO queues, but return 0 for "result", so we have to check both.
> > +	 */
> > +	if (result || !pci_is_enabled(to_pci_dev(dev->dev)))
> >  		goto free_tags;
>
> I don't think we should return zero here in that case - that seems to
> be a bug in setting up req->errrors in the timeout handler.

To set an appropriate non-zero result, we'd need to add pci_is_enabled()
checks in nvme_setup_io_queues to distinguish a non-fatal command error
vs timeout. Is that preferable to the check where I have it?
