From: jmoyer@redhat.com (Jeff Moyer)
Date: Mon, 23 Nov 2015 16:23:29 -0500
Subject: [PATCH 05/47] block: remoe REQ_ATOM_COMPLETE wrappers
In-Reply-To: <1448037342-18384-6-git-send-email-hch@lst.de> (Christoph
 Hellwig's message of "Fri, 20 Nov 2015 17:35:00 +0100")
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-6-git-send-email-hch@lst.de>
Message-ID: <x49io4smmum.fsf@segfault.boston.devel.redhat.com>

Christoph Hellwig <hch at lst.de> writes:

> We only use them inconsistenly, and the other flags don't use wrappers like
> this either.

Fine by me.

Reviewed-by: Jeff Moyer <jmoyer at redhat.com>

>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  block/blk-core.c    |  2 +-
>  block/blk-mq.c      |  6 +++---
>  block/blk-softirq.c |  2 +-
>  block/blk-timeout.c |  6 +++---
>  block/blk.h         | 18 ++++--------------
>  5 files changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 1de0974..af9c315 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1375,7 +1375,7 @@ EXPORT_SYMBOL(blk_rq_set_block_pc);
>  void blk_requeue_request(struct request_queue *q, struct request *rq)
>  {
>  	blk_delete_timer(rq);
> -	blk_clear_rq_complete(rq);
> +	clear_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
>  	trace_block_rq_requeue(q, rq);
>  
>  	if (rq->cmd_flags & REQ_QUEUED)
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 76773dc..c932605 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -383,7 +383,7 @@ void blk_mq_complete_request(struct request *rq, int error)
>  
>  	if (unlikely(blk_should_fake_timeout(q)))
>  		return;
> -	if (!blk_mark_rq_complete(rq) ||
> +	if (!test_and_set_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags) ||
>  	    test_and_clear_bit(REQ_ATOM_QUIESCED, &rq->atomic_flags)) {
>  		rq->errors = error;
>  		__blk_mq_complete_request(rq);
> @@ -583,7 +583,7 @@ void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  		break;
>  	case BLK_EH_RESET_TIMER:
>  		blk_add_timer(req);
> -		blk_clear_rq_complete(req);
> +		clear_bit(REQ_ATOM_COMPLETE, &req->atomic_flags);
>  		break;
>  	case BLK_EH_NOT_HANDLED:
>  		break;
> @@ -614,7 +614,7 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
>  		return;
>  
>  	if (time_after_eq(jiffies, rq->deadline)) {
> -		if (!blk_mark_rq_complete(rq))
> +		if (!test_and_set_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
>  			blk_mq_rq_timed_out(rq, reserved);
>  	} else if (!data->next_set || time_after(data->next, rq->deadline)) {
>  		data->next = rq->deadline;
> diff --git a/block/blk-softirq.c b/block/blk-softirq.c
> index 9d47fbc..b89f655 100644
> --- a/block/blk-softirq.c
> +++ b/block/blk-softirq.c
> @@ -167,7 +167,7 @@ void blk_complete_request(struct request *req)
>  {
>  	if (unlikely(blk_should_fake_timeout(req->q)))
>  		return;
> -	if (!blk_mark_rq_complete(req) ||
> +	if (!test_and_set_bit(REQ_ATOM_COMPLETE, &req->atomic_flags) ||
>  	    test_and_clear_bit(REQ_ATOM_QUIESCED, &req->atomic_flags))
>  		__blk_complete_request(req);
>  }
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
> index b3a7f20..cc10db2 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -94,7 +94,7 @@ static void blk_rq_timed_out(struct request *req)
>  		break;
>  	case BLK_EH_RESET_TIMER:
>  		blk_add_timer(req);
> -		blk_clear_rq_complete(req);
> +		clear_bit(REQ_ATOM_COMPLETE, &req->atomic_flags);
>  		break;
>  	case BLK_EH_QUIESCED:
>  		set_bit(REQ_ATOM_QUIESCED, &req->atomic_flags);
> @@ -122,7 +122,7 @@ static void blk_rq_check_expired(struct request *rq, unsigned long *next_timeout
>  		/*
>  		 * Check if we raced with end io completion
>  		 */
> -		if (!blk_mark_rq_complete(rq))
> +		if (!test_and_set_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
>  			blk_rq_timed_out(rq);
>  	} else if (!*next_set || time_after(*next_timeout, rq->deadline)) {
>  		*next_timeout = rq->deadline;
> @@ -160,7 +160,7 @@ void blk_timeout_work(struct work_struct *work)
>   */
>  void blk_abort_request(struct request *req)
>  {
> -	if (blk_mark_rq_complete(req))
> +	if (test_and_set_bit(REQ_ATOM_COMPLETE, &req->atomic_flags))
>  		return;
>  
>  	if (req->q->mq_ops) {
> diff --git a/block/blk.h b/block/blk.h
> index f4c98f8..1d95107 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -118,26 +118,16 @@ void blk_account_io_done(struct request *req);
>   * Internal atomic flags for request handling
>   */
>  enum rq_atomic_flags {
> +	/*
> +	 * EH timer and IO completion will both attempt to 'grab' the request,
> +	 * make sure that only one of them succeeds by setting this flag.
> +	 */
>  	REQ_ATOM_COMPLETE = 0,
>  	REQ_ATOM_STARTED,
>  	REQ_ATOM_QUIESCED,
>  };
>  
>  /*
> - * EH timer and IO completion will both attempt to 'grab' the request, make
> - * sure that only one of them succeeds
> - */
> -static inline int blk_mark_rq_complete(struct request *rq)
> -{
> -	return test_and_set_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
> -}
> -
> -static inline void blk_clear_rq_complete(struct request *rq)
> -{
> -	clear_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
> -}
> -
> -/*
>   * Internal elevator interface
>   */
>  #define ELV_ON_HASH(rq) ((rq)->cmd_flags & REQ_HASHED)
