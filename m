From: bart.vanassche@wdc.com (Bart Van Assche)
Date: Thu, 28 Jun 2018 14:12:38 -0700
Subject: [PATCH 1/5] blk-mq: add API to get hctx index from request
In-Reply-To: <20180628205601.13742-1-keith.busch@intel.com>
References: <20180628205601.13742-1-keith.busch@intel.com>
Message-ID: <57c119c3-5704-0dcb-96dd-fede99c49511@wdc.com>

On 06/28/18 14:03, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   block/blk-mq.c         | 6 ++++++
>   include/linux/blk-mq.h | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b429d515b568..c6478833464d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -466,6 +466,12 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
>   
> +unsigned int blk_mq_request_hctx_idx(struct request *rq)
> +{
> +	return blk_mq_map_queue(rq->q, rq->mq_ctx->cpu)->queue_num;
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_request_hctx_idx);
> +
>   static void __blk_mq_free_request(struct request *rq)
>   {
>   	struct request_queue *q = rq->q;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index e3147eb74222..af91b2d31a04 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -248,6 +248,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
>   }

When posting a patch series, please include a cover letter that explains 
the purpose of the patch series.

Regarding the above patch: have you considered to use the existing 
function blk_mq_unique_tag_to_hwq() instead of introducing this new 
function?

Thanks,

Bart.
