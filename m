From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Dec 2017 02:25:04 -0800
Subject: [PATCH 4.15-rc 2/3] nvme-core/loop/rdma: Host delete_work and
 reset_work on system workqueues
In-Reply-To: <20171221100752.18386-3-sagi@grimberg.me>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-3-sagi@grimberg.me>
Message-ID: <20171221102503.GA11259@infradead.org>

On Thu, Dec 21, 2017@12:07:51PM +0200, Sagi Grimberg wrote:
> From: Roy Shterman <roys at lightbitslabs.com>
> 
> We need to ensure that delete_work will be hosted on a different
> workqueue than all the works we flush or cancel from it.
> Otherwise we may hit a circular dependency warning [1].
> 
> Also, given that delete_work flushes reset_work, host reset_work
> on system_wq and delete_work on system_long_wq. In addition,
> fix the flushing in the individual drivers to flush system_long_wq
> when draining queued deletes.

I vaguely remember pointing something like this out :)

I think we really need our own, separate WQ for this, e.g. a
nvme_reset_wq as reset progress under an swap / paging load is
essential and we need it isolated from the system.

Once we have that patch 1 is probably ok, but the patch adding
nvme_reset_wq should go before the current patch 1.  Also please
add good comments on the workqueue usage.
