From: hare@suse.de (Hannes Reinecke)
Date: Thu, 27 Oct 2016 09:27:16 +0200
Subject: [PATCH 07/12] dm: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
In-Reply-To: <a0733adf-065e-2099-3850-cb1c55df1e35@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <a0733adf-065e-2099-3850-cb1c55df1e35@sandisk.com>
Message-ID: <61253bf4-1478-3cfb-7954-1d29997fedd9@suse.de>

On 10/27/2016 12:54 AM, Bart Van Assche wrote:
> Instead of manipulating both QUEUE_FLAG_STOPPED and BLK_MQ_S_STOPPED
> in the dm start and stop queue functions, only manipulate the latter
> flag. Change blk_queue_stopped() tests into blk_mq_queue_stopped().
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Cc: Mike Snitzer <snitzer at redhat.com>
> ---
>  drivers/md/dm-rq.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index fbd37b4..d47a504 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -75,12 +75,6 @@ static void dm_old_start_queue(struct request_queue *q)
>  
>  static void dm_mq_start_queue(struct request_queue *q)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(q->queue_lock, flags);
> -	queue_flag_clear(QUEUE_FLAG_STOPPED, q);
> -	spin_unlock_irqrestore(q->queue_lock, flags);
> -
>  	blk_mq_start_stopped_hw_queues(q, true);
>  	blk_mq_kick_requeue_list(q);
>  }
> @@ -105,16 +99,8 @@ static void dm_old_stop_queue(struct request_queue *q)
>  
>  static void dm_mq_stop_queue(struct request_queue *q)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(q->queue_lock, flags);
> -	if (blk_queue_stopped(q)) {
> -		spin_unlock_irqrestore(q->queue_lock, flags);
> +	if (blk_mq_queue_stopped(q))
>  		return;
> -	}
> -
> -	queue_flag_set(QUEUE_FLAG_STOPPED, q);
> -	spin_unlock_irqrestore(q->queue_lock, flags);
>  
>  	/* Avoid that requeuing could restart the queue. */
>  	blk_mq_cancel_requeue_work(q);
> @@ -341,7 +327,7 @@ static void __dm_mq_kick_requeue_list(struct request_queue *q, unsigned long mse
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(q->queue_lock, flags);
> -	if (!blk_queue_stopped(q))
> +	if (!blk_mq_queue_stopped(q))
>  		blk_mq_delay_kick_requeue_list(q, msecs);
>  	spin_unlock_irqrestore(q->queue_lock, flags);
>  }
> 
Ah. Right. That answers my previous question.

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
