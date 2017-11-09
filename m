From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 10:39:45 +0100
Subject: [PATCH v2 3/3] nvme-rdma: wait for local invalidation before
 completing a request
In-Reply-To: <20171108100616.26605-4-sagi@grimberg.me>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <20171108100616.26605-4-sagi@grimberg.me>
Message-ID: <20171109093945.GB17515@lst.de>

On Wed, Nov 08, 2017@12:06:16PM +0200, Sagi Grimberg wrote:
> We must not complete a request before the host memory region is
> invalidated. Luckily we have send with invalidate protocol support
> so we usually don't need to execute it, but in case the target
> did not invalidate a memory region for us, we must wait for
> the invalidation to complete before unmapping host memory and
> completing the I/O.

Looks good, but a change to atomic bitops would require a respin
here as well.
