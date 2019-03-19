From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 19 Mar 2019 12:28:04 +0800
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <cb036f6f-3dd5-cf7b-4811-6c7d97a2279e@broadcom.com>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <4563485a-02c6-0bfe-d9ec-49adbd44671c@broadcom.com>
 <20190319013142.GB22459@ming.t460p>
 <cb036f6f-3dd5-cf7b-4811-6c7d97a2279e@broadcom.com>
Message-ID: <20190319042803.GD22459@ming.t460p>

On Mon, Mar 18, 2019@09:04:37PM -0700, James Smart wrote:
> 
> 
> On 3/18/2019 6:31 PM, Ming Lei wrote:
> > On Mon, Mar 18, 2019@10:37:08AM -0700, James Smart wrote:
> > > 
> > > On 3/17/2019 8:29 PM, Ming Lei wrote:
> > > > In NVMe's error handler, follows the typical steps for tearing down
> > > > hardware:
> > > > 
> > > > 1) stop blk_mq hw queues
> > > > 2) stop the real hw queues
> > > > 3) cancel in-flight requests via
> > > > 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
> > > > cancel_request():
> > > > 	mark the request as abort
> > > > 	blk_mq_complete_request(req);
> > > > 4) destroy real hw queues
> > > > 
> > > > However, there may be race between #3 and #4, because blk_mq_complete_request()
> > > > actually completes the request asynchronously.
> > > > 
> > > > This patch introduces blk_mq_complete_request_sync() for fixing the
> > > > above race.
> > > > 
> > > This won't help FC at all. Inherently, the "completion" has to be
> > > asynchronous as line traffic may be required.
> > > 
> > > e.g. FC doesn't use nvme_complete_request() in the iterator routine.
> > > 
> > Looks FC has done the sync already, see nvme_fc_delete_association():
> > 
> > 		...
> >          /* wait for all io that had to be aborted */
> >          spin_lock_irq(&ctrl->lock);
> >          wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
> >          ctrl->flags &= ~FCCTRL_TERMIO;
> >          spin_unlock_irq(&ctrl->lock);
> 
> yes - but the iterator started a lot of the back end io terminating in
> parallel. So waiting on many happening in parallel is better than waiting 1
> at a time.

OK, that is FC's sync, not related with this patch.

> Even so, I've always disliked this wait and would have
> preferred to exit the thread with something monitoring the completions
> re-queuing a work thread to finish.

Then I guess you may like this patch given it actually avoids the
potential wait, :-)

What the patch does is to convert the remote completion(#1) into local
completion(#2):

1) previously one request may be completed remotely by blk_mq_complete_request():

         rq->csd.func = __blk_mq_complete_request_remote;
         rq->csd.info = rq;
         rq->csd.flags = 0;
         smp_call_function_single_async(ctx->cpu, &rq->csd);

2) this patch changes the remote completion into local completion via
blk_mq_complete_request_sync(), so all in-flight requests can be aborted
before destroying queue.

		q->mq_ops->complete(rq);

As I mentioned in another email, there isn't any waiting for aborting
request, nvme_cancel_request() simply requeues the request to blk-mq
under this situation.

Thanks,
Ming
