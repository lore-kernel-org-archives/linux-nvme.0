From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 9 Nov 2017 18:09:48 +0200
Subject: [PATCH 3/5] nvme: track shared namespaces
In-Reply-To: <20171109132046.GA22728@lst.de>
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-4-hch@lst.de>
 <ddc19090-b69b-ffa1-fd85-497b410b2b94@grimberg.me>
 <20171109125214.GA21795@lst.de>
 <1a4292d3-b9c6-976c-69aa-a42f84469cb2@grimberg.me>
 <20171109132046.GA22728@lst.de>
Message-ID: <1e0afeee-81d4-ca8e-4caa-2321640873e2@grimberg.me>


>>>>> To allow lockless path lookup the list of nvme_ns structures per
>>>>> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
>>>>> structure through call_srcu.
>>>>
>>>> Can you remind me why isn't rcu sufficient? Can looking up a
>>>> path (ns from head->list) block?
>>>
>>> blk_mq_make_request can block.
>>
>> Oh I see, so can you explain why srcu should cover direct_make_request?
>>
>> What if we were to do:
>> --
>> 	rcu_read_lock();
>> 	ns = nvme_find_path(head);
>> 	rcu_read_unlock();
>> 	if (likely(ns)) {
>> 		...
>> --
> 
> That way we'd have to take and release a namespace reference for every I/O.

Yea,

I'm good,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
