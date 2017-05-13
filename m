From: jsmart2021@gmail.com (James Smart)
Date: Sat, 13 May 2017 07:24:30 -0700
Subject: [PATCH] nvme_fc: replace ioabort msleep loop with completion
In-Reply-To: <20170510172221.GA28599@infradead.org>
References: <20170425223212.3876-1-jsmart2021@gmail.com>
 <20170510172221.GA28599@infradead.org>
Message-ID: <b1917814-c09e-274f-35ca-0d3bca8de48b@gmail.com>

On 5/10/2017 10:22 AM, Christoph Hellwig wrote:

>> -	while (ctrl->iocnt) {
>> +	if (ctrl->iocnt) {
>> +		init_completion(&ctrl->ioaborts_done);
>>  		spin_unlock_irqrestore(&ctrl->lock, flags);
>> -		msleep(1000);
>> +
>> +		wait_for_completion(&ctrl->ioaborts_done);
>> +
>>  		spin_lock_irqsave(&ctrl->lock, flags);
>> +		WARN_ON(ctrl->iocnt);
>
> But more importantly the single wait is potentially wrong.  Please
> switch to a waitqueue and use wait_event_lock_irq here.
>

Why do you think a single wait is wrong ?

All aborts have been scheduled, which is what ctrl->iocnt tracks, and 
will not increase. Thus ctrl->iocnt is set to its max prior to init'ing 
the completion and releasing the lock. The completion only triggers on 
decrement of ctrl->iocnt to zero checked under lock.

-- james
