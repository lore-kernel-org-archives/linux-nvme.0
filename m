From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Dec 2017 12:41:30 +0200
Subject: [PATCH 4.15-rc 1/3] nvme-core: Don't set nvme_wq as MEM_RECLAIM
In-Reply-To: <20171221101741.GB17327@infradead.org>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-2-sagi@grimberg.me>
 <20171221101741.GB17327@infradead.org>
Message-ID: <fd880cf7-e815-fa63-b999-6381b145ffd8@grimberg.me>


>> From: Roy Shterman <roys at lightbitslabs.com>
>>
>> nvme_wq is not a MEM_RECLAIM workqueue because it
>> can allocate memory in some of the works it is executing.
> 
> But we need reset to work while in memory reclaim.

AFAIK, WQ_MEM_RECLAIM means that this workqueue can be drained
for memory reclaim, which means that a workqueue that hosts works
that are allocating memory cannot be such a workqueue.

How does this patch make reset not work in memory reclaim? memory
reclaim will drain workqueues that *are* reclaimable workqueues.

> So instead we'll need to make sure whatever memory allocation required
> (which ones, btw?) are marked GFP_NOIO.

namespace scannig can allocate new namespaces.
