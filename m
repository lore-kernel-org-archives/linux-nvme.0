From: hch@lst.de (Christoph Hellwig)
Date: Wed, 24 Apr 2019 18:18:56 +0200
Subject: [PATCH V7 2/9] blk-mq: move cancel of requeue_work into
 blk_mq_release
In-Reply-To: <20190424110221.17435-3-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-3-ming.lei@redhat.com>
Message-ID: <20190424161856.GB23854@lst.de>

On Wed, Apr 24, 2019@07:02:14PM +0800, Ming Lei wrote:
> With holding queue's kobject refcount, it is safe for driver
> to schedule requeue. However, blk_mq_kick_requeue_list() may
> be called after blk_sync_queue() is done because of concurrent
> requeue activities, then requeue work may not be completed when
> freeing queue, and kernel oops is triggered.
> 
> So moving the cancel of requeue_work into blk_mq_release() for
> avoiding race between requeue and freeing queue.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
