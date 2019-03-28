From: kbusch@kernel.org (Keith Busch)
Date: Wed, 27 Mar 2019 21:33:18 -0600
Subject: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
In-Reply-To: <3d72ec9f-0aa5-d455-b453-40c319871287@oracle.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-5-keith.busch@intel.com>
 <20190311184031.GA11707@lst.de>
 <20190311193753.GE10411@localhost.localdomain>
 <20190327083142.GQ20525@lst.de>
 <20190327132116.GA8419@localhost.localdomain>
 <3d72ec9f-0aa5-d455-b453-40c319871287@oracle.com>
Message-ID: <20190328033317.GC8448@localhost.localdomain>

On Thu, Mar 28, 2019@09:42:51AM +0800, jianchao.wang wrote:
> On 3/27/19 9:21 PM, Keith Busch wrote:
> > +void blk_mq_terminate_queued_requests(struct request_queue *q, int hctx_idx)
> > +{
> > +	if (WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth)))
> > +		return;
> > +	if (WARN_ON_ONCE(!blk_queue_quiesced(q)))
> > +		return;
> > +	blk_sync_queue(q);
> > +	blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_request, &hctx_idx);
> > +}
> 
> 
> Is it really OK to end these requests directly w/o dequeue ?
> All of them are on ctx->rq_list, or hctx->dispatch list or internal queue of io scheduler.
> 
> Terrible things may happen after we unquiesce the queue.

Good point. This was intended as a last action before killing an hctx or
the entire request queue, so I didn't expect they'd be turned back on, but
it's easy enough to splice lists and handle those requests directly. We
wouldn'even need to iterate tags that way, and may be better way to
handle this.
