From: keith.busch@intel.com (Keith Busch)
Date: Mon, 6 Jan 2014 09:12:26 -0700 (MST)
Subject: [PATCH] NVMe: use-after-free on surprise removal fixes
In-Reply-To: <20140102165853.GN4945@linux.intel.com>
References: <1388528118-4866-1-git-send-email-keith.busch@intel.com>
 <20140102165853.GN4945@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1401060841530.4958@AMR>

On Thu, 2 Jan 2014, Matthew Wilcox wrote:
> On Tue, Dec 31, 2013@03:15:18PM -0700, Keith Busch wrote:
>> @@ -1155,10 +1155,20 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
>>  {
>>  	int i;
>>
>> +	for (i = num_possible_cpus(); i > dev->queue_count - 1; i--)
>> +		rcu_assign_pointer(dev->queues[i], NULL);
>>  	for (i = dev->queue_count - 1; i >= lowest; i--) {
>> -		nvme_free_queue(dev->queues[i]);
>> +		struct nvme_queue *nvmeq = dev->queues[i];
>> +
>> +		spin_lock_irq(&nvmeq->q_lock);
>> +		nvme_cancel_ios(nvmeq, false);
>> +		spin_unlock_irq(&nvmeq->q_lock);
>> +
>> +		rcu_assign_pointer(dev->queues[i], NULL);
>> +		synchronize_rcu();
>> +
>> +		nvme_free_queue(nvmeq);
>>  		dev->queue_count--;
>> -		dev->queues[i] = NULL;
>>  	}
>>  }
>>
>
> I don't think you want to do this.  You're calling synchronize_rcu() for
> each queue individually, which is extremely heavy-weight.  This routine
> could take minutes to execute on a machine with a lot of RCU activity.
>
> Two ways to fix this; accumulate the queues into a function-local array,
> call synchronize_rcu() once, then free them all.  Alternatively, use
> call_rcu() to have nvme_free_queue() executed after a grace period
> has elapsed.
>
> If we go that route, then as described in
> Documentation/RCU/rcubarrier.txt, we will need to add a call to
> rcu_barrier() in the module exit path to be sure that all the call_rcu()
> functions have finished executing.  So there's probabaly no real
> difference between the execution time of the two options in the case of
> module unload, though it'd be visible in device hotplug.
>
> By the way, this is an extremely common mistake people make when
> introducing RCU.  If one can figure out a way to avoid calling
> synchronize_rcu(), then one probably should.

Good stuff, thank you for the suggestions!

> Also, why is
> 		rcu_assign_pointer(dev->queues[i], NULL);
> after cancelling the I/Os?  It seems to me that another thread could submit
> an I/O between the cancellations and setting the queue to NULL.  I think
> the pointer assignment needs to at least be within the spin_lock section,
> but it could also be done before taking the spinlock ... right?

It looks like cancelling IOs here is pointless so I shouldn't have added
it. The queues are quiesced prior to this function call, so another thread
couldn't submit new commands on one at this point: the queue's suspended
flag is set, all outstanding commands are already forced cancelled, and
new commands are placed on the bio_list instead of being submitted. I'll
remove it and fix up the other issues for v2.
