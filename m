From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 14 Nov 2018 08:31:14 -0700
Subject: [PATCH 1/6] nvme: don't disable local ints for polled queue
In-Reply-To: <20181114084322.GA14954@infradead.org>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-2-axboe@kernel.dk>
 <20181114084322.GA14954@infradead.org>
Message-ID: <fdc36207-ee35-e262-c0b9-1592be817ac3@kernel.dk>

On 11/14/18 1:43 AM, Christoph Hellwig wrote:
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 6aa86dfcb32c..a6e3fbddfadf 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1061,15 +1061,26 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
>>  
>>  static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
>>  {
>> +	unsigned long flags = 0; /* gcc 7.x fail */
>>  	u16 start, end;
>> -	bool found;
>> +	bool found, has_irq;
>>  
>>  	if (!nvme_cqe_pending(nvmeq))
>>  		return 0;
>>  
>> -	spin_lock_irq(&nvmeq->cq_lock);
>> +	/*
>> +	 * Polled queue doesn't have an IRQ, no need to disable ints
>> +	 */
>> +	has_irq = !nvmeq->polled;
>> +	if (has_irq)
>> +		local_irq_save(flags);
>> +
>> +	spin_lock(&nvmeq->cq_lock);
>>  	found = nvme_process_cq(nvmeq, &start, &end, tag);
>> -	spin_unlock_irq(&nvmeq->cq_lock);
>> +	spin_unlock(&nvmeq->cq_lock);
>> +
>> +	if (has_irq)
>> +		local_irq_restore(flags);
> 
> Eww, this just looks ugly.  Given that we are micro-optimizing here
> I'd rather just use a different ->poll implementation and thus blk_mq_ops
> if we have a separate poll code.  Then we could leave the existing
> __nvme_poll as-is and have a new nvme_poll_noirq something like this:

Yeah good point, gets rid of those branches too. I'll make that change.

> And while we are at it:  I think for the irq-driven queuest in a
> separate queue for poll setup we might not even need to take the
> CQ lock.  Which might be an argument for only allowing polling
> if we have the separate queues just to keep everything simple.

We can definitely move in that direction, I'll take a look at what
is feasible.

-- 
Jens Axboe
