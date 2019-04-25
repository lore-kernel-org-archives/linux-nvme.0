From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 25 Apr 2019 09:00:31 +0800
Subject: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's whole
 lifetime
In-Reply-To: <20190424162746.GE23854@lst.de>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-10-ming.lei@redhat.com>
 <20190424162746.GE23854@lst.de>
Message-ID: <20190425010030.GD22636@ming.t460p>

On Wed, Apr 24, 2019@06:27:46PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019@07:02:21PM +0800, Ming Lei wrote:
> > Hennes reported the following kernel oops:
> 
> Hannes?
> 
> > +	if (!blk_get_queue(ns->queue)) {
> > +		ret = -ENXIO;
> > +		goto out_free_queue;
> > +	}
> 
> If we always need to hold a reference, shouldn't blk_mq_init_queue
> return with that reference held (and yes, that means changes to
> every driver, but it seems like we need to audit all of them anyway..)

The issue is driver(NVMe) specific, the race window is just between
between blk_cleanup_queue() and removing the ns from the controller namspace
list in nvme_ns_remove()

blk_mq_init_queue() does hold one refcount, and its counter-part is
blk_cleanup_queue().

It is simply ugly to ask blk_mq_init_queue() to grab a refcnt for driver,
then who is the counter-part for releasing the extra refcount?

> 
> It seems like the queue lifetimes are a bit of a mess, and I'm not sure
> if this just papers over the problem.

Could you explain a bit what the mess is?


Thanks,
Ming
