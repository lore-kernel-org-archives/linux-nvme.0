From: hare@suse.de (Hannes Reinecke)
Date: Thu, 27 Oct 2016 07:52:41 +0200
Subject: [PATCH 05/12] blk-mq: Introduce blk_mq_quiesce_queue()
In-Reply-To: <5143c240-39af-9fe2-d3e6-ed69f9c20531@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <5143c240-39af-9fe2-d3e6-ed69f9c20531@sandisk.com>
Message-ID: <f1661bd2-12ca-20d1-ece2-5c7fe5987035@suse.de>

On 10/27/2016 12:53 AM, Bart Van Assche wrote:
> blk_mq_quiesce_queue() waits until ongoing .queue_rq() invocations
> have finished. This function does *not* wait until all outstanding
> requests have finished (this means invocation of request.end_io()).
> The algorithm used by blk_mq_quiesce_queue() is as follows:
> * Hold either an RCU read lock or an SRCU read lock around
>   .queue_rq() calls. The former is used if .queue_rq() does not
>   block and the latter if .queue_rq() may block.
> * blk_mq_quiesce_queue() calls synchronize_srcu() or
>   synchronize_rcu() to wait for .queue_rq() invocations that
>   started before blk_mq_quiesce_queue() was called.
> * The blk_mq_hctx_stopped() calls that control whether or not
>   .queue_rq() will be called are called with the (S)RCU read lock
>   held. This is necessary to avoid race conditions against
>   the "blk_mq_stop_hw_queues(q); blk_mq_quiesce_queue(q);"
>   sequence from another thread.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Ming Lei <tom.leiming at gmail.com>
> Cc: Hannes Reinecke <hare at suse.com>
> Cc: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  block/Kconfig          |  1 +
>  block/blk-mq.c         | 69 +++++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/blk-mq.h |  3 +++
>  include/linux/blkdev.h |  1 +
>  4 files changed, 67 insertions(+), 7 deletions(-)
> 
Hmm. Can't say I like having to have two RCU structure for the same
purpose, but I guess that can't be helped.

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
