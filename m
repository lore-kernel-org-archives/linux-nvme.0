From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Wed, 31 May 2017 15:21:41 +0000
Subject: [PATCH v3 3/9] blk-mq: use the introduced blk_mq_unquiesce_queue()
In-Reply-To: <20170531123706.20885-4-ming.lei@redhat.com>
References: <20170531123706.20885-1-ming.lei@redhat.com>
 <20170531123706.20885-4-ming.lei@redhat.com>
Message-ID: <1496244100.2608.3.camel@sandisk.com>

On Wed, 2017-05-31@20:37 +0800, Ming Lei wrote:
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 99e16ac479e3..ffcf05765e2b 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -3031,7 +3031,10 @@ scsi_internal_device_unblock(struct scsi_device *sdev,
>  		return -EINVAL;
>  
>  	if (q->mq_ops) {
> -		blk_mq_start_stopped_hw_queues(q, false);
> +		if (blk_queue_quiesced(q))
> +			blk_mq_unquiesce_queue(q);
> +		else
> +			blk_mq_start_stopped_hw_queues(q, false);
>  	} else {
>  		spin_lock_irqsave(q->queue_lock, flags);
>  		blk_start_queue(q);

As I commented on v2, this change is really wrong. All what's needed here is
a call to blk_mq_unquiesce_queue() and nothing else. Adding a call to
blk_mq_start_stopped_hw_queues() is wrong because it makes it impossible to
use the STOPPED flag in the SCSI core to make the block layer core stop calling
.queue_rq() if a SCSI LLD returns "busy".

Bart.
