From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 22 Apr 2019 11:30:59 +0800
Subject: [PATCH V6 6/9] blk-mq: always free hctx after request queue is
 freed
In-Reply-To: <20190417125943.GB5007@ming.t460p>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-7-ming.lei@redhat.com>
 <63c09210-c20e-6b4a-56fa-b9eac2807cc1@suse.de>
 <20190417125943.GB5007@ming.t460p>
Message-ID: <20190422033057.GC21375@ming.t460p>

On Wed, Apr 17, 2019@08:59:43PM +0800, Ming Lei wrote:
> On Wed, Apr 17, 2019@02:08:59PM +0200, Hannes Reinecke wrote:
> > On 4/17/19 5:44 AM, Ming Lei wrote:
> > > In normal queue cleanup path, hctx is released after request queue
> > > is freed, see blk_mq_release().
> > > 
> > > However, in __blk_mq_update_nr_hw_queues(), hctx may be freed because
> > > of hw queues shrinking. This way is easy to cause use-after-free,
> > > because: one implicit rule is that it is safe to call almost all block
> > > layer APIs if the request queue is alive; and one hctx may be retrieved
> > > by one API, then the hctx can be freed by blk_mq_update_nr_hw_queues();
> > > finally use-after-free is triggered.
> > > 
> > > Fixes this issue by always freeing hctx after releasing request queue.
> > > If some hctxs are removed in blk_mq_update_nr_hw_queues(), introduce
> > > a per-queue list to hold them, then try to resuse these hctxs if numa
> > > node is matched.
> > > 
> > > Cc: Dongli Zhang <dongli.zhang at oracle.com>
> > > Cc: James Smart <james.smart at broadcom.com>
> > > Cc: Bart Van Assche <bart.vanassche at wdc.com>
> > > Cc: linux-scsi at vger.kernel.org,
> > > Cc: Martin K . Petersen <martin.petersen at oracle.com>,
> > > Cc: Christoph Hellwig <hch at lst.de>,
> > > Cc: James E . J . Bottomley <jejb at linux.vnet.ibm.com>,
> > > Cc: jianchao wang <jianchao.w.wang at oracle.com>
> > > Signed-off-by: Ming Lei <ming.lei at redhat.com>
> > > ---
> > >   block/blk-mq.c         | 40 +++++++++++++++++++++++++++-------------
> > >   include/linux/blk-mq.h |  2 ++
> > >   include/linux/blkdev.h |  7 +++++++
> > >   3 files changed, 36 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index eeebba6ec0f7..2ca4395f794d 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -2274,6 +2274,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
> > >   		set->ops->exit_hctx(hctx, hctx_idx);
> > >   	blk_mq_remove_cpuhp(hctx);
> > > +
> > > +	spin_lock(&q->dead_hctx_lock);
> > > +	list_add(&hctx->hctx_list, &q->dead_hctx_list);
> > > +	spin_unlock(&q->dead_hctx_lock);
> > >   }
> > >   static void blk_mq_exit_hw_queues(struct request_queue *q,
> > > @@ -2675,15 +2679,13 @@ static int blk_mq_alloc_ctxs(struct request_queue *q)
> > >    */
> > >   void blk_mq_release(struct request_queue *q)
> > >   {
> > > -	struct blk_mq_hw_ctx *hctx;
> > > -	unsigned int i;
> > > +	struct blk_mq_hw_ctx *hctx, *next;
> > >   	cancel_delayed_work_sync(&q->requeue_work);
> > > -	/* hctx kobj stays in hctx */
> > > -	queue_for_each_hw_ctx(q, hctx, i) {
> > > -		if (!hctx)
> > > -			continue;
> > > +	/* all hctx are in .dead_hctx_list now */
> > > +	list_for_each_entry_safe(hctx, next, &q->dead_hctx_list, hctx_list) {
> > > +		list_del_init(&hctx->hctx_list);
> > >   		kobject_put(&hctx->kobj);
> > >   	}
> > > @@ -2750,9 +2752,22 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
> > >   		struct blk_mq_tag_set *set, struct request_queue *q,
> > >   		int hctx_idx, int node)
> > >   {
> > > -	struct blk_mq_hw_ctx *hctx;
> > > +	struct blk_mq_hw_ctx *hctx = NULL, *tmp;
> > > +
> > > +	/* reuse dead hctx first */
> > > +	spin_lock(&q->dead_hctx_lock);
> > > +	list_for_each_entry(tmp, &q->dead_hctx_list, hctx_list) {
> > > +		if (tmp->numa_node == node) {
> > > +			hctx = tmp;
> > > +			break;
> > > +		}
> > > +	}
> > > +	if (hctx)
> > > +		list_del_init(&hctx->hctx_list);
> > > +	spin_unlock(&q->dead_hctx_lock);
> > > -	hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
> > > +	if (!hctx)
> > > +		hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
> > >   	if (!hctx)
> > >   		goto fail;
> > > @@ -2790,10 +2805,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> > >   		hctx = blk_mq_alloc_and_init_hctx(set, q, i, node);
> > >   		if (hctx) {
> > > -			if (hctxs[i]) {
> > > +			if (hctxs[i])
> > >   				blk_mq_exit_hctx(q, set, hctxs[i], i);
> > > -				kobject_put(&hctxs[i]->kobj);
> > > -			}
> > >   			hctxs[i] = hctx;
> > >   		} else {
> > >   			if (hctxs[i])
> > > @@ -2824,9 +2837,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> > >   			if (hctx->tags)
> > >   				blk_mq_free_map_and_requests(set, j);
> > >   			blk_mq_exit_hctx(q, set, hctx, j);
> > > -			kobject_put(&hctx->kobj);
> > >   			hctxs[j] = NULL;
> > > -
> > >   		}
> > >   	}
> > >   	mutex_unlock(&q->sysfs_lock);
> > > @@ -2869,6 +2880,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
> > >   	if (!q->queue_hw_ctx)
> > >   		goto err_sys_init;
> > > +	INIT_LIST_HEAD(&q->dead_hctx_list);
> > > +	spin_lock_init(&q->dead_hctx_lock);
> > > +
> > >   	blk_mq_realloc_hw_ctxs(set, q);
> > >   	if (!q->nr_hw_queues)
> > >   		goto err_hctxs;
> > > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > > index db29928de467..15d1aa53d96c 100644
> > > --- a/include/linux/blk-mq.h
> > > +++ b/include/linux/blk-mq.h
> > > @@ -70,6 +70,8 @@ struct blk_mq_hw_ctx {
> > >   	struct dentry		*sched_debugfs_dir;
> > >   #endif
> > > +	struct list_head	hctx_list;
> > > +
> > >   	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
> > >   	struct srcu_struct	srcu[0];
> > >   };
> > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > index 4b85dc066264..1325f941f0be 100644
> > > --- a/include/linux/blkdev.h
> > > +++ b/include/linux/blkdev.h
> > > @@ -535,6 +535,13 @@ struct request_queue {
> > >   	struct mutex		sysfs_lock;
> > > +	/*
> > > +	 * for reusing dead hctx instance in case of updating
> > > +	 * nr_hw_queues
> > > +	 */
> > > +	struct list_head	dead_hctx_list;
> > > +	spinlock_t		dead_hctx_lock;
> > > +
> > >   	atomic_t		mq_freeze_depth;
> > >   #if defined(CONFIG_BLK_DEV_BSG)
> > > 
> > Hmm.
> > I don't particularly like this approach.
> > The much saner approach would be to avoid having I/O in-flight in the first
> > place by setting the queue to something else than live, no?
> 
> There isn't any in-flight IO since blk_mq_freeze_queue() is returned
> from __blk_mq_update_nr_hw_queues().
> 
> However, there can be reference to hctx in other code paths via
> arbitrary block layer APIs.
> 
> Quiesce can't avoid the use-after-free too given RCU read lock may
> not be held in lots of reference to hctx, such as queue_for_each_hw_ctx().
> 
> So this patch might be the simplest approach to fix this issue, IMO.
> 
> However, I am open to any solution for this issue.

Hi Hannes,

Could you please let us know if you have better idea for this issue?
Otherwise, I think we need to move on since it is real issue, and users
want to fix that.

Thanks,
Ming
