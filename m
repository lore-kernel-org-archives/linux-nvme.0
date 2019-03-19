From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 19 Mar 2019 09:31:43 +0800
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <4563485a-02c6-0bfe-d9ec-49adbd44671c@broadcom.com>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <4563485a-02c6-0bfe-d9ec-49adbd44671c@broadcom.com>
Message-ID: <20190319013142.GB22459@ming.t460p>

On Mon, Mar 18, 2019@10:37:08AM -0700, James Smart wrote:
> 
> 
> On 3/17/2019 8:29 PM, Ming Lei wrote:
> > In NVMe's error handler, follows the typical steps for tearing down
> > hardware:
> > 
> > 1) stop blk_mq hw queues
> > 2) stop the real hw queues
> > 3) cancel in-flight requests via
> > 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
> > cancel_request():
> > 	mark the request as abort
> > 	blk_mq_complete_request(req);
> > 4) destroy real hw queues
> > 
> > However, there may be race between #3 and #4, because blk_mq_complete_request()
> > actually completes the request asynchronously.
> > 
> > This patch introduces blk_mq_complete_request_sync() for fixing the
> > above race.
> > 
> 
> This won't help FC at all. Inherently, the "completion" has to be
> asynchronous as line traffic may be required.
> 
> e.g. FC doesn't use nvme_complete_request() in the iterator routine.
> 

Looks FC has done the sync already, see nvme_fc_delete_association():

		...
        /* wait for all io that had to be aborted */
        spin_lock_irq(&ctrl->lock);
        wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
        ctrl->flags &= ~FCCTRL_TERMIO;
        spin_unlock_irq(&ctrl->lock);

Thanks,
Ming
