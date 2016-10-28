From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Fri, 28 Oct 2016 11:51:35 -0700
Subject: [PATCH 11/12] nvme: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
In-Reply-To: <20161028160145.GC5621@localhost.localdomain>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <805e1911-cd10-0563-c76b-256d76054b08@sandisk.com>
 <20161028160145.GC5621@localhost.localdomain>
Message-ID: <655c62ca-5da8-3c8f-9e56-016b7d518267@sandisk.com>

On 10/28/2016 08:51 AM, Keith Busch wrote:
> On Wed, Oct 26, 2016@03:56:04PM -0700, Bart Van Assche wrote:
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 7bb73ba..b662416 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -205,7 +205,7 @@ void nvme_requeue_req(struct request *req)
>>
>>  	blk_mq_requeue_request(req, false);
>>  	spin_lock_irqsave(req->q->queue_lock, flags);
>> -	if (!blk_queue_stopped(req->q))
>> +	if (!blk_mq_queue_stopped(req->q))
>>  		blk_mq_kick_requeue_list(req->q);
>>  	spin_unlock_irqrestore(req->q->queue_lock, flags);
>>  }
>> @@ -2079,10 +2079,6 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
>>
>>  	mutex_lock(&ctrl->namespaces_mutex);
>>  	list_for_each_entry(ns, &ctrl->namespaces, list) {
>> -		spin_lock_irq(ns->queue->queue_lock);
>> -		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
>> -		spin_unlock_irq(ns->queue->queue_lock);
>> -
>>  		blk_mq_cancel_requeue_work(ns->queue);
>>  		blk_mq_stop_hw_queues(ns->queue);
>
> There's actually a reason the queue stoppage is using a different flag
> than blk_mq_queue_stopped: kicking the queue starts stopped queues.
> The driver has to ensure the requeue work can't be kicked prior to
> cancelling the current requeue work. Once we know requeue work isn't
> running and can't restart again, then we're safe to stop the hw queues.
>
> It's a pretty obscure condition, requiring the controller post an
> error completion at the same time the driver decides to reset the
> controller. Here's the sequence with the wrong outcome:
>
>  CPU A                   CPU B
>  -----                   -----
> nvme_stop_queues         nvme_requeue_req
>  blk_mq_stop_hw_queues    if (blk_mq_queue_stopped) <- returns false
>   blk_mq_stop_hw_queue     blk_mq_kick_requeue_list
>                          blk_mq_requeue_work
>                           blk_mq_start_hw_queues

Hello Keith,

I think it is wrong that kicking the requeue list starts stopped queues 
because this makes it impossible to stop request processing without 
setting an additional flag next to BLK_MQ_S_STOPPED. Can you have a look 
at the attached two patches? These patches survive my dm-multipath and 
SCSI tests.

Thanks,

Bart.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-block-Avoid-that-requeueing-starts-stopped-queues.patch
Type: text/x-patch
Size: 3538 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20161028/0cf6533d/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-blk-mq-Remove-blk_mq_cancel_requeue_work.patch
Type: text/x-patch
Size: 2638 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20161028/0cf6533d/attachment-0003.bin>
