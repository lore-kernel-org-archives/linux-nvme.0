From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 31 Dec 2017 11:51:32 +0200
Subject: [PATCH 4.15-rc 1/3] nvme-core: Don't set nvme_wq as MEM_RECLAIM
In-Reply-To: <20171229093501.GA23626@lst.de>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-2-sagi@grimberg.me>
 <20171221101741.GB17327@infradead.org>
 <fd880cf7-e815-fa63-b999-6381b145ffd8@grimberg.me>
 <20171221130002.GA4239@infradead.org>
 <f8cc93b5-a32a-f418-a65b-193ee530c481@grimberg.me>
 <20171221135402.GA12323@infradead.org>
 <3fb52238-1ff6-7ee5-65ba-8a9b5834daa3@grimberg.me>
 <20171229093501.GA23626@lst.de>
Message-ID: <f1d6cb4c-d49f-8b82-5ff2-08557c5cab27@grimberg.me>


>> We have three work types:
>> 1. async stuff like namespace scan, aen etc (which can allocate memory)
>> 2. reset which flushes (1) and allocates memory on its own (nvme queues
>> etc...)
>> 3. delete which flushes (2)
>>
>> Maybe it won't be so bad to have three global workqueues to host these
>> works?
> 
> Yes.  Or at least two given that we don't really a private workqueue
> for 1 I think.

We still need it with MEM_RECLAIM because we flush it from the other
workqueues. So we don't need a private workqueue, but we need it with
WQ_MEM_RECLAIM. So either we keep it or introduce system_memreclaim_wq..

Thoughts?
