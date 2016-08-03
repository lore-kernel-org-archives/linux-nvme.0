From: hch@lst.de (Christoph Hellwig)
Date: Wed, 3 Aug 2016 11:04:06 +0200
Subject: [PATCH v2 5/5] nvme-rdma: Make sure to shutdown the controller
 if we can
In-Reply-To: <1470124419-30405-6-git-send-email-sagi@grimberg.me>
References: <1470124419-30405-1-git-send-email-sagi@grimberg.me>
 <1470124419-30405-6-git-send-email-sagi@grimberg.me>
Message-ID: <20160803090406.GD11321@lst.de>

On Tue, Aug 02, 2016@10:53:39AM +0300, Sagi Grimberg wrote:
> Relying on ctrl state in nvme_rdma_shutdown_ctrl is wrong because
> it will never be NVME_CTRL_LIVE (delete_ctrl or reset_ctrl invoked it).
> 
> Instead, check that the admin queue is connected. Note that it is safe
> because we can never see a copmeting thread trying to destroy the admin
> queue (reset or delete controller).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
