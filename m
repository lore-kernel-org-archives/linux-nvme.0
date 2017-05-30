From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Tue, 30 May 2017 15:12:41 +0000
Subject: [PATCH v2 3/8] blk-mq: use the introduced blk_mq_unquiesce_queue()
In-Reply-To: <20170527142126.26079-4-ming.lei@redhat.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
 <20170527142126.26079-4-ming.lei@redhat.com>
Message-ID: <1496157160.2627.7.camel@sandisk.com>

On Sat, 2017-05-27@22:21 +0800, Ming Lei wrote:
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -3030,7 +3030,10 @@ scsi_internal_device_unblock(struct scsi_device *sdev,
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

Hello Ming,

Sorry but that change looks wrong to me. All what's needed here is a call
to blk_mq_unquiesce_queue().

Bart.
