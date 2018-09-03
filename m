From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Sep 2018 03:35:11 -0700
Subject: [PATCH] nvmet-rdma: fix possible bogus dereference under heavy
 load
In-Reply-To: <20180901074414.GA32538@lst.de>
References: <20180901011447.32287-1-sagi@grimberg.me>
 <20180901074414.GA32538@lst.de>
Message-ID: <d1917cb4-5d8d-c4e7-5be0-c51032ad6bbd@grimberg.me>


> This is a little scary and means we have the same issue in all other
> protocol drivers.  It also means that there probably is no point in
> allocating twice the queue length as it will be wasted most of the
> time, but still not enough.

Not exactly, the 2x I guess was designed to sustain the overhead of
the send completion until more commands are sent back by the host.
I guess it just doesn't seem to be enough. But without the factor
overhead I guess we'd find ourselves dynamically allocating more
than we'd want to. Its cheap enough to keep in my mind.

>>   	spin_lock_irqsave(&queue->rsps_lock, flags);
>> -	rsp = list_first_entry(&queue->free_rsps,
>> +	rsp = list_first_entry_or_null(&queue->free_rsps,
>>   				struct nvmet_rdma_rsp, free_list);
>> -	list_del(&rsp->free_list);
>>   	spin_unlock_irqrestore(&queue->rsps_lock, flags);
>> +	if (rsp) {
>> +		list_del(&rsp->free_list);
> 
> The list del needs to be under the lock.

Oops... to fast on the trigger...

>> +		rsp->allocated = false;
>> +	} else {
>> +		rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
>> +		rsp->allocated = true;
> 
> This needs to handle a NULL return from kmalloc.

Right, thanks!
