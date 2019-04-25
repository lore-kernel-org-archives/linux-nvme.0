From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 25 Apr 2019 08:53:34 +0800
Subject: [PATCH V7 1/9] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
In-Reply-To: <20190424161834.GA23854@lst.de>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-2-ming.lei@redhat.com>
 <20190424161834.GA23854@lst.de>
Message-ID: <20190425005332.GB22636@ming.t460p>

On Wed, Apr 24, 2019@06:18:34PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019@07:02:13PM +0800, Ming Lei wrote:
> >  		if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
> >  			if (this_hctx) {
> >  				trace_block_unplug(this_q, depth, !from_schedule);
> > +
> > +				percpu_ref_get(&this_q->q_usage_counter);
> >  				blk_mq_sched_insert_requests(this_hctx, this_ctx,
> >  								&rq_list,
> >  								from_schedule);
> > +				percpu_ref_put(&this_q->q_usage_counter);
> >  			}
> >  
> >  			this_q = rq->q;
> > @@ -1757,8 +1760,11 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
> >  	 */
> >  	if (this_hctx) {
> >  		trace_block_unplug(this_q, depth, !from_schedule);
> > +
> > +		percpu_ref_get(&this_q->q_usage_counter);
> >  		blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
> >  						from_schedule);
> > +		percpu_ref_put(&this_q->q_usage_counter);
> 
> Why don't we push this into blk_mq_sched_insert_requests?  Yes, it
> would need a request_queue argument, but that still seems saner
> than duplicating it in both callers.

It isn't in other callers of blk_mq_sched_insert_requests(), it is just
needed in some corner case like flush plug context.

For other callers of blk_mq_sched_insert_requests(), it is guaranteed
that request queue's ref is held.

Thanks,
Ming
