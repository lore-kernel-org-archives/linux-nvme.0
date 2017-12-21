From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Dec 2017 05:00:50 -0800
Subject: [PATCH 4.15-rc 2/3] nvme-core/loop/rdma: Host delete_work and
 reset_work on system workqueues
In-Reply-To: <a963929a-46af-c9b9-5bf4-e172ca2f6d59@grimberg.me>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-3-sagi@grimberg.me>
 <20171221102503.GA11259@infradead.org>
 <a963929a-46af-c9b9-5bf4-e172ca2f6d59@grimberg.me>
Message-ID: <20171221130050.GB4239@infradead.org>

On Thu, Dec 21, 2017@12:43:53PM +0200, Sagi Grimberg wrote:
> > I think we really need our own, separate WQ for this, e.g. a
> > nvme_reset_wq as reset progress under an swap / paging load is
> > essential and we need it isolated from the system.
> 
> I agree, this was the thought when introducing nvme_wq.
> 
> So you are fine with keeping controller delete in system_wq
> (or system_long_wq)?

I'd keep delete on the reset workqueue.  If we can avoid depending
on too many system workqueues we're better off I think.
