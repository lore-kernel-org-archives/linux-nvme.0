From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 3 Sep 2015 09:52:29 -0600
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <55E86A3F.9030100@dev.mellanox.co.il>
References: <20150819094003.GB14734@infradead.org>
 <55D45AE0.50805@dev.mellanox.co.il>
 <20150819104246.GA4956@infradead.org>
 <55E6ADA4.5040905@dev.mellanox.co.il>
 <20150902143756.GA11062@kernel.dk>
 <55E7324B.3060601@dev.mellanox.co.il>
 <20150902191714.GD14454@kernel.dk>
 <55E80DD4.9000505@dev.mellanox.co.il>
 <20150903150447.GA24222@kernel.dk>
 <55E86A3F.9030100@dev.mellanox.co.il>
Message-ID: <20150903155229.GB24222@kernel.dk>

On 09/03/2015 09:41 AM, Sagi Grimberg wrote:
> On 9/3/2015 6:04 PM, Jens Axboe wrote:
>> On Thu, Sep 03 2015, Sagi Grimberg wrote:
>>> On 9/2/2015 10:18 PM, Jens Axboe wrote:
>>>> On Wed, Sep 02 2015, Sagi Grimberg wrote:
>>>>>> Does the below work for you?
>>>>>
>>>>> It's not on top of Keith virt_boundary patch right?
>>>>> First glance looks ok though.
>>>>
>>>> Updated for that.
>>>>
>>>
>>> Thanks Jens,
>>>
>>> I'll test it.
>>
>> Cleaned up version, unified the gap checking and changed the names of
>> the function to make it easier to understand. And then we only need to
>> check bio_has_data() in bio_will_gap().
>
> :)
>
> I was just going to say that maybe we should keep the check
> explicit..

Hehe. I think it makes sense to check whether it carries data or not in 
the gap check, it's somewhat different than the integrity check.

> I am going to fix this also for integrity payload [1], and there
> I need to check for blk_integrity_rq(req) explicitly because
> it doesn't really makes sense to call an integrity gap checker
> if you don't have integrity...
>
> Also, lets move the gap helpers to be static inline in blkdev.h
> so I can put my integrity gap helpers there too.
>
> Anyway, its just cosmetics...
>
> Let me include your patch in a series I'm planning on
> sending soon enough as I don't see merges anymore so I guess
> the issue is gone now.

Updated patch below. Let me know when you have sufficient confidence in
it working, and I will add your reviewed/tested/whatever-by and we can
queue it up for this series.

> commit 48679ce5f6ffe6827d40287b521ea139cdf95ff7
> Author: Sagi Grimberg <sagig at mellanox.com>
> Date:   Wed Jul 15 15:06:04 2015 +0300
>
>      block: Refuse request/bio merges with gaps in the integrity payload
>
>      If a driver sets the block queue virtual boundary, it means that
>      it cannot handle gaps so we must not allow those in the integrity
>      payload as well.
>
>      Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
>
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index f548b64..eee1d74 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -204,6 +204,9 @@ bool blk_integrity_merge_rq(struct request_queue *q,
> struct request *req,
>              q->limits.max_integrity_segments)
>                  return false;
>
> +       if (integrity_req_gap_to_prev(req, next->bio))
> +               return false;
> +
>          return true;
>   }
>   EXPORT_SYMBOL(blk_integrity_merge_rq);
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index e6b426f..1a3f105 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -315,6 +315,10 @@ int ll_back_merge_fn(struct request_queue *q,
> struct request *req,
>          if (bio_has_data(bio) && req_gap_to_prev(req, bio))
>                  return 0;
>
> +       if (blk_integrity_rq(req) &&
> +           integrity_req_gap_to_prev(req, bio))
> +               return 0;
> +
>          if (blk_rq_sectors(req) + bio_sectors(bio) >
>              blk_rq_get_max_sectors(req)) {
>              blk_rq_get_max_sectors(req)) {
>                  req->cmd_flags |= REQ_NOMERGE;
> @@ -336,6 +340,10 @@ int ll_front_merge_fn(struct request_queue *q,
> struct request *req,
>          if (bio_has_data(bio) && req_gap_to_next(req, bio))
>                  return 0;
>
> +       if (blk_integrity_rq(req) &&
> +           integrity_req_gap_to_next(req, bio))
> +               return 0;
> +
>          if (blk_rq_sectors(req) + bio_sectors(bio) >
>              blk_rq_get_max_sectors(req)) {
>                  req->cmd_flags |= REQ_NOMERGE;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b1bb60a..ad5a21a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1389,6 +1389,26 @@ static inline bool req_gap_to_next(struct request
> *req, struct bio *bio)
>                                  next->bi_io_vec[0].bv_offset);
>   }
>
> +static inline bool integrity_req_gap_to_prev(struct request *req,
> +                                            struct bio *next)
> +{
> +       struct bio_integrity_payload *bip = bio_integrity(req->bio);
> +       struct bio_integrity_payload *bip_next = bio_integrity(next);
> +
> +       return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
> +                               bip_next->bip_vec[0].bv_offset);
> +}
> +
> +static inline bool integrity_req_gap_to_next(struct request *req,
> +                                            struct bio *bio)
> +{
> +       struct bio_integrity_payload *bip = bio_integrity(bio);
> +       struct bio_integrity_payload *bip_next = bio_integrity(req->bio);
> +
> +       return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
> +                               bip_next->bip_vec[0].bv_offset);
> +}
>   struct work_struct;
>   int kblockd_schedule_work(struct work_struct *work);
>   int kblockd_schedule_delayed_work(struct delayed_work *dwork, unsigned
> long delay);

Looks good to me.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index cce23ba1ae5f..d9eddbc189f5 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -438,6 +438,8 @@ no_merge:
 int ll_back_merge_fn(struct request_queue *q, struct request *req,
 		     struct bio *bio)
 {
+	if (req_gap_back_merge(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req)) {
 		req->cmd_flags |= REQ_NOMERGE;
@@ -456,6 +458,9 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
 int ll_front_merge_fn(struct request_queue *q, struct request *req,
 		      struct bio *bio)
 {
+
+	if (req_gap_front_merge(req, bio))
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req)) {
 		req->cmd_flags |= REQ_NOMERGE;
@@ -482,14 +487,6 @@ static bool req_no_special_merge(struct request *req)
 	return !q->mq_ops && req->special;
 }
 
-static int req_gap_to_prev(struct request *req, struct bio *next)
-{
-	struct bio *prev = req->biotail;
-
-	return bvec_gap_to_prev(req->q, &prev->bi_io_vec[prev->bi_vcnt - 1],
-			next->bi_io_vec[0].bv_offset);
-}
-
 static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 				struct request *next)
 {
@@ -504,7 +501,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	if (req_no_special_merge(req) || req_no_special_merge(next))
 		return 0;
 
-	if (req_gap_to_prev(req, next->bio))
+	if (req_gap_back_merge(req, next->bio))
 		return 0;
 
 	/*
@@ -712,10 +709,6 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	    !blk_write_same_mergeable(rq->bio, bio))
 		return false;
 
-	/* Only check gaps if the bio carries data */
-	if (bio_has_data(bio) && req_gap_to_prev(rq, bio))
-		return false;
-
 	return true;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a622f270f09e..0a362ed03c99 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1368,6 +1368,26 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
 }
 
+static inline bool bio_will_gap(struct request_queue *q, struct bio *prev,
+				struct bio *next)
+{
+	if (!bio_has_data(prev))
+		return false;
+
+	return bvec_gap_to_prev(q, &prev->bi_io_vec[prev->bi_vcnt - 1],
+				next->bi_io_vec[0].bv_offset);
+}
+
+static inline bool req_gap_back_merge(struct request *req, struct bio *next)
+{
+	return bio_will_gap(req->q, req->biotail, next);
+}
+
+static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
+{
+	return bio_will_gap(req->q, bio, req->bio);
+}
+
 struct work_struct;
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_schedule_delayed_work(struct delayed_work *dwork, unsigned long delay);

-- 
Jens Axboe
