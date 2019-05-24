From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 24 May 2019 09:11:23 -0700
Subject: [PATCH] nvme-rdma: Fix a NULL deref when lesser io queues are
 allocated.
In-Reply-To: <0c738420-1c60-e656-d550-f209c40bf422@mellanox.com>
References: <2936d0e0de627fce13f78fca2ef93960aab0d929.1558534119.git.nirranjan@chelsio.com>
 <bf05c7f8-7a97-5e67-3476-b92c698a23a9@mellanox.com>
 <20190523075524.GA15479@chelsio.com>
 <06d347cc-7df6-c2b3-2edf-88a53db3c12d@mellanox.com>
 <20190523114157.GA9479@chelsio.com>
 <033ac067-29b1-30ff-6ad0-5e13510649bd@mellanox.com>
 <20190524044341.GA5129@chelsio.com>
 <955d9336-50d7-248c-eed8-3b038f6a5a11@grimberg.me>
 <0c738420-1c60-e656-d550-f209c40bf422@mellanox.com>
Message-ID: <0c1b317c-eaf7-a032-6003-caf32f953bdf@grimberg.me>


>> Hi,
>>
>> Just got to this one (after ramping up on activity post vacation..)
>>
>> Max, I think that your patch is missing the case where default+read+poll
>> queues are higher than controller queue limit but we can still fit
>> a queue separation.
> 
> My patch was just a draft to see if it fixes the NULL deref.

Yea, I know..

>> For example:
>> - requested 10/10/10 (default/read/poll)
>> - supported 28
>>
>> If I read your patch correctly, this will fall-back to shared read/write
>> queue maps with no poll queues (10/0/0), while we'd want in this case
>> to still have the separation but simply have less poll queues (10/10/8).
>>
> it will fallback to shared read/write with 28 queues. same as it was 
> without this feature

Oh.. this can leave unused queues (if say we have 10 cpu cores) right?

  (actually I think I need to zero
> "ctrl->io_queues[HCTX_TYPE_READ]" for that to get (28/0/0) instead of 
> (28/28/0).
> 
> so the default queues can be read/write queues and also write queues 
> only (in case we have read_queues != 0) ?
> 
> I will review this feature again next week...
> 
> 
>> I posted an alternative patch for review.
> 
> I'll review it early next week. I have few comments to add there.

Cool, thanks.
