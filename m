From: hch@lst.de (Christoph Hellwig)
Date: Wed, 3 Aug 2016 11:03:12 +0200
Subject: [PATCH v2 2/5] nvme-rdma: Remove duplicate call to
 nvme_remove_namespaces
In-Reply-To: <1470124419-30405-3-git-send-email-sagi@grimberg.me>
References: <1470124419-30405-1-git-send-email-sagi@grimberg.me>
 <1470124419-30405-3-git-send-email-sagi@grimberg.me>
Message-ID: <20160803090312.GA11321@lst.de>

On Tue, Aug 02, 2016@10:53:36AM +0300, Sagi Grimberg wrote:
> nvme_uninit_ctrl already does that for us. Note that we reordered
> nvme_rdma_shutdown_ctrl and nvme_uninit_ctrl, this is perfectly
> fine because we actually want ctrl uninit (aen, scan cancellation
> and namespaces removal) to happen before we shutdown the rdma
> resources.
> 
> Also, centralize the deletion work and the dead controller removal
> work code duplication into __nvme_rdma_shutdown_ctrl that accepts
> a shutdown boolean.

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
