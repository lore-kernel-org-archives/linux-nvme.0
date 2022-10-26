Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EADC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 08:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hY5VkvuFMVYOnaYJSX0vFzLrpHx2lJm8Zyr5fYNpwfo=; b=CC1eICHNyBlI3HGNNfbjAzhkGn
	TAng8BMmOlwuVA82QbxmDl4KvGbYeQZI2XRT1ijW4I1ILP8w8nvq92AiOPaJ33shjIBXPPzk6LJEt
	CC3iP4Rtr+H+cB4tV3R1sIuAJ2HNBhEWFNJy38BYtOQyHFNiRnuV92umt0RNAU455oJ6tTgjvqCUK
	yJtSLToxPfrwQ+bRuu+BCd9CBqzseD8MY4abpZV4h80I/DhzfLZp+je52AZPMtjC/sVMv4GjOlJ2h
	Fx+ccT+Sv5RaOYOIReXBzDzDjmm/iZ+XLTtbkdHT++fFO6a7RjRpk3LNiQJynf8L85Y0/2H24K/6d
	U7jr6DiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onc5w-008cnY-Sk; Wed, 26 Oct 2022 08:49:04 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onc5t-008cmv-F1
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 08:49:03 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4My2TY6c89zJnDZ;
	Wed, 26 Oct 2022 16:46:09 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 16:48:55 +0800
Subject: Re: [PATCH 14/17] blk-mq: move the srcu_struct used for quiescing to
 the tagset
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-15-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <12eb7ad8-6b70-092a-978c-a2c1ba595ad4@huawei.com>
Date: Wed, 26 Oct 2022 16:48:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221025144020.260458-15-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_014901_870382_571EB65A 
X-CRM114-Status: GOOD (  23.38  )
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



On 2022/10/25 22:40, Christoph Hellwig wrote:
> All I/O submissions have fairly similar latencies, and a tagset-wide
> quiesce is a fairly common operation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Chao Leng <lengchao@huawei.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   block/blk-core.c       | 27 +++++----------------------
>   block/blk-mq.c         | 33 +++++++++++++++++++++++++--------
>   block/blk-mq.h         | 14 +++++++-------
>   block/blk-sysfs.c      |  9 ++-------
>   block/blk.h            |  9 +--------
>   block/genhd.c          |  2 +-
>   include/linux/blk-mq.h |  4 ++++
>   include/linux/blkdev.h |  9 ---------
>   8 files changed, 45 insertions(+), 62 deletions(-)
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
> index 802fdd3d737e3..6cbf34921e33f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -261,8 +261,8 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>    */
>   void blk_mq_wait_quiesce_done(struct request_queue *q)
>   {
> -	if (blk_queue_has_srcu(q))
> -		synchronize_srcu(q->srcu);
> +	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
> +		synchronize_srcu(q->tag_set->srcu);
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
> @@ -4398,9 +4395,19 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>   	 */
>   	if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
>   		set->nr_hw_queues = nr_cpu_ids;
> +
> +	if (set->flags & BLK_MQ_F_BLOCKING) {
> +		set->srcu = kmalloc(sizeof(*set->srcu), GFP_KERNEL);
Memory with contiguous physical addresses is not necessary, maybe it is a better choice to use kvmalloc,
because sizeof(*set->srcu) is a little large.
kvmalloc() is more friendly to scenarios where memory is insufficient and running for a long time.

