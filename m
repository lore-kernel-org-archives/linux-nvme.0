From: hch@lst.de (Christoph Hellwig)
Date: Wed, 3 Aug 2016 11:03:30 +0200
Subject: [PATCH v2 3/5] nvme-rdma: Free the I/O tags when we delete the
 controller
In-Reply-To: <1470124419-30405-4-git-send-email-sagi@grimberg.me>
References: <1470124419-30405-1-git-send-email-sagi@grimberg.me>
 <1470124419-30405-4-git-send-email-sagi@grimberg.me>
Message-ID: <20160803090330.GB11321@lst.de>

On Tue, Aug 02, 2016@10:53:37AM +0300, Sagi Grimberg wrote:
> If we wait until we free the controller (free_ctrl) we might
> lose our rdma device without any notification while we still
> have open resources (tags mrs and dma mappings).
> 
> Instead, destroy the tags with their rdma resources once we
> delete the device and not when freeing it.
> 
> Note that we don't do that in nvme_rdma_shutdown_ctrl because
> controller reset uses it as well and we want to give active I/O
> a chance to complete successfully.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
