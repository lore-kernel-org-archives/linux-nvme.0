From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Dec 2018 16:49:56 -0800
Subject: [PATCH 01/13] block: move queues types to the block layer
In-Reply-To: <20181202164628.1116-2-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-2-hch@lst.de>
Message-ID: <5a1cd7aa-8937-ae23-c9ae-c8ddaf525080@grimberg.me>



On 12/2/18 8:46 AM, Christoph Hellwig wrote:
> Having another indirect all in the fast path doesn't really help
> in our post-spectre world.  Also having too many queue type is just
> going to create confusion, so I'd rather manage them centrally.
> 
> Note that the queue type naming and ordering changes a bit - the
> first index now is the default queue for everything not explicitly
> marked, the optional ones are read and poll queues.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   block/blk-mq-sysfs.c    |  9 +++++-
>   block/blk-mq.h          | 21 +++++++------
>   drivers/nvme/host/pci.c | 68 +++++++++++++++--------------------------
>   include/linux/blk-mq.h  | 15 ++++-----
>   4 files changed, 51 insertions(+), 62 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 6efef1f679f0..9c2df137256a 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -173,9 +173,16 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
>   	return ret;
>   }
>   
> +static const char *const hctx_types[] = {
> +	[HCTX_TYPE_DEFAULT]	= "default",
> +	[HCTX_TYPE_READ]	= "read",
> +	[HCTX_TYPE_POLL]	= "poll",
> +};
> +
>   static ssize_t blk_mq_hw_sysfs_type_show(struct blk_mq_hw_ctx *hctx, char *page)
>   {
> -	return sprintf(page, "%u\n", hctx->type);
> +	BUILD_BUG_ON(ARRAY_SIZE(hctx_types) != HCTX_MAX_TYPES);
> +	return sprintf(page, "%s\n", hctx_types[hctx->type]);
>   }
>   
>   static struct attribute *default_ctx_attrs[] = {
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 7291e5379358..a664ea44ffd4 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -81,16 +81,14 @@ extern int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int);
>   /*
>    * blk_mq_map_queue_type() - map (hctx_type,cpu) to hardware queue
>    * @q: request queue
> - * @hctx_type: the hctx type index
> + * @type: the hctx type index
>    * @cpu: CPU
>    */
>   static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
> -							  unsigned int hctx_type,
> +							  enum hctx_type type,
>   							  unsigned int cpu)
>   {
> -	struct blk_mq_tag_set *set = q->tag_set;
> -
> -	return q->queue_hw_ctx[set->map[hctx_type].mq_map[cpu]];
> +	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
>   }
>   
>   /*
> @@ -103,12 +101,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>   						     unsigned int flags,
>   						     unsigned int cpu)
>   {
> -	int hctx_type = 0;
> +	enum hctx_type type = HCTX_TYPE_DEFAULT;
> +
> +	if (q->tag_set->nr_maps > HCTX_TYPE_POLL &&
> +	    ((flags & REQ_HIPRI) && test_bit(QUEUE_FLAG_POLL, &q->queue_flags)))
> +		type = HCTX_TYPE_POLL;
>   
> -	if (q->mq_ops->rq_flags_to_type)
> -		hctx_type = q->mq_ops->rq_flags_to_type(q, flags);
> +	else if (q->tag_set->nr_maps > HCTX_TYPE_READ &&
> +		 ((flags & REQ_OP_MASK) == REQ_OP_READ))
> +		type = HCTX_TYPE_READ;

Nit, there seems to be an extra newline that can be omitted here before
the else if statement (if I'm reading this correctly)...

Otherwise looks good,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
