From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 30 May 2014 11:00:50 -0400
Subject: [PATCH v4] NVMe: basic conversion to blk-mq
In-Reply-To: <1401400285-25003-2-git-send-email-m@bjorling.me>
References: <1401400285-25003-1-git-send-email-m@bjorling.me>
 <1401400285-25003-2-git-send-email-m@bjorling.me>
Message-ID: <20140530150050.GD5499@linux.intel.com>

On Thu, May 29, 2014@11:51:25PM +0200, Matias Bj?rling wrote:
> -static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
> -		struct bio *bio, enum dma_data_direction dma_dir, int psegs)
> +static int nvme_map_rq(struct nvme_queue *nvmeq, struct nvme_iod *iod,
> +		struct request *req, enum dma_data_direction dma_dir,
> +		int psegs)
>  {
> -	struct bio_vec bvec, bvprv;
> -	struct bvec_iter iter;
> -	struct scatterlist *sg = NULL;
> -	int length = 0, nsegs = 0, split_len = bio->bi_iter.bi_size;
> -	int first = 1;
> -
> -	if (nvmeq->dev->stripe_size)
> -		split_len = nvmeq->dev->stripe_size -
> -			((bio->bi_iter.bi_sector << 9) &
> -			 (nvmeq->dev->stripe_size - 1));

You take out stripe_size here, but don't appear to put it back in
anywhere else.
