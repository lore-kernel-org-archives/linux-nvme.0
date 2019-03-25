From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 25 Mar 2019 05:07:44 +0000
Subject: [PATCH 01/15] block: add a req_bvec helper
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-2-hch@lst.de>
Message-ID: <SN6PR04MB4527D352D115DFAB042B18D2865E0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/21/19 4:11 PM, Christoph Hellwig wrote:
> Return the currently active bvec segment, potentially spanning multiple
> pages.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   include/linux/blkdev.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 0de92b29f589..255e20313cde 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -929,6 +929,13 @@ static inline unsigned int blk_rq_payload_bytes(struct request *rq)
>   	return blk_rq_bytes(rq);
>   }
>   
> +static inline struct bio_vec req_bvec(struct request *rq)
> +{
> +	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
> +		return rq->special_vec;
Quick question here mostly for my understanding, do we also have to 
check here for nr_phys_segments for the operations such as write-zeroes ? OR

this may never get called in write-zeroes context ? OR
not applicable ?

> +	return mp_bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter);
> +}
> +
>   static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
>   						     int op)
>   {
> 

Otherwise, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
