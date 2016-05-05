From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 5 May 2016 15:34:11 -0600
Subject: [PATCH 1/2] block: add queue flag to always poll
In-Reply-To: <x49lh3o5hcs.fsf@segfault.boston.devel.redhat.com>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <1459455554-2794-2-git-send-email-jonathan.derrick@intel.com>
 <x49lh3o5hcs.fsf@segfault.boston.devel.redhat.com>
Message-ID: <20160505213411.GA14146@localhost.localdomain>

On Thu, May 05, 2016@05:23:47PM -0400, Jeff Moyer wrote:
> Jon Derrick <jonathan.derrick at intel.com> writes:
> 
> > This patch adds poll-by-default functionality back for 4.6 by adding a
> > queue flag which specifies that it should always try polling, rather
> > than only if the io specifies it.
> 
> I'm not against the functionality, but it somehow feels like you've
> implemented this at the wrong layer.  I'd much rather polling be forced
> on for the file or the mountpoint, and then all requests would come down
> with RWF_HIPRI and there would be no special casing in the direct I/O
> code.
It was mainly grouped with common code.

I'll look into your suggestion of tagging HIPRI on file or mountpoint.


> 
> In case others disagree, I've provided a couple of comments below.
> Really, though, I think this is implemented upside-down.
> 
> -Jeff
> 
> > Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
> > ---
> >  block/blk-core.c       | 8 ++++++++
> >  fs/direct-io.c         | 7 ++++++-
> >  include/linux/blkdev.h | 2 ++
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 827f8ba..d85f913 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -3335,6 +3335,14 @@ void blk_finish_plug(struct blk_plug *plug)
> >  }
> >  EXPORT_SYMBOL(blk_finish_plug);
> >  
> > +bool blk_force_poll(struct request_queue *q)
> > +{
> > +	if (!q->mq_ops || !q->mq_ops->poll ||
> > +	    !test_bit(QUEUE_FLAG_POLL_FORCE, &q->queue_flags))
> > +		return false;
> > +	return true;
> > +}
> 
> The flag shouldn't be set if it doesn't make sense, and these checks are
> re-done inside blk_poll, anyway.  Just do the test bit:
> 
> 	return test_bit(QUEUE_FLAG_POLL_FORCE, &q->queue_flags);
> 
Yeah I noticed that too after posting v1, but I didn't get much interest into
proposing v2. Thanks for catching that and reminding me of it.


> >  bool blk_poll(struct request_queue *q, blk_qc_t cookie)
> >  {
> >  	struct blk_plug *plug;
> > diff --git a/fs/direct-io.c b/fs/direct-io.c
> > index 476f1ec..2775552 100644
> > --- a/fs/direct-io.c
> > +++ b/fs/direct-io.c
> > @@ -450,7 +450,12 @@ static struct bio *dio_await_one(struct dio *dio)
> >  		__set_current_state(TASK_UNINTERRUPTIBLE);
> >  		dio->waiter = current;
> >  		spin_unlock_irqrestore(&dio->bio_lock, flags);
> > -		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
> > +		/*
> > +		 * Polling must be enabled explicitly on a per-IO basis,
> > +		 * or through the queue's sysfs io_poll_force control
> > +		 */
> > +		if (!((dio->iocb->ki_flags & IOCB_HIPRI) ||
> > +		      (blk_force_poll(bdev_get_queue(dio->bio_bdev)))) ||
> >  		    !blk_poll(bdev_get_queue(dio->bio_bdev), dio->bio_cookie))
> 
> Make a local variable for the queue, please.
> 
Sounds good

> -Jeff
