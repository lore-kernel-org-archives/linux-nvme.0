From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 27 Apr 2019 06:45:43 +0800
Subject: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's whole
 lifetime
In-Reply-To: <20190426151114.GB20438@lst.de>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-10-ming.lei@redhat.com>
 <20190424162746.GE23854@lst.de> <20190425010030.GD22636@ming.t460p>
 <20190426151114.GB20438@lst.de>
Message-ID: <20190426224542.GD31470@ming.t460p>

On Fri, Apr 26, 2019@05:11:14PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 25, 2019@09:00:31AM +0800, Ming Lei wrote:
> > The issue is driver(NVMe) specific, the race window is just between
> > between blk_cleanup_queue() and removing the ns from the controller namspace
> > list in nvme_ns_remove()
> 
> And I wouldn't be surprised if others have the same issue.

SCSI hasn't such issue, and loop/null/virtio-blk doesn't too.

> 
> > 
> > blk_mq_init_queue() does hold one refcount, and its counter-part is
> > blk_cleanup_queue().
> > 
> > It is simply ugly to ask blk_mq_init_queue() to grab a refcnt for driver,
> > then who is the counter-part for releasing the extra refcount?
> 
> Well, the problem is exactly that blk_cleanup_queue drops the reference.
> If move the blk_put_queue() call from the end of it to the callers the
> callers can keep the reference as long as they need them, and we wouldn't
> need an extra reference.

It depends on driver.

Still no difference between your suggestion and the way in this patch, given
driver specific change is a must. Even it is more clean to hold the
queue refocunt by drivers explicitly because we usually do the get/put pair
in one place, instead that getting refcnt in one subsystem, and doing put in
another place.

I am going to drop this patch in V8 since my original plan is to fix block
layer's race in this patchset.


Thanks,
Ming
