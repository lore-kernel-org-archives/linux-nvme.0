From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Aug 2016 13:50:05 +0200
Subject: [PATCH v4] nvmet-rdma: Correctly handle RDMA device hot removal
In-Reply-To: <1470230393-23671-1-git-send-email-sagi@grimberg.me>
References: <1470230393-23671-1-git-send-email-sagi@grimberg.me>
Message-ID: <20160804115005.GB32487@lst.de>

On Wed, Aug 03, 2016@04:19:53PM +0300, Sagi Grimberg wrote:
> When configuring a device attached listener, we may
> see device removal events. In this case we return a
> non-zero return code from the cm event handler which
> implicitly destroys the cm_id. It is possible that in
> the future the user will remove this listener and by
> that trigger a second call to rdma_destroy_id on an
> already destroyed cm_id -> BUG.
> 
> In addition, when a queue bound (active session) cm_id
> generates a DEVICE_REMOVAL event we must guarantee all
> resources are cleaned up by the time we return from the
> event handler.
> 
> Introduce nvmet_rdma_device_removal which addresses
> (or at least attempts to) both scenarios.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
