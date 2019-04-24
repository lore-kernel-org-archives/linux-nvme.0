From: hch@lst.de (Christoph Hellwig)
Date: Wed, 24 Apr 2019 18:22:23 +0200
Subject: [PATCH V7 4/9] blk-mq: move all hctx alloction &
 initialization into __blk_mq_alloc_and_init_hctx
In-Reply-To: <20190424110221.17435-5-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-5-ming.lei@redhat.com>
Message-ID: <20190424162223.GD23854@lst.de>

On Wed, Apr 24, 2019@07:02:16PM +0800, Ming Lei wrote:
> Move all hctx related allocation and initialization into
> __blk_mq_alloc_and_init_hctx, and prepare for splitting blk_mq_alloc_and_init_hctx
> into real two functions, one is for allocate everything, and another is for
> initializing everyting.
> 
> Cc: Dongli Zhang <dongli.zhang at oracle.com>
> Cc: James Smart <james.smart at broadcom.com>
> Cc: Bart Van Assche <bart.vanassche at wdc.com>
> Cc: linux-scsi at vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen at oracle.com>,
> Cc: Christoph Hellwig <hch at lst.de>,
> Cc: James E . J . Bottomley <jejb at linux.vnet.ibm.com>,
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Tested-by: James Smart <james.smart at broadcom.com>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>  block/blk-mq.c | 93 +++++++++++++++++++++++++++-------------------------------
>  1 file changed, 44 insertions(+), 49 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 862eb41f24f8..fea25363488d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2290,15 +2290,45 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
>  	}
>  }
>  
> -static int blk_mq_init_hctx(struct request_queue *q,
> -		struct blk_mq_tag_set *set,
> -		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
> +static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
>  {
> -	int node;
> +	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
> +
> +	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, srcu),
> +			   __alignof__(struct blk_mq_hw_ctx)) !=
> +		     sizeof(struct blk_mq_hw_ctx));
> +
> +	if (tag_set->flags & BLK_MQ_F_BLOCKING)
> +		hw_ctx_size += sizeof(struct srcu_struct);
> +
> +	return hw_ctx_size;
> +}
> +
> +static struct blk_mq_hw_ctx *
> +__blk_mq_alloc_and_init_hctx(struct request_queue *q,
> +			     struct blk_mq_tag_set *set,
> +			     unsigned hctx_idx, int node)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	hctx = kzalloc_node(blk_mq_hw_ctx_size(set),
> +			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
> +			node);
> +	if (!hctx)
> +		goto fail_alloc_hctx;
> +
> +	if (!zalloc_cpumask_var_node(&hctx->cpumask,
> +				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,

Maybe throw in a

	const gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;

as the first line to shorten these two a bit..

>  static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
>  		struct blk_mq_tag_set *set, struct request_queue *q,
>  		int hctx_idx, int node)
>  {
> +	return __blk_mq_alloc_and_init_hctx(q, set, hctx_idx, node);
>  }

I really don't the point of this wrapper.  If we need it later
we should introduce it there.
