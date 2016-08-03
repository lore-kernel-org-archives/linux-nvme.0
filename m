From: hch@lst.de (Christoph Hellwig)
Date: Wed, 3 Aug 2016 11:03:46 +0200
Subject: [PATCH v2 4/5] nvme-loop: Remove duplicate call to
 nvme_remove_namespaces
In-Reply-To: <1470124419-30405-5-git-send-email-sagi@grimberg.me>
References: <1470124419-30405-1-git-send-email-sagi@grimberg.me>
 <1470124419-30405-5-git-send-email-sagi@grimberg.me>
Message-ID: <20160803090346.GC11321@lst.de>

On Tue, Aug 02, 2016@10:53:38AM +0300, Sagi Grimberg wrote:
> nvme_uninit_ctrl already does that for us. Note that we
> reordered nvme_loop_shutdown_ctrl with nvme_uninit_ctrl
> but its safe because we want controller uninit to happen
> before we shutdown the transport resources.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
