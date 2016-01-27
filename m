From: keith.busch@intel.com (Keith Busch)
Date: Wed, 27 Jan 2016 14:19:32 +0000
Subject: [PATCH 1/2] NVMe: Make surprise removal work again
In-Reply-To: <56A8AE61.6070100@dev.mellanox.co.il>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
 <56A8AE61.6070100@dev.mellanox.co.il>
Message-ID: <20160127141931.GA19346@localhost.localdomain>

On Wed, Jan 27, 2016@01:47:45PM +0200, Sagi Grimberg wrote:
> >  		blk_mq_abort_requeue_list(ns->queue);
> >+		__nvme_start_queue_locked(ns);
> 
> Why not making sure that all the pending requests are moved to
> the requeue list before we even get here? call nvme_cancel_io on
> pending requests which would either fail the requests (blk_queue_dying)
> or move them to the requeue list?

That works only for active requests. There could be processes that entered
the queue and waiting for request tags to become available. These need
to be flushed to completion somehow ... maybe they shouldn't even succeed
in getting a request on a dying queue?

> >+	if (unlikely(blk_queue_dying(req->q))) {
> >+		blk_mq_end_request(req, -EIO);
> >+		return BLK_MQ_RQ_QUEUE_OK;
> >+	}
> 
> This is something we should try our best to move away from IMO...

Agreed, though I think this is better than relying on queue freeze that
used to happen.
