From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Dec 2017 15:17:10 +0200
Subject: [PATCH 4.15-rc 1/3] nvme-core: Don't set nvme_wq as MEM_RECLAIM
In-Reply-To: <20171221130002.GA4239@infradead.org>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-2-sagi@grimberg.me>
 <20171221101741.GB17327@infradead.org>
 <fd880cf7-e815-fa63-b999-6381b145ffd8@grimberg.me>
 <20171221130002.GA4239@infradead.org>
Message-ID: <f8cc93b5-a32a-f418-a65b-193ee530c481@grimberg.me>


>> AFAIK, WQ_MEM_RECLAIM means that this workqueue can be drained
>> for memory reclaim, which means that a workqueue that hosts works
>> that are allocating memory cannot be such a workqueue.
> 
> No.  WQ_MEM_RECLAIM means it has a dededicated rescuer execution
> thread and is guaranteed to make forward progress even under grave
> memory pressure.
> 
>> How does this patch make reset not work in memory reclaim? memory
>> reclaim will drain workqueues that *are* reclaimable workqueues.
> 
> Without WQ_MEM_RECLAIM we might not be able to execute the reset
> due to the overhead of starting a new helper thread to execute it.

OK, thanks for the education :)

Note that the we need to make sure to not flush workqueue !MEM_RECLAIM
from a workqueue that is MEM_RECLAIM and vice-versa (if we do we will
can trigger deadlocks in severe memory pressure.

We cannot place the delete_work on the same workqueue as the reset_work
because we flush reset_work from nvme_delete_ctrl (this is what this
patch is trying to prevent).

We need a separate workqueue for it, or we can use system_long_wq
(however this would require making nvme_wq and nvme_reset_wq without
WQ_MEM_RECLAIM). Or, we introduce a new system_memreclaim_wq?

delete_ctrl does not need MEM_RECLAIM, but it flushes workqueues that
does need MEM_RECLAIM.
