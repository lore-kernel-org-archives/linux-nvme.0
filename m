From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Dec 2017 05:00:02 -0800
Subject: [PATCH 4.15-rc 1/3] nvme-core: Don't set nvme_wq as MEM_RECLAIM
In-Reply-To: <fd880cf7-e815-fa63-b999-6381b145ffd8@grimberg.me>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-2-sagi@grimberg.me>
 <20171221101741.GB17327@infradead.org>
 <fd880cf7-e815-fa63-b999-6381b145ffd8@grimberg.me>
Message-ID: <20171221130002.GA4239@infradead.org>

On Thu, Dec 21, 2017@12:41:30PM +0200, Sagi Grimberg wrote:
> AFAIK, WQ_MEM_RECLAIM means that this workqueue can be drained
> for memory reclaim, which means that a workqueue that hosts works
> that are allocating memory cannot be such a workqueue.

No.  WQ_MEM_RECLAIM means it has a dededicated rescuer execution
thread and is guaranteed to make forward progress even under grave
memory pressure.

> How does this patch make reset not work in memory reclaim? memory
> reclaim will drain workqueues that *are* reclaimable workqueues.

Without WQ_MEM_RECLAIM we might not be able to execute the reset
due to the overhead of starting a new helper thread to execute it.

> > So instead we'll need to make sure whatever memory allocation required
> > (which ones, btw?) are marked GFP_NOIO.
> 
> namespace scannig can allocate new namespaces.

Ok, makes sense.
