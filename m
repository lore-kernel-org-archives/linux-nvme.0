From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 10:35:01 +0100
Subject: [PATCH 4.15-rc 1/3] nvme-core: Don't set nvme_wq as MEM_RECLAIM
In-Reply-To: <3fb52238-1ff6-7ee5-65ba-8a9b5834daa3@grimberg.me>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-2-sagi@grimberg.me>
 <20171221101741.GB17327@infradead.org>
 <fd880cf7-e815-fa63-b999-6381b145ffd8@grimberg.me>
 <20171221130002.GA4239@infradead.org>
 <f8cc93b5-a32a-f418-a65b-193ee530c481@grimberg.me>
 <20171221135402.GA12323@infradead.org>
 <3fb52238-1ff6-7ee5-65ba-8a9b5834daa3@grimberg.me>
Message-ID: <20171229093501.GA23626@lst.de>

On Thu, Dec 21, 2017@04:17:29PM +0200, Sagi Grimberg wrote:
> We have three work types:
> 1. async stuff like namespace scan, aen etc (which can allocate memory)
> 2. reset which flushes (1) and allocates memory on its own (nvme queues
> etc...)
> 3. delete which flushes (2)
>
> Maybe it won't be so bad to have three global workqueues to host these
> works?

Yes.  Or at least two given that we don't really a private workqueue
for 1 I think.
