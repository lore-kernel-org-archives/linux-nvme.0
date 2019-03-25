From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 25 Mar 2019 05:10:20 +0000
Subject: [PATCH 02/15] block: add a rq_integrity_vec helper
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-3-hch@lst.de>
Message-ID: <SN6PR04MB4527A9C0E360C5991F9E00A6865E0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/21/19 4:11 PM, Christoph Hellwig wrote:
> This provides a nice little shortcut to get the integrity data for
> drivers like NVMe that only support a single integrity segment.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   include/linux/blkdev.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 255e20313cde..f9a072610d28 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1552,6 +1552,16 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
>   	return bio_integrity_intervals(bi, sectors) * bi->tuple_size;
>   }
>   
> +/*
> + * Return the first bvec that contains integrity data.  In general only
> + * drivers that are limited to a single integrity segment should use this
> + * helper.
> + */
> +static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +{
Wrt comment, should we add a check here to make sure underlaying driver
has limited single integrity segment ?
> +	return rq->bio->bi_integrity->bip_vec;
> +}
> +
>   #else /* CONFIG_BLK_DEV_INTEGRITY */
>   
>   struct bio;
> @@ -1626,6 +1636,11 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
>   	return 0;
>   }
>   
> +static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +{
> +	return NULL;
> +}
> +
>   #endif /* CONFIG_BLK_DEV_INTEGRITY */
>   
>   struct block_device_operations {
> 

Otherwise looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
