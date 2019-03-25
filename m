From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 25 Mar 2019 05:13:12 +0000
Subject: [PATCH 04/15] block: add dma_map_bvec helper
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-5-hch@lst.de>
Message-ID: <SN6PR04MB45275805E2B9D840D63E4E12865E0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/21/19 4:11 PM, Christoph Hellwig wrote:
> Provide a nice little shortcut for mapping a single bvec.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   include/linux/blkdev.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 5279104527ad..322ff969659c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -641,6 +641,10 @@ static inline bool blk_account_rq(struct request *rq)
>   #define rq_dma_dir(rq) \
>   	(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
>   
> +#define dma_map_bvec(dev, bv, dir, attrs) \
> +	dma_map_page_attrs(dev, (bv)->bv_page, (bv)->bv_offset, (bv)->bv_len, \
> +	(dir), (attrs))
> +
>   static inline bool queue_is_mq(struct request_queue *q)
>   {
>   	return q->mq_ops;
> 

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
