From: jmoyer@redhat.com (Jeff Moyer)
Date: Tue, 24 Nov 2015 10:21:42 -0500
Subject: [PATCH 16/16] block: remove REQ_NO_TIMEOUT flag
In-Reply-To: <1448090914-13121-17-git-send-email-hch@lst.de> (Christoph
 Hellwig's message of "Sat, 21 Nov 2015 08:28:34 +0100")
References: <1448090914-13121-1-git-send-email-hch@lst.de>
 <1448090914-13121-17-git-send-email-hch@lst.de>
Message-ID: <x49egff2zjt.fsf@segfault.boston.devel.redhat.com>

Christoph Hellwig <hch at lst.de> writes:

> This was added for the 'magic' AEN requests in the NVMe driver that never
> return.  We now handle them purely inside the driver and don't need this
> core hack any more.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Jeff Moyer <jmoyer at redhat.com>


> ---
>  block/blk-mq.c            | 2 --
>  block/blk-timeout.c       | 3 ---
>  include/linux/blk_types.h | 2 --
>  3 files changed, 7 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6da03f1..5142219 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -608,8 +608,6 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
>  			blk_mq_complete_request(rq, -EIO);
>  		return;
>  	}
> -	if (rq->cmd_flags & REQ_NO_TIMEOUT)
> -		return;
>  
>  	if (time_after_eq(jiffies, rq->deadline)) {
>  		if (!test_and_set_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
> index cc10db2..6f97fcf 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -196,9 +196,6 @@ void blk_add_timer(struct request *req)
>  	struct request_queue *q = req->q;
>  	unsigned long expiry;
>  
> -	if (req->cmd_flags & REQ_NO_TIMEOUT)
> -		return;
> -
>  	/* blk-mq has its own handler, so we don't need ->rq_timed_out_fn */
>  	if (!q->mq_ops && !q->rq_timed_out_fn)
>  		return;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 0fb6584..86a38ea 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -188,7 +188,6 @@ enum rq_flag_bits {
>  	__REQ_PM,		/* runtime pm request */
>  	__REQ_HASHED,		/* on IO scheduler merge hash */
>  	__REQ_MQ_INFLIGHT,	/* track inflight for MQ */
> -	__REQ_NO_TIMEOUT,	/* requests may never expire */
>  	__REQ_NR_BITS,		/* stops here */
>  };
>  
> @@ -242,7 +241,6 @@ enum rq_flag_bits {
>  #define REQ_PM			(1ULL << __REQ_PM)
>  #define REQ_HASHED		(1ULL << __REQ_HASHED)
>  #define REQ_MQ_INFLIGHT		(1ULL << __REQ_MQ_INFLIGHT)
> -#define REQ_NO_TIMEOUT		(1ULL << __REQ_NO_TIMEOUT)
>  
>  typedef unsigned int blk_qc_t;
>  #define BLK_QC_T_NONE	-1U
