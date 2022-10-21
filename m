Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D77C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 02:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tL/scdzMmBbbzeh+bIAuOYDtdt8ckyh8oTHJKEe5EWM=; b=v4p4dEbSbk9wuwS6fo9MVGAdmH
	E8tgIpLkqbw6pnfIjp1Xk5oWAbcMMFkqy8wSUM2+A4DPtYqzSUmz4ChSiqDsozksqgjCoc64bZ2/6
	UU22Nxp6iyg4+09ydDpPqGR5PYrBIl4XAxwxj2LfOGlrMVO/+W0FWAR54pPJc+C9MxDrP8yeLwGW2
	4b91oUxnRRWeQJ0JERXl9/59G8M1ot2EBZpxfB+RxwGMUb3suAraIlXcQhisBOgg9qN86JcfD8ykV
	31uw1BeU+IKkf7PWitWzVavsABs5Uy6q1ToXcYK3ZnZ/h48kHycHrP7MlmQQjIArfaNUyfRsOpF1v
	pXPqFTVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oli68-004Z28-4G; Fri, 21 Oct 2022 02:49:24 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oli64-004Yyn-SU
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 02:49:23 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtpkC6VftzpVYD;
	Fri, 21 Oct 2022 10:45:55 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:49:15 +0800
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-4-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <74a50cf4-713b-1c12-922b-4a614e0b681a@huawei.com>
Date: Fri, 21 Oct 2022 10:49:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221020105608.1581940-4-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_194921_317383_D3B57267 
X-CRM114-Status: GOOD (  31.35  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/10/20 18:56, Christoph Hellwig wrote:
> All I/O submissions have fairly similar latencies, and a tagset-wide
> quiesce is a fairly common operation.  Becuase there are a lot less
> tagsets there is also no need for the variable size allocation trick.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c       | 27 +++++----------------------
>   block/blk-mq.c         | 25 +++++++++++++++++--------
>   block/blk-mq.h         | 14 +++++++-------
>   block/blk-sysfs.c      |  9 ++-------
>   block/blk.h            |  9 +--------
>   block/genhd.c          |  2 +-
>   include/linux/blk-mq.h |  4 ++++
>   include/linux/blkdev.h |  9 ---------
>   8 files changed, 37 insertions(+), 62 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 17667159482e0..3a2ed8dadf738 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -65,7 +65,6 @@ DEFINE_IDA(blk_queue_ida);
>    * For queue allocation
>    */
>   struct kmem_cache *blk_requestq_cachep;
> -struct kmem_cache *blk_requestq_srcu_cachep;
>   
>   /*
>    * Controlling structure to kblockd
> @@ -373,26 +372,20 @@ static void blk_timeout_work(struct work_struct *work)
>   {
>   }
>   
> -struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
> +struct request_queue *blk_alloc_queue(int node_id)
>   {
>   	struct request_queue *q;
>   
> -	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
> -			GFP_KERNEL | __GFP_ZERO, node_id);
> +	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | __GFP_ZERO,
> +				  node_id);
>   	if (!q)
>   		return NULL;
>   
> -	if (alloc_srcu) {
> -		blk_queue_flag_set(QUEUE_FLAG_HAS_SRCU, q);
> -		if (init_srcu_struct(q->srcu) != 0)
> -			goto fail_q;
> -	}
> -
>   	q->last_merge = NULL;
>   
>   	q->id = ida_alloc(&blk_queue_ida, GFP_KERNEL);
>   	if (q->id < 0)
> -		goto fail_srcu;
> +		goto fail_q;
>   
>   	q->stats = blk_alloc_queue_stats();
>   	if (!q->stats)
> @@ -435,11 +428,8 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>   	blk_free_queue_stats(q->stats);
>   fail_id:
>   	ida_free(&blk_queue_ida, q->id);
> -fail_srcu:
> -	if (alloc_srcu)
> -		cleanup_srcu_struct(q->srcu);
>   fail_q:
> -	kmem_cache_free(blk_get_queue_kmem_cache(alloc_srcu), q);
> +	kmem_cache_free(blk_requestq_cachep, q);
>   	return NULL;
>   }
>   
> @@ -1184,9 +1174,6 @@ int __init blk_dev_init(void)
>   			sizeof_field(struct request, cmd_flags));
>   	BUILD_BUG_ON(REQ_OP_BITS + REQ_FLAG_BITS > 8 *
>   			sizeof_field(struct bio, bi_opf));
> -	BUILD_BUG_ON(ALIGN(offsetof(struct request_queue, srcu),
> -			   __alignof__(struct request_queue)) !=
> -		     sizeof(struct request_queue));
>   
>   	/* used for unplugging and affects IO latency/throughput - HIGHPRI */
>   	kblockd_workqueue = alloc_workqueue("kblockd",
> @@ -1197,10 +1184,6 @@ int __init blk_dev_init(void)
>   	blk_requestq_cachep = kmem_cache_create("request_queue",
>   			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
>   
> -	blk_requestq_srcu_cachep = kmem_cache_create("request_queue_srcu",
> -			sizeof(struct request_queue) +
> -			sizeof(struct srcu_struct), 0, SLAB_PANIC, NULL);
> -
>   	blk_debugfs_root = debugfs_create_dir("block", NULL);
>   
>   	return 0;
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index df967c8af9fee..4a81a2da43328 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -261,8 +261,8 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>    */
>   void blk_mq_wait_quiesce_done(struct request_queue *q)
>   {
> -	if (blk_queue_has_srcu(q))
> -		synchronize_srcu(q->srcu);
> +	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
> +		synchronize_srcu(&q->tag_set->srcu);
>   	else
>   		synchronize_rcu();
>   }
> @@ -3971,7 +3971,7 @@ static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
>   	struct request_queue *q;
>   	int ret;
>   
> -	q = blk_alloc_queue(set->numa_node, set->flags & BLK_MQ_F_BLOCKING);
> +	q = blk_alloc_queue(set->numa_node);
>   	if (!q)
>   		return ERR_PTR(-ENOMEM);
>   	q->queuedata = queuedata;
> @@ -4138,9 +4138,6 @@ static void blk_mq_update_poll_flag(struct request_queue *q)
>   int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>   		struct request_queue *q)
>   {
> -	WARN_ON_ONCE(blk_queue_has_srcu(q) !=
> -			!!(set->flags & BLK_MQ_F_BLOCKING));
> -
>   	/* mark the queue as mq asap */
>   	q->mq_ops = set->ops;
>   
> @@ -4398,9 +4395,16 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>   	 */
>   	if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
>   		set->nr_hw_queues = nr_cpu_ids;
> +
> +	if (set->flags & BLK_MQ_F_BLOCKING) {
> +		ret = init_srcu_struct(&set->srcu);
> +		if (ret)
> +			return ret;
> +	}
>   
> -	if (blk_mq_alloc_tag_set_tags(set, set->nr_hw_queues) < 0)
> -		return -ENOMEM;
> +	ret = blk_mq_alloc_tag_set_tags(set, set->nr_hw_queues);
> +	if (ret)
> +		goto out_free_srcu;
>   
>   	ret = -ENOMEM;
>   	for (i = 0; i < set->nr_maps; i++) {
> @@ -4430,6 +4434,9 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>   	}
>   	kfree(set->tags);
>   	set->tags = NULL;
> +out_free_srcu:
> +	if (set->flags & BLK_MQ_F_BLOCKING)
> +		cleanup_srcu_struct(&set->srcu);
>   	return ret;
>   }
>   EXPORT_SYMBOL(blk_mq_alloc_tag_set);
> @@ -4469,6 +4476,8 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
>   
>   	kfree(set->tags);
>   	set->tags = NULL;
> +	if (set->flags & BLK_MQ_F_BLOCKING)
> +		cleanup_srcu_struct(&set->srcu);
>   }
>   EXPORT_SYMBOL(blk_mq_free_tag_set);
>   
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 0b2870839cdd6..06eb46d1d7a76 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -377,17 +377,17 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
>   /* run the code block in @dispatch_ops with rcu/srcu read lock held */
>   #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
>   do {								\
> -	if (!blk_queue_has_srcu(q)) {				\
> -		rcu_read_lock();				\
> -		(dispatch_ops);					\
> -		rcu_read_unlock();				\
> -	} else {						\
> +	if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {		\
>   		int srcu_idx;					\
>   								\
>   		might_sleep_if(check_sleep);			\
> -		srcu_idx = srcu_read_lock((q)->srcu);		\
> +		srcu_idx = srcu_read_lock(&((q)->tag_set->srcu)); \
>   		(dispatch_ops);					\
> -		srcu_read_unlock((q)->srcu, srcu_idx);		\
> +		srcu_read_unlock(&((q)->tag_set->srcu), srcu_idx); \
> +	} else {						\
> +		rcu_read_lock();				\
> +		(dispatch_ops);					\
> +		rcu_read_unlock();				\
>   	}							\
>   } while (0)
>   
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e71b3b43927c0..e7871665825a3 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -739,10 +739,8 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>   
>   static void blk_free_queue_rcu(struct rcu_head *rcu_head)
>   {
> -	struct request_queue *q = container_of(rcu_head, struct request_queue,
> -					       rcu_head);
> -
> -	kmem_cache_free(blk_get_queue_kmem_cache(blk_queue_has_srcu(q)), q);
> +	kmem_cache_free(blk_requestq_cachep,
> +			container_of(rcu_head, struct request_queue, rcu_head));
>   }
>   
>   /**
> @@ -779,9 +777,6 @@ static void blk_release_queue(struct kobject *kobj)
>   	if (queue_is_mq(q))
>   		blk_mq_release(q);
>   
> -	if (blk_queue_has_srcu(q))
> -		cleanup_srcu_struct(q->srcu);
> -
>   	ida_free(&blk_queue_ida, q->id);
>   	call_rcu(&q->rcu_head, blk_free_queue_rcu);
>   }
> diff --git a/block/blk.h b/block/blk.h
> index 5350bf363035e..b25e2d22f3725 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -27,7 +27,6 @@ struct blk_flush_queue {
>   };
>   
>   extern struct kmem_cache *blk_requestq_cachep;
> -extern struct kmem_cache *blk_requestq_srcu_cachep;
>   extern struct kobj_type blk_queue_ktype;
>   extern struct ida blk_queue_ida;
>   
> @@ -420,13 +419,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>   		struct page *page, unsigned int len, unsigned int offset,
>   		unsigned int max_sectors, bool *same_page);
>   
> -static inline struct kmem_cache *blk_get_queue_kmem_cache(bool srcu)
> -{
> -	if (srcu)
> -		return blk_requestq_srcu_cachep;
> -	return blk_requestq_cachep;
> -}
> -struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu);
> +struct request_queue *blk_alloc_queue(int node_id);
>   
>   int disk_scan_partitions(struct gendisk *disk, fmode_t mode);
>   
> diff --git a/block/genhd.c b/block/genhd.c
> index 2877b5f905579..fd0b13d6175a3 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1410,7 +1410,7 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
>   	struct request_queue *q;
>   	struct gendisk *disk;
>   
> -	q = blk_alloc_queue(node, false);
> +	q = blk_alloc_queue(node);
>   	if (!q)
>   		return NULL;
>   
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index ba18e9bdb799b..f040a7cab5dbf 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -7,6 +7,7 @@
>   #include <linux/lockdep.h>
>   #include <linux/scatterlist.h>
>   #include <linux/prefetch.h>
> +#include <linux/srcu.h>
>   
>   struct blk_mq_tags;
>   struct blk_flush_queue;
> @@ -501,6 +502,8 @@ enum hctx_type {
>    * @tag_list_lock: Serializes tag_list accesses.
>    * @tag_list:	   List of the request queues that use this tag set. See also
>    *		   request_queue.tag_set_list.
> + * @srcu:	   Use as lock when type of the request queue is blocking
> + *		   (BLK_MQ_F_BLOCKING). Must be the last member
>    */
>   struct blk_mq_tag_set {
>   	struct blk_mq_queue_map	map[HCTX_MAX_TYPES];
> @@ -521,6 +524,7 @@ struct blk_mq_tag_set {
>   
>   	struct mutex		tag_list_lock;
>   	struct list_head	tag_list;
> +	struct srcu_struct	srcu;
>   };
>   
>   /**
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 50e358a19d986..b15b6a011c028 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -22,7 +22,6 @@
>   #include <linux/blkzoned.h>
>   #include <linux/sched.h>
>   #include <linux/sbitmap.h>
> -#include <linux/srcu.h>
>   #include <linux/uuid.h>
>   #include <linux/xarray.h>
>   
> @@ -543,18 +542,11 @@ struct request_queue {
>   	struct mutex		debugfs_mutex;
>   
>   	bool			mq_sysfs_init_done;
> -
> -	/**
> -	 * @srcu: Sleepable RCU. Use as lock when type of the request queue
> -	 * is blocking (BLK_MQ_F_BLOCKING). Must be the last member
> -	 */
> -	struct srcu_struct	srcu[];
>   };
>   
>   /* Keep blk_queue_flag_name[] in sync with the definitions below */
>   #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
>   #define QUEUE_FLAG_DYING	1	/* queue being torn down */
> -#define QUEUE_FLAG_HAS_SRCU	2	/* SRCU is allocated */
>   #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
>   #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
>   #define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
> @@ -590,7 +582,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>   
>   #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
>   #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
> -#define blk_queue_has_srcu(q)	test_bit(QUEUE_FLAG_HAS_SRCU, &(q)->queue_flags)
>   #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
>   #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
>   #define blk_queue_noxmerges(q)	\
> 

