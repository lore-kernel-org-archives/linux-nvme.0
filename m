From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Dec 2017 02:17:41 -0800
Subject: [PATCH 4.15-rc 1/3] nvme-core: Don't set nvme_wq as MEM_RECLAIM
In-Reply-To: <20171221100752.18386-2-sagi@grimberg.me>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-2-sagi@grimberg.me>
Message-ID: <20171221101741.GB17327@infradead.org>

On Thu, Dec 21, 2017@12:07:50PM +0200, Sagi Grimberg wrote:
> From: Roy Shterman <roys at lightbitslabs.com>
> 
> nvme_wq is not a MEM_RECLAIM workqueue because it
> can allocate memory in some of the works it is executing.

But we need reset to work while in memory reclaim.

So instead we'll need to make sure whatever memory allocation required
(which ones, btw?) are marked GFP_NOIO.
