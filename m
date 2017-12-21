From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Dec 2017 16:17:29 +0200
Subject: [PATCH 4.15-rc 1/3] nvme-core: Don't set nvme_wq as MEM_RECLAIM
In-Reply-To: <20171221135402.GA12323@infradead.org>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-2-sagi@grimberg.me>
 <20171221101741.GB17327@infradead.org>
 <fd880cf7-e815-fa63-b999-6381b145ffd8@grimberg.me>
 <20171221130002.GA4239@infradead.org>
 <f8cc93b5-a32a-f418-a65b-193ee530c481@grimberg.me>
 <20171221135402.GA12323@infradead.org>
Message-ID: <3fb52238-1ff6-7ee5-65ba-8a9b5834daa3@grimberg.me>


>> We cannot place the delete_work on the same workqueue as the reset_work
>> because we flush reset_work from nvme_delete_ctrl (this is what this
>> patch is trying to prevent).
> 
> Ok..
> 
> Seems like we should instead have a single-thread MEM_RECLAIM
> workqueue per nvme controller for reset and remove as that would
> implicitly serialize remove and delete.
> 
> Alternatively we could use the reset_work for removal as well.
> In fact it already has the removal and we'd just need to add
> a goto for that case if we are in deleting state, e.g. something
> like the patch below, just for rdma without the core and other
> transport bits:

The problem I have with these two suggestions is that in my mind,
delete_ctrl should never fail because there is inflight reset.

Also consider what should we do in module unload where we trigger
delete of all active controllers, we'd need some retry mechanism
to clean them up.

We have three work types:
1. async stuff like namespace scan, aen etc (which can allocate memory)
2. reset which flushes (1) and allocates memory on its own (nvme queues
etc...)
3. delete which flushes (2)

Maybe it won't be so bad to have three global workqueues to host these
works?
