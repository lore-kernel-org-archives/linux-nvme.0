From: hch@lst.de (Christoph Hellwig)
Date: Fri, 26 Apr 2019 17:11:14 +0200
Subject: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's
 whole lifetime
In-Reply-To: <20190425010030.GD22636@ming.t460p>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-10-ming.lei@redhat.com> <20190424162746.GE23854@lst.de>
 <20190425010030.GD22636@ming.t460p>
Message-ID: <20190426151114.GB20438@lst.de>

On Thu, Apr 25, 2019@09:00:31AM +0800, Ming Lei wrote:
> The issue is driver(NVMe) specific, the race window is just between
> between blk_cleanup_queue() and removing the ns from the controller namspace
> list in nvme_ns_remove()

And I wouldn't be surprised if others have the same issue.

> 
> blk_mq_init_queue() does hold one refcount, and its counter-part is
> blk_cleanup_queue().
> 
> It is simply ugly to ask blk_mq_init_queue() to grab a refcnt for driver,
> then who is the counter-part for releasing the extra refcount?

Well, the problem is exactly that blk_cleanup_queue drops the reference.
If move the blk_put_queue() call from the end of it to the callers the
callers can keep the reference as long as they need them, and we wouldn't
need an extra reference.
