From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 18 Jul 2018 18:34:07 +0000
Subject: [RFC PATCH] blk-mq: move timeout handling from queue to tagset
In-Reply-To: <20180718174534.GC30873@localhost.localdomain>
References: <20180718170018.31395-1-keith.busch@intel.com>
 <11f7a7aff754b9bb0e4243ac4502319f376378c3.camel@wdc.com>
 <20180718174534.GC30873@localhost.localdomain>
Message-ID: <adbe32bb3da7b0d405a57a176888be40f76581cb.camel@wdc.com>

On Wed, 2018-07-18@11:45 -0600, Keith Busch wrote:
> On Wed, Jul 18, 2018@05:18:45PM +0000, Bart Van Assche wrote:
> > On Wed, 2018-07-18@11:00 -0600, Keith Busch wrote:
> > > -	cancel_work_sync(&q->timeout_work);
> > > -
> > >  	if (q->mq_ops) {
> > >  		struct blk_mq_hw_ctx *hctx;
> > >  		int i;
> > > @@ -415,6 +412,8 @@ void blk_sync_queue(struct request_queue *q)
> > >  		queue_for_each_hw_ctx(q, hctx, i)
> > >  			cancel_delayed_work_sync(&hctx->run_work);
> > >  	} else {
> > > +		del_timer_sync(&q->timeout);
> > > +		cancel_work_sync(&q->timeout_work);
> > >  		cancel_delayed_work_sync(&q->delay_work);
> > >  	}
> > >  }
> > 
> > What is the impact of this change on the md driver, which is the only driver
> > that calls blk_sync_queue() directly? What will happen if timeout processing
> > happens concurrently with or after blk_sync_queue() has returned?
> 
> That's a make_request_fn stacking driver, right? There should be
> no impact in that case, since the change above affects only mq.
> 
> I'm actually a little puzzled why md calls blk_sync_queue. Are the
> queue timers ever used for bio-based drivers?

Hello Keith,

For all md drivers that I verified calling md_make_request() triggers one or
more generic_make_request() calls for the underlying devices. So it's not
clear to me why the md driver calls blk_sync_queue().

Bart.
