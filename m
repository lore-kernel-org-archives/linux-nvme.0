From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 15:28:04 +0200
Subject: [PATCH v3 06/11] dm: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
In-Reply-To: <e5facfd0-82d5-10cb-712b-13d7950b78b8@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <e5facfd0-82d5-10cb-712b-13d7950b78b8@sandisk.com>
Message-ID: <20161019132804.GF6323@lst.de>

This looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>

On Tue, Oct 18, 2016@02:51:33PM -0700, Bart Van Assche wrote:
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

FYI, I'm tempted to say we should always call blk_mq_kick_requeue_list
from blk_mq_start_stopped_hw_queues, but that's a separate issue.
