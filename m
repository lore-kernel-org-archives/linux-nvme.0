From: keith.busch@intel.com (Keith Busch)
Date: Tue, 26 Jan 2016 23:59:22 +0000
Subject: [PATCH 1/2] NVMe: Make surprise removal work again
In-Reply-To: <20160126165334.GB609@infradead.org>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
 <20160126165334.GB609@infradead.org>
Message-ID: <20160126235922.GB18103@localhost.localdomain>

On Tue, Jan 26, 2016@08:53:34AM -0800, Christoph Hellwig wrote:
> >  	if (kill) {
> >  		blk_set_queue_dying(ns->queue);
> > +		mb();
> 
> Please always comment memory barriers, I can't really make any sense
> of this one.

I meant to remove this before posting. It was for an error I thought
occured when testing the patch, but didn't confirm: did a h/w queue
restart and not see the dying flag in nvme_queue_rq? I don't think that's
what happened, but left that in by mistake.

I'll respin.

> >  		blk_mq_abort_requeue_list(ns->queue);
> > +		__nvme_start_queue_locked(ns);
> 
> Also why do we need a kick of the requeue list above if we just aborted
> all requests on it?

Just reusing existing code. We don't need to abort the requeue list
first. It's just a short cut to ending commands.

I don't think the queue restarting was necessary before since requests
used to wait on a frozen queue before failing. Now they wait on tags,
so need some way to flush them to failure.

> > +++ b/drivers/nvme/host/pci.c
> > @@ -640,6 +640,10 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  	struct nvme_command cmnd;
> >  	int ret = BLK_MQ_RQ_QUEUE_OK;
> >  
> > +	if (unlikely(blk_queue_dying(req->q))) {
> > +		blk_mq_end_request(req, -EIO);
> > +		return BLK_MQ_RQ_QUEUE_OK;
> > +	}
> 
> Seems like this is something blk-mq should be doing.

Sounds good to me.

I was a afraid to handle this at the generic layer since it could change
what other protocols see. It looks safe, though SCSI tracks device state
differently, and I've a bad record of breaking other drivers with block
layer "fixes" recently. :)
