From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Apr 2014 13:37:17 -0600 (MDT)
Subject: [PATCH] NVMe: Add tracepoints
In-Reply-To: <1398709852-19104-1-git-send-email-keith.busch@intel.com>
References: <1398709852-19104-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LRH.2.03.1404281327560.5666@AMR>

Almost immediately after I sent this I saw a better way to get the
request_queue from the bio without going to the namespace.

@@ -415,7 +415,6 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
  {
  	struct nvme_iod *iod = ctx;
  	struct bio *bio = iod->private;
-	struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
  	u16 status = le16_to_cpup(&cqe->status) >> 1;
  	int error = 0;

@@ -439,7 +438,7 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
  	}
  	nvme_free_iod(nvmeq->dev, iod);

-	trace_block_bio_complete(ns->queue , bio, error);
+	trace_block_bio_complete(bdev_get_queue(bio->bi_bdev), bio, error);
  	bio_endio(bio, error);
  }

@@ -526,11 +525,11 @@ static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
  				 int len)
  {
  	struct bio *split = bio_split(bio, len >> 9, GFP_ATOMIC, NULL);
-	struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
  	if (!split)
  		return -ENOMEM;

-	trace_block_split(ns->queue, bio, split->bi_iter.bi_sector);
+	trace_block_split(bdev_get_queue(bio->bi_bdev), bio,
+					split->bi_iter.bi_sector);
  	bio_chain(split, bio);

  	if (!waitqueue_active(&nvmeq->sq_full))

> @@ -413,7 +415,9 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
> {
> 	struct nvme_iod *iod = ctx;
> 	struct bio *bio = iod->private;
> +	struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
> 	u16 status = le16_to_cpup(&cqe->status) >> 1;
> +	int error = 0;
>
> 	if (unlikely(status)) {
> 		if (!(status & NVME_SC_DNR ||
> @@ -426,6 +430,7 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
> 			wake_up(&nvmeq->sq_full);
> 			return;
> 		}
> +		error = -EIO;
> 	}
> 	if (iod->nents) {
> 		dma_unmap_sg(nvmeq->q_dmadev, iod->sg, iod->nents,
> @@ -433,10 +438,9 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
> 		nvme_end_io_acct(bio, iod->start_time);
> 	}
> 	nvme_free_iod(nvmeq->dev, iod);
> -	if (status)
> -		bio_endio(bio, -EIO);
> -	else
> -		bio_endio(bio, 0);
> +
> +	trace_block_bio_complete(ns->queue , bio, error);
> +	bio_endio(bio, error);
> }
>
> /* length is in bytes.  gfp flags indicates whether we may sleep. */
> @@ -522,9 +526,11 @@ static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
> 				 int len)
> {
> 	struct bio *split = bio_split(bio, len >> 9, GFP_ATOMIC, NULL);
> +	struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
> 	if (!split)
> 		return -ENOMEM;
>
> +	trace_block_split(ns->queue, bio, split->bi_iter.bi_sector);
> 	bio_chain(split, bio);
>
> 	if (!waitqueue_active(&nvmeq->sq_full))
