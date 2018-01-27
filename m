From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Sat, 27 Jan 2018 20:33:35 +0800
Subject: [PATCH] nvme: don't retry request marked as NVME_REQ_CANCELLED
In-Reply-To: <20180125101503.GA13375@ming.t460p>
References: <20180125081023.13303-1-ming.lei@redhat.com>
 <db07601a-e298-3194-9b02-e7077d57e0a3@oracle.com>
 <20180125101503.GA13375@ming.t460p>
Message-ID: <6749d736-ffdd-7f8d-c50c-58453b054ef8@oracle.com>

Hi ming

Thanks for your kindly response.
And really sorry for delayed feedback here.

On 01/25/2018 06:15 PM, Ming Lei wrote:
> Hi Jianchao,
> 
> On Thu, Jan 25, 2018@04:52:31PM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> Thanks for your patch and detailed comment.
>>
>> On 01/25/2018 04:10 PM, Ming Lei wrote:
>>> If request is marked as NVME_REQ_CANCELLED, we don't need to retry for
>>> requeuing it, and it should be completed immediately. Even simply from
>>> the flag name, it needn't to be requeued.
>>>
>>> Otherwise, it is easy to cause IO hang when IO is timed out in case of
>>> PCI NVMe:
>>>
>>> 1) IO timeout is triggered, and nvme_timeout() tries to disable
>>> device(nvme_dev_disable) and reset controller(nvme_reset_ctrl)
>>>
>>> 2) inside nvme_dev_disable(), queue is frozen and quiesced, and
>>> try to cancel every request, but the timeout request can't be canceled
>>> since it is completed by __blk_mq_complete_request() in blk_mq_rq_timed_out().
>>>
>>> 3) this timeout req is requeued via nvme_complete_rq(), but can't be
>>> dispatched at all because queue is quiesced and hardware isn't ready,
>>> finally nvme_wait_freeze() waits for ever in nvme_reset_work().
>>
>> The queue will be unquiesced by nvme_start_queues() before start to wait freeze.
> 
> Hammmm, just miss this point, so no such io hang in this case.
> 
>>
>> nvme_reset_work
>> ....
>> 		nvme_start_queues(&dev->ctrl);
>> 		nvme_wait_freeze(&dev->ctrl);
>> 		/* hit this only when allocate tagset fails */
>> 		if (nvme_dev_add(dev))
>> 			new_state = NVME_CTRL_ADMIN_ONLY;
>> 		nvme_unfreeze(&dev->ctrl);
>> ....
>> And the relationship between nvme_timeout and nvme_dev_disable is really complicated.
>> The nvme_timeout may run with nvme_dev_disable in parallel and also could invoke it.
>> nvme_dev_disbale may sleep holding shutdown_lock, nvme_timeout will try to get it when invokes nvme_dev_disable....
>>
> 
> Yes, the implementation is really complicated, but nvme_dev_disable() is
> run exclusively because of dev->shutdown_lock. Also nvme_timeout() only
> handles the timeout request which is invisible to nvme_dev_disable()
> 
> So in concept, looks it is fine, :-)

In fact, I have incurred a scenario which is similar with description as above.
nvme_dev_disable issue sq/cq delete command on amdinq, but nvme device didn't response due to some unknown reason.
At the moment, the previous IO requests expired, and nvne_timeout is invoked when ctrl->state is RESETTING, then
nvme_dev_disable was invoked. So got a scenario:

context A                                   context B
nvme_dev_disable                            nvme_timeout
  hold shutdown_lock                          nvme_dev_disable
    wait sq/cq delete command response          require shutdown_lock 

Finally, the context A broke out due to timeout, things went ok.
But this is a very dangerous.
    
There are other cases where context may sleep with shutdown_lock held in nvme_dev_disable

>> On the other hand, can we provide a helper interface to quiesce the request_work timeout_work ?
> 
> Could you explain a bit why it is required?
For nvme_dev_disable, it need to cancel all the previously outstanding requests.
And it cannot wait them to be completed, because the device may goes wrong at the moment.
But nvme_dev_disable may run with nvme_timeout in parallel or race with it.
The best way to fix this is to ensure the timeout path has been completed before cancel the
previously outstanding requests. (Just ignore the case where the nvme_timeout will invoke nvme_dev_disable,
it has to be fixed by other way.)

Following path to is do this. Quiesce the request_queue->timeout_work totally, then we don't need to race with
nvme_timeout path any more in above scenario.

> 
> 
>> Such as following:
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index b888175..60469cd 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -616,6 +616,44 @@ void blk_queue_bypass_end(struct request_queue *q)
>>  }
>>  EXPORT_SYMBOL_GPL(blk_queue_bypass_end);
>>  
>> +/*
>> + * When returns, the timeout_work will be invoked any more.
>> + * The caller must take the charge of the outstanding IOs.
>> + */
>> +void blk_quiesce_queue_timeout(struct request_queue *q)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(q->queue_lock, flags);
>> +	queue_flag_set(QUEUE_FLAG_TIMEOUT_QUIESCED, q);
>> +	spin_unlock_irqrestore(q->queue_lock, flags);
>> +
>> +	synchronize_rcu_bh();
>> +	cancel_work_sync(&q->timeout_work);
>> +	/*
>> +	 * The timeout work will not be invoked anymore.
>> +	 */
>> +	del_timer_sync(&q->timeout);
>> +	/*
>> +	 * If the caller doesn't want the timer to be re-armed,
>> +	 * it has to stop/quiesce the queue.
>> +	 */
>> +}
>> +EXPORT_SYMBOL_GPL(blk_quiesce_queue_timeout);
>> +
>> +/*
>> + * Caller must ensure all the outstanding IOs has been handled.
>> + */
>> +void blk_unquiesce_queue_timeout(struct request_queue *q)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(q->queue_lock, flags);
>> +	queue_flag_clear(QUEUE_FLAG_TIMEOUT_QUIESCED, q);
>> +	spin_unlock_irqrestore(q->queue_lock, flags);
>> +}
>> +
>> +EXPORT_SYMBOL_GPL(blk_unquiesce_queue_timeout);
>>  void blk_set_queue_dying(struct request_queue *q)
>>  {
>>  	spin_lock_irq(q->queue_lock);
>> @@ -867,6 +905,9 @@ static void blk_rq_timed_out_timer(struct timer_list *t)
>>  {
>>  	struct request_queue *q = from_timer(q, t, timeout);
>>  
>> +	if (blk_queue_timeout_quiesced(q))
>> +		return;
>> +
>>  	kblockd_schedule_work(&q->timeout_work);
>>  }
>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=ZXWFEWytJgigh5HwlzkcMrlwBTLl73tTNVA1fhL2FDk&s=zXoLlfl9uF107FMTkPVyoKQd2QF1i0h9BdcAGlIw4LM&e=
> 
