From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 09:33:53 -0600
Subject: [PATCH 2/3] nvme: split the nvme queue lock into submission and
 completion locks
In-Reply-To: <20180517153311.GD19042@infradead.org>
References: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
 <1526569337-3489-3-git-send-email-axboe@kernel.dk>
 <20180517153311.GD19042@infradead.org>
Message-ID: <580c2865-3ad4-117b-ebb4-81c684988d34@kernel.dk>

On 5/17/18 9:33 AM, Christoph Hellwig wrote:
>> -	spin_lock_irq(&nvmeq->q_lock);
>> +	spin_lock_irq(&nvmeq->sq_lock);
>>  	__nvme_submit_cmd(nvmeq, &cmnd);
>> -	spin_unlock_irq(&nvmeq->q_lock);
>> +	spin_unlock_irq(&nvmeq->sq_lock);
> 
> I don't think we need to disable irqs here anymore.

See patch #3 :-)

I didn't want to do that in the same order.

-- 
Jens Axboe
