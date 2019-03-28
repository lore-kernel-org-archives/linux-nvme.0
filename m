From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 28 Mar 2019 08:50:57 +0800
Subject: [PATCH V2 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190327133244.GA8448@localhost.localdomain>
References: <20190327085114.12111-1-ming.lei@redhat.com>
 <20190327085114.12111-2-ming.lei@redhat.com>
 <20190327133244.GA8448@localhost.localdomain>
Message-ID: <20190328005056.GA19708@ming.t460p>

On Wed, Mar 27, 2019@07:32:45AM -0600, Keith Busch wrote:
> On Wed, Mar 27, 2019@04:51:13PM +0800, Ming Lei wrote:
> > @@ -594,8 +594,11 @@ static void __blk_mq_complete_request(struct request *rq)
> >  	/*
> >  	 * For a polled request, always complete locallly, it's pointless
> >  	 * to redirect the completion.
> > +	 *
> > +	 * If driver requires to complete the request synchronously,
> > +	 * complete it locally, and it is usually done in error handler.
> >  	 */
> > -	if ((rq->cmd_flags & REQ_HIPRI) ||
> > +	if ((rq->cmd_flags & REQ_HIPRI) || sync ||
> >  	    !test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
> >  		q->mq_ops->complete(rq);
> >  		return;
> 
> I think this is fine and agree this is fixing a problem, but just
> considering an alternative: would it be okay to just temporarily clear
> QUEUE_FLAG_SAME_COMP in the necessary error handling that wants a sync
> completion so that we're not introducing an additional parameter?

But the flag can be changed by sysfs too.

Thanks,
Ming
